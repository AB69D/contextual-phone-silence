package com.yonderchat.contextual_silence.alarm

import android.content.Context
import android.media.AudioManager
import android.app.NotificationManager

object AudioStateManager {
    private const val PREFS_NAME = "audio_snapshot"
    private const val KEY_RINGER_MODE = "ringer_mode"
    private const val KEY_DND_FILTER = "dnd_filter"
    private const val KEY_VOLUME_RING = "volume_ring"
    private const val KEY_VOLUME_NOTIFICATION = "volume_notification"
    private const val KEY_VOLUME_MUSIC = "volume_music"
    private const val KEY_VOLUME_ALARM = "volume_alarm"

    fun snapshotAndSilence(ctx: Context) {
        val am = ctx.getSystemService(AudioManager::class.java)
        val nm = ctx.getSystemService(NotificationManager::class.java)
        val prefs = ctx.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)

        // Snapshot to disk first — survives process death
        prefs.edit()
            .putInt(KEY_RINGER_MODE, am.ringerMode)
            .putInt(KEY_DND_FILTER, nm.currentInterruptionFilter)
            .putInt(KEY_VOLUME_RING, am.getStreamVolume(AudioManager.STREAM_RING))
            .putInt(KEY_VOLUME_NOTIFICATION, am.getStreamVolume(AudioManager.STREAM_NOTIFICATION))
            .putInt(KEY_VOLUME_MUSIC, am.getStreamVolume(AudioManager.STREAM_MUSIC))
            .putInt(KEY_VOLUME_ALARM, am.getStreamVolume(AudioManager.STREAM_ALARM))
            .apply()

        // Belt AND suspenders: DND + ringer mode
        if (nm.isNotificationPolicyAccessGranted) {
            nm.setInterruptionFilter(NotificationManager.INTERRUPTION_FILTER_NONE)
        }
        try {
            am.ringerMode = AudioManager.RINGER_MODE_SILENT
        } catch (e: Exception) {
            // SecurityException on some OEMs without DND permission — DND path above covers it
        }
    }

    fun restore(ctx: Context) {
        val prefs = ctx.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
        if (!prefs.contains(KEY_RINGER_MODE)) return

        val am = ctx.getSystemService(AudioManager::class.java)
        val nm = ctx.getSystemService(NotificationManager::class.java)

        // Restore DND first, then ringer, then volumes
        if (nm.isNotificationPolicyAccessGranted) {
            nm.setInterruptionFilter(
                prefs.getInt(KEY_DND_FILTER, NotificationManager.INTERRUPTION_FILTER_ALL)
            )
        }
        try {
            am.ringerMode = prefs.getInt(KEY_RINGER_MODE, AudioManager.RINGER_MODE_NORMAL)
        } catch (e: Exception) { /* ignore */ }

        listOf(
            AudioManager.STREAM_RING to KEY_VOLUME_RING,
            AudioManager.STREAM_NOTIFICATION to KEY_VOLUME_NOTIFICATION,
            AudioManager.STREAM_MUSIC to KEY_VOLUME_MUSIC,
            AudioManager.STREAM_ALARM to KEY_VOLUME_ALARM,
        ).forEach { (stream, key) ->
            try {
                am.setStreamVolume(stream, prefs.getInt(key, 5), 0)
            } catch (e: Exception) { /* ignore — some streams uncontrollable in silent */ }
        }

        prefs.edit().clear().apply()
    }

    fun isSilenced(ctx: Context): Boolean =
        ctx.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
            .contains(KEY_RINGER_MODE)

    fun getAudioState(ctx: Context): Map<String, Any?> {
        val am = ctx.getSystemService(AudioManager::class.java)
        val nm = ctx.getSystemService(NotificationManager::class.java)
        return mapOf(
            "ringerMode" to am.ringerMode,
            "dndActive" to (nm.currentInterruptionFilter != NotificationManager.INTERRUPTION_FILTER_ALL),
            "dndFilter" to nm.currentInterruptionFilter,
            "hasDndPermission" to nm.isNotificationPolicyAccessGranted,
            "isManagedSilent" to isSilenced(ctx),
            "volumeRing" to am.getStreamVolume(AudioManager.STREAM_RING),
            "volumeNotification" to am.getStreamVolume(AudioManager.STREAM_NOTIFICATION),
            "volumeMusic" to am.getStreamVolume(AudioManager.STREAM_MUSIC),
            "volumeAlarm" to am.getStreamVolume(AudioManager.STREAM_ALARM),
        )
    }
}
