package com.yonderchat.contextual_silence.alarm

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import androidx.work.ExistingPeriodicWorkPolicy
import androidx.work.OneTimeWorkRequestBuilder
import androidx.work.PeriodicWorkRequestBuilder
import androidx.work.WorkManager
import java.util.concurrent.TimeUnit

class BootReceiver : BroadcastReceiver() {

    override fun onReceive(ctx: Context, intent: Intent) {
        when (intent.action) {
            Intent.ACTION_BOOT_COMPLETED,
            "android.intent.action.QUICKBOOT_POWERON",
            Intent.ACTION_MY_PACKAGE_REPLACED -> {
                handleBoot(ctx)
            }
        }
    }

    private fun handleBoot(ctx: Context) {
        // If device rebooted mid-session, restore audio immediately
        if (AudioStateManager.isSilenced(ctx)) {
            AudioStateManager.restore(ctx)
        }

        val wm = WorkManager.getInstance(ctx)

        // One-shot immediate sync to re-register all upcoming alarms
        wm.enqueue(
            OneTimeWorkRequestBuilder<CalendarSyncWorker>()
                .addTag("boot_sync")
                .build()
        )

        // Resume 15-min periodic sync
        wm.enqueueUniquePeriodicWork(
            CalendarSyncWorker.WORK_NAME,
            ExistingPeriodicWorkPolicy.KEEP,
            PeriodicWorkRequestBuilder<CalendarSyncWorker>(15, TimeUnit.MINUTES)
                .addTag("periodic_sync")
                .build()
        )
    }
}
