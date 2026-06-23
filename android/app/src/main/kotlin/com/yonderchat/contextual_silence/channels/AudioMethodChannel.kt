package com.yonderchat.contextual_silence.channels

import android.app.NotificationManager
import android.content.Context
import android.media.AudioManager
import com.yonderchat.contextual_silence.alarm.AudioStateManager
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class AudioMethodChannel(private val ctx: Context) : MethodChannel.MethodCallHandler {

    companion object {
        const val CHANNEL = "com.yonderchat.contextual_silence/audio"
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "getAudioState" -> result.success(AudioStateManager.getAudioState(ctx))
            "silence" -> {
                AudioStateManager.snapshotAndSilence(ctx)
                result.success(mapOf("success" to true))
            }
            "restore" -> {
                AudioStateManager.restore(ctx)
                result.success(mapOf("success" to true))
            }
            "isSilenced" -> result.success(AudioStateManager.isSilenced(ctx))
            "getRingerMode" -> {
                val am = ctx.getSystemService(AudioManager::class.java)
                result.success(am.ringerMode)
            }
            "setRingerMode" -> {
                val mode = call.argument<Int>("mode") ?: 2
                val am = ctx.getSystemService(AudioManager::class.java)
                try {
                    am.ringerMode = mode
                    result.success(mapOf("success" to true))
                } catch (e: Exception) {
                    result.error("AUDIO_ERROR", e.message, null)
                }
            }
            else -> result.notImplemented()
        }
    }
}
