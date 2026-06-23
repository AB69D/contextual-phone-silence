package com.yonderchat.contextual_silence.channels

import android.Manifest
import android.app.NotificationManager
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.os.PowerManager
import android.provider.Settings
import androidx.core.content.ContextCompat
import com.yonderchat.contextual_silence.alarm.AlarmScheduler
import com.yonderchat.contextual_silence.alarm.OemBatteryHelper
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class PermissionMethodChannel(private val ctx: Context) : MethodChannel.MethodCallHandler {

    companion object {
        const val CHANNEL = "com.yonderchat.contextual_silence/permissions"
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "checkAll" -> result.success(checkAll())
            "openDndSettings" -> {
                startActivity(Intent(Settings.ACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS))
                result.success(null)
            }
            "openExactAlarmSettings" -> {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                    startActivity(Intent(Settings.ACTION_REQUEST_SCHEDULE_EXACT_ALARM,
                        Uri.parse("package:${ctx.packageName}")))
                }
                result.success(null)
            }
            "openBatteryOptimizationSettings" -> {
                try {
                    startActivity(Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS,
                        Uri.parse("package:${ctx.packageName}")))
                } catch (e: Exception) {
                    startActivity(Intent(Settings.ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS))
                }
                result.success(null)
            }
            "getOemBatterySteps" -> {
                val steps = OemBatteryHelper.getSteps(ctx).map { OemBatteryHelper.toMap(it) }
                result.success(steps)
            }
            "launchOemBatteryStep" -> {
                val stepIndex = call.argument<Int>("stepIndex") ?: 0
                val steps = OemBatteryHelper.getSteps(ctx)
                steps.getOrNull(stepIndex)?.intent?.let { startActivity(it) }
                result.success(null)
            }
            "openAppSettings" -> {
                startActivity(Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS,
                    Uri.parse("package:${ctx.packageName}")))
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    private fun checkAll(): Map<String, Any?> {
        val nm = ctx.getSystemService(NotificationManager::class.java)
        val pm = ctx.getSystemService(PowerManager::class.java)
        val oemType = OemBatteryHelper.getOemType(ctx)
        val hasOemSteps = OemBatteryHelper.getSteps(ctx).isNotEmpty()

        val hasExactAlarm = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            (ctx.getSystemService(android.app.AlarmManager::class.java)).canScheduleExactAlarms()
        } else true

        return mapOf(
            "calendarRead" to (ContextCompat.checkSelfPermission(ctx,
                Manifest.permission.READ_CALENDAR) == PackageManager.PERMISSION_GRANTED),
            "dndAccess" to nm.isNotificationPolicyAccessGranted,
            "exactAlarm" to hasExactAlarm,
            "batteryOptimizationExcluded" to pm.isIgnoringBatteryOptimizations(ctx.packageName),
            "oemType" to oemType,
            "hasOemSpecificSteps" to hasOemSteps,
        )
    }

    private fun startActivity(intent: Intent) {
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        ctx.startActivity(intent)
    }
}
