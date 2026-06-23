package com.yonderchat.contextual_silence.channels

import android.content.Context
import androidx.work.ExistingPeriodicWorkPolicy
import androidx.work.OneTimeWorkRequestBuilder
import androidx.work.PeriodicWorkRequestBuilder
import androidx.work.WorkManager
import com.yonderchat.contextual_silence.alarm.AlarmScheduler
import com.yonderchat.contextual_silence.alarm.CalendarSyncWorker
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.concurrent.TimeUnit

class AlarmMethodChannel(private val ctx: Context) : MethodChannel.MethodCallHandler {

    companion object {
        const val CHANNEL = "com.yonderchat.contextual_silence/alarm"
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "scheduleEvent" -> {
                val eventId = call.argument<String>("eventId") ?: run {
                    result.error("INVALID_ARGS", "eventId required", null); return
                }
                val title = call.argument<String>("title") ?: ""
                val startMs = call.argument<Long>("startMs") ?: 0L
                val endMs = call.argument<Long>("endMs") ?: 0L
                AlarmScheduler.scheduleEvent(ctx, eventId, title, startMs, endMs)
                result.success(mapOf("success" to true))
            }
            "cancelEvent" -> {
                val eventId = call.argument<String>("eventId") ?: run {
                    result.error("INVALID_ARGS", "eventId required", null); return
                }
                AlarmScheduler.cancelEvent(ctx, eventId)
                result.success(mapOf("success" to true))
            }
            "canScheduleExactAlarms" ->
                result.success(AlarmScheduler.canScheduleExactAlarms(ctx))
            "startPeriodicSync" -> {
                WorkManager.getInstance(ctx).enqueueUniquePeriodicWork(
                    CalendarSyncWorker.WORK_NAME,
                    ExistingPeriodicWorkPolicy.KEEP,
                    PeriodicWorkRequestBuilder<CalendarSyncWorker>(15, TimeUnit.MINUTES).build()
                )
                result.success(null)
            }
            "stopPeriodicSync" -> {
                WorkManager.getInstance(ctx)
                    .cancelUniqueWork(CalendarSyncWorker.WORK_NAME)
                result.success(null)
            }
            "triggerImmediateSync" -> {
                WorkManager.getInstance(ctx)
                    .enqueue(OneTimeWorkRequestBuilder<CalendarSyncWorker>().build())
                result.success(null)
            }
            "getPendingAlarmCount" -> {
                // Returns the number of pending WorkManager sync tasks as a health indicator
                val info = WorkManager.getInstance(ctx)
                    .getWorkInfosByTag("periodic_sync").get()
                result.success(info?.size ?: 0)
            }
            else -> result.notImplemented()
        }
    }
}
