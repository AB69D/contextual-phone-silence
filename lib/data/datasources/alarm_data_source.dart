import 'package:flutter/services.dart';
import '../../core/constants/app_constants.dart';
import '../../core/error/failures.dart';

class AlarmDataSource {
  static const _channel = MethodChannel(AppConstants.channelAlarm);

  Future<bool> scheduleEvent({
    required String eventId,
    required String title,
    required int startMs,
    required int endMs,
  }) async {
    try {
      final result = await _channel.invokeMethod<Map>('scheduleEvent', {
        'eventId': eventId,
        'title': title,
        'startMs': startMs,
        'endMs': endMs,
      });
      return (result?['success'] as bool?) ?? false;
    } on PlatformException catch (e) {
      throw PlatformFailure('scheduleEvent failed: ${e.message}');
    }
  }

  Future<bool> cancelEvent(String eventId) async {
    try {
      final result = await _channel
          .invokeMethod<Map>('cancelEvent', {'eventId': eventId});
      return (result?['success'] as bool?) ?? false;
    } on PlatformException catch (e) {
      throw PlatformFailure('cancelEvent failed: ${e.message}');
    }
  }

  Future<bool> canScheduleExactAlarms() async {
    try {
      return await _channel.invokeMethod<bool>('canScheduleExactAlarms') ??
          true;
    } on PlatformException {
      return true;
    }
  }

  Future<void> startPeriodicSync() async {
    try {
      await _channel.invokeMethod('startPeriodicSync');
    } on PlatformException catch (e) {
      throw PlatformFailure('startPeriodicSync failed: ${e.message}');
    }
  }

  Future<void> stopPeriodicSync() async {
    try {
      await _channel.invokeMethod('stopPeriodicSync');
    } on PlatformException catch (e) {
      throw PlatformFailure('stopPeriodicSync failed: ${e.message}');
    }
  }

  Future<void> triggerImmediateSync() async {
    try {
      await _channel.invokeMethod('triggerImmediateSync');
    } on PlatformException catch (e) {
      throw PlatformFailure('triggerImmediateSync failed: ${e.message}');
    }
  }

  Future<int> getPendingAlarmCount() async {
    try {
      return await _channel.invokeMethod<int>('getPendingAlarmCount') ?? 0;
    } on PlatformException {
      return 0;
    }
  }
}
