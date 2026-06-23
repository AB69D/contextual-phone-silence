package com.yonderchat.contextual_silence.alarm

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build

object AlarmScheduler {
    const val ACTION_START = "com.yonderchat.contextual_silence.ACTION_SILENCE_START"
    const val ACTION_END = "com.yonderchat.contextual_silence.ACTION_SILENCE_END"

    fun scheduleEvent(
        ctx: Context,
        eventId: String,
        title: String,
        startMs: Long,
        endMs: Long
    ) {
        val am = ctx.getSystemService(AlarmManager::class.java)
        if (Build.VERSION.SDK_INT >= 31 && !am.canScheduleExactAlarms()) return

        val startCode = Math.abs(eventId.hashCode()) % 500_000
        val endCode = startCode + 500_000

        am.setExactAndAllowWhileIdle(
            AlarmManager.RTC_WAKEUP,
            startMs,
            makeIntent(ctx, ACTION_START, startCode, eventId, title, endMs)
        )
        am.setExactAndAllowWhileIdle(
            AlarmManager.RTC_WAKEUP,
            endMs,
            makeIntent(ctx, ACTION_END, endCode, eventId, title, endMs)
        )
    }

    fun cancelEvent(ctx: Context, eventId: String) {
        val am = ctx.getSystemService(AlarmManager::class.java)
        val startCode = Math.abs(eventId.hashCode()) % 500_000
        val endCode = startCode + 500_000

        listOf(startCode, endCode).forEach { code ->
            val intent = Intent(ctx, SilenceAlarmReceiver::class.java)
            val pi = PendingIntent.getBroadcast(
                ctx, code, intent,
                PendingIntent.FLAG_NO_CREATE or PendingIntent.FLAG_IMMUTABLE
            )
            pi?.let { am.cancel(it) }
        }
    }

    private fun makeIntent(
        ctx: Context,
        action: String,
        code: Int,
        eventId: String,
        title: String,
        endMs: Long
    ): PendingIntent {
        val i = Intent(ctx, SilenceAlarmReceiver::class.java).apply {
            this.action = action
            putExtra("eventId", eventId)
            putExtra("title", title)
            putExtra("endMs", endMs)
        }
        return PendingIntent.getBroadcast(
            ctx, code, i,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
    }

    fun canScheduleExactAlarms(ctx: Context): Boolean {
        val am = ctx.getSystemService(AlarmManager::class.java)
        return if (Build.VERSION.SDK_INT >= 31) am.canScheduleExactAlarms() else true
    }
}
