package com.yonderchat.contextual_silence.alarm

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import androidx.core.app.NotificationCompat
import com.yonderchat.contextual_silence.R

class SilenceAlarmReceiver : BroadcastReceiver() {

    override fun onReceive(ctx: Context, intent: Intent) {
        when (intent.action) {
            AlarmScheduler.ACTION_START -> handleStart(ctx, intent)
            AlarmScheduler.ACTION_END -> handleEnd(ctx, intent)
        }
    }

    private fun handleStart(ctx: Context, intent: Intent) {
        val eventId = intent.getStringExtra("eventId") ?: return
        val title = intent.getStringExtra("title") ?: "Meeting"
        val endMs = intent.getLongExtra("endMs", 0L)

        AudioStateManager.snapshotAndSilence(ctx)
        postOngoingNotification(ctx, eventId, title, endMs)
    }

    private fun handleEnd(ctx: Context, intent: Intent) {
        val eventId = intent.getStringExtra("eventId") ?: return
        AudioStateManager.restore(ctx)
        cancelOngoingNotification(ctx, eventId)
    }

    private fun postOngoingNotification(
        ctx: Context,
        eventId: String,
        title: String,
        endMs: Long
    ) {
        val nm = ctx.getSystemService(NotificationManager::class.java)
        ensureChannel(nm)

        val endEarlyIntent = Intent(ctx, SilenceAlarmReceiver::class.java).apply {
            action = AlarmScheduler.ACTION_END
            putExtra("eventId", eventId)
            putExtra("title", title)
        }
        val endEarlyPi = PendingIntent.getBroadcast(
            ctx,
            Math.abs(eventId.hashCode()) % 500_000 + 1_000_000,
            endEarlyIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        val endTime = if (endMs > 0) {
            val cal = java.util.Calendar.getInstance()
            cal.timeInMillis = endMs
            String.format("%02d:%02d", cal.get(java.util.Calendar.HOUR_OF_DAY),
                cal.get(java.util.Calendar.MINUTE))
        } else "—"

        val notif = NotificationCompat.Builder(ctx, CHANNEL_ID)
            .setSmallIcon(android.R.drawable.ic_lock_silent_mode)
            .setContentTitle("Silent — $title")
            .setContentText("Until $endTime")
            .setOngoing(true)
            .setPriority(NotificationCompat.PRIORITY_LOW)
            .addAction(android.R.drawable.ic_media_play, "End early", endEarlyPi)
            .build()

        nm.notify(notifId(eventId), notif)
    }

    private fun cancelOngoingNotification(ctx: Context, eventId: String) {
        val nm = ctx.getSystemService(NotificationManager::class.java)
        nm.cancel(notifId(eventId))
    }

    private fun ensureChannel(nm: NotificationManager) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val ch = NotificationChannel(
                CHANNEL_ID, "Active Silence",
                NotificationManager.IMPORTANCE_LOW
            ).apply { description = "Shown while your phone is silenced" }
            nm.createNotificationChannel(ch)
        }
    }

    private fun notifId(eventId: String) =
        Math.abs(eventId.hashCode()) % 100_000 + 200_000

    companion object {
        const val CHANNEL_ID = "silence_active"
    }
}
