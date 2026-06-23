package com.yonderchat.contextual_silence.alarm

import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager

object OemBatteryHelper {

    data class OemStep(val stepIndex: Int, val label: String, val instructions: String, val intent: Intent?)

    fun getOemType(ctx: Context): String {
        return when {
            isPackageInstalled(ctx, "com.samsung.android.lool") -> "samsung"
            isPackageInstalled(ctx, "com.miui.powerkeeper") ||
                isPackageInstalled(ctx, "com.miui.securitycenter") -> "xiaomi"
            isPackageInstalled(ctx, "com.huawei.systemmanager") -> "huawei"
            isPackageInstalled(ctx, "com.coloros.safecenter") -> "oppo"
            isPackageInstalled(ctx, "com.oneplus.security") -> "oneplus"
            else -> "stock"
        }
    }

    fun getSteps(ctx: Context): List<OemStep> = when (getOemType(ctx)) {
        "samsung" -> listOf(
            OemStep(0, "Open Device Care",
                "Go to Settings > Device Care > Battery > Background usage limits",
                ctx.packageManager.getLaunchIntentForPackage("com.samsung.android.lool"))
        )
        "xiaomi" -> listOf(
            OemStep(0, "Enable AutoStart",
                "Go to Settings > Apps > Manage apps > Contextual Silence > Autostart > Enable",
                ctx.packageManager.getLaunchIntentForPackage("com.miui.securitycenter")),
            OemStep(1, "Open PowerKeeper",
                "Go to Security > Battery > select the app > No restrictions",
                ctx.packageManager.getLaunchIntentForPackage("com.miui.powerkeeper"))
        )
        "huawei" -> listOf(
            OemStep(0, "Allow background activity",
                "Go to Settings > Battery > App launch > Contextual Silence > Manage manually > Enable all",
                ctx.packageManager.getLaunchIntentForPackage("com.huawei.systemmanager"))
        )
        "oppo" -> listOf(
            OemStep(0, "Allow background running",
                "Go to Settings > Battery > App Energy Saving > select app > No restrictions",
                ctx.packageManager.getLaunchIntentForPackage("com.coloros.safecenter"))
        )
        "oneplus" -> listOf(
            OemStep(0, "Allow running in background",
                "Go to Settings > Battery > Background app management > select app > Allow",
                ctx.packageManager.getLaunchIntentForPackage("com.oneplus.security"))
        )
        else -> emptyList()
    }

    fun toMap(step: OemStep): Map<String, Any?> = mapOf(
        "stepIndex" to step.stepIndex,
        "label" to step.label,
        "instructions" to step.instructions,
    )

    private fun isPackageInstalled(ctx: Context, pkg: String): Boolean = try {
        ctx.packageManager.getPackageInfo(pkg, 0)
        true
    } catch (e: PackageManager.NameNotFoundException) {
        false
    }
}
