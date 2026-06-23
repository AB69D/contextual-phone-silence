package com.yonderchat.contextual_silence

import com.yonderchat.contextual_silence.channels.AlarmMethodChannel
import com.yonderchat.contextual_silence.channels.AudioMethodChannel
import com.yonderchat.contextual_silence.channels.CalendarMethodChannel
import com.yonderchat.contextual_silence.channels.PermissionMethodChannel
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val messenger = flutterEngine.dartExecutor.binaryMessenger

        MethodChannel(messenger, CalendarMethodChannel.CHANNEL)
            .setMethodCallHandler(CalendarMethodChannel(this))

        MethodChannel(messenger, AudioMethodChannel.CHANNEL)
            .setMethodCallHandler(AudioMethodChannel(this))

        MethodChannel(messenger, AlarmMethodChannel.CHANNEL)
            .setMethodCallHandler(AlarmMethodChannel(this))

        MethodChannel(messenger, PermissionMethodChannel.CHANNEL)
            .setMethodCallHandler(PermissionMethodChannel(this))
    }
}
