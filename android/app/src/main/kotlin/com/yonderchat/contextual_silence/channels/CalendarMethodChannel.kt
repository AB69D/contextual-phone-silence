package com.yonderchat.contextual_silence.channels

import android.Manifest
import android.content.ContentUris
import android.content.Context
import android.content.pm.PackageManager
import android.net.Uri
import android.provider.CalendarContract
import androidx.core.content.ContextCompat
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class CalendarMethodChannel(private val ctx: Context) : MethodChannel.MethodCallHandler {

    companion object {
        const val CHANNEL = "com.yonderchat.contextual_silence/calendar"
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "hasPermission" -> result.success(hasCalendarPermission())
            "requestPermission" -> {
                // Runtime permission is handled by Flutter permission_handler plugin.
                // This method just returns current status.
                result.success(hasCalendarPermission())
            }
            "getEvents" -> {
                if (!hasCalendarPermission()) {
                    result.error("PERMISSION_DENIED", "Calendar permission not granted", null)
                    return
                }
                val fromMillis = call.argument<Long>("fromMillis") ?: System.currentTimeMillis()
                val toMillis = call.argument<Long>("toMillis") ?: (fromMillis + 86_400_000L)
                result.success(queryInstances(fromMillis, toMillis))
            }
            "getEventById" -> {
                if (!hasCalendarPermission()) {
                    result.error("PERMISSION_DENIED", "Calendar permission not granted", null)
                    return
                }
                val eventId = call.argument<String>("eventId")
                result.success(queryEventById(eventId))
            }
            "getCalendars" -> {
                if (!hasCalendarPermission()) {
                    result.error("PERMISSION_DENIED", "Calendar permission not granted", null)
                    return
                }
                result.success(queryCalendars())
            }
            else -> result.notImplemented()
        }
    }

    private fun hasCalendarPermission(): Boolean =
        ContextCompat.checkSelfPermission(ctx, Manifest.permission.READ_CALENDAR) ==
            PackageManager.PERMISSION_GRANTED

    private fun queryInstances(fromMs: Long, toMs: Long): List<Map<String, Any?>> {
        val projection = arrayOf(
            CalendarContract.Instances.EVENT_ID,
            CalendarContract.Instances.TITLE,
            CalendarContract.Instances.BEGIN,
            CalendarContract.Instances.END,
            CalendarContract.Instances.CALENDAR_ID,
            CalendarContract.Instances.CALENDAR_DISPLAY_NAME,
            CalendarContract.Instances.ALL_DAY,
            CalendarContract.Instances.EVENT_LOCATION,
            CalendarContract.Instances.DESCRIPTION,
            CalendarContract.Instances.CALENDAR_COLOR,
        )

        val builder = CalendarContract.Instances.CONTENT_URI.buildUpon()
        ContentUris.appendId(builder, fromMs)
        ContentUris.appendId(builder, toMs)

        val results = mutableListOf<Map<String, Any?>>()
        ctx.contentResolver.query(
            builder.build(), projection,
            "${CalendarContract.Instances.STATUS} != ?",
            arrayOf(CalendarContract.Instances.STATUS_CANCELED.toString()),
            "${CalendarContract.Instances.BEGIN} ASC"
        )?.use { cursor ->
            while (cursor.moveToNext()) {
                val colorInt = cursor.getInt(9)
                val colorHex = if (colorInt != 0) String.format("#%06X", 0xFFFFFF and colorInt) else null
                results.add(mapOf(
                    "eventId" to cursor.getString(0),
                    "title" to (cursor.getString(1) ?: "(No title)"),
                    "startMs" to cursor.getLong(2),
                    "endMs" to cursor.getLong(3),
                    "calendarId" to cursor.getString(4),
                    "calendarName" to (cursor.getString(5) ?: ""),
                    "allDay" to (cursor.getInt(6) == 1),
                    "location" to cursor.getString(7),
                    "description" to cursor.getString(8),
                    "colorHex" to colorHex,
                ))
            }
        }
        return results
    }

    private fun queryEventById(eventId: String?): Map<String, Any?>? {
        if (eventId == null) return null
        val now = System.currentTimeMillis()
        return queryInstances(now - 86_400_000L, now + 7 * 86_400_000L)
            .firstOrNull { it["eventId"] == eventId }
    }

    private fun queryCalendars(): List<Map<String, Any?>> {
        val projection = arrayOf(
            CalendarContract.Calendars._ID,
            CalendarContract.Calendars.CALENDAR_DISPLAY_NAME,
            CalendarContract.Calendars.ACCOUNT_NAME,
            CalendarContract.Calendars.CALENDAR_COLOR,
            CalendarContract.Calendars.VISIBLE,
            CalendarContract.Calendars.IS_PRIMARY,
        )
        val results = mutableListOf<Map<String, Any?>>()
        ctx.contentResolver.query(
            CalendarContract.Calendars.CONTENT_URI, projection,
            null, null, null
        )?.use { cursor ->
            while (cursor.moveToNext()) {
                val colorInt = cursor.getInt(3)
                results.add(mapOf(
                    "id" to cursor.getLong(0).toString(),
                    "displayName" to cursor.getString(1),
                    "accountName" to cursor.getString(2),
                    "colorHex" to String.format("#%06X", 0xFFFFFF and colorInt),
                    "visible" to (cursor.getInt(4) == 1),
                    "isPrimary" to (cursor.getInt(5) == 1),
                ))
            }
        }
        return results
    }
}
