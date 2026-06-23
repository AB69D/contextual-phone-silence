import 'package:flutter/services.dart';
import '../../core/constants/app_constants.dart';
import '../../core/error/failures.dart';
import '../models/raw_calendar_event.dart';

class CalendarDataSource {
  static const _channel =
      MethodChannel(AppConstants.channelCalendar);

  Future<List<RawCalendarEvent>> getEvents({
    required int fromMillis,
    required int toMillis,
  }) async {
    try {
      final result = await _channel.invokeMethod<List>('getEvents', {
        'fromMillis': fromMillis,
        'toMillis': toMillis,
      });
      return (result ?? [])
          .map((e) => RawCalendarEvent.fromMap(e as Map))
          .toList();
    } on PlatformException catch (e) {
      throw PlatformFailure('getEvents failed: ${e.message}');
    }
  }

  Future<RawCalendarEvent?> getEventById(String eventId) async {
    try {
      final result = await _channel.invokeMethod<Map>('getEventById', {
        'eventId': eventId,
      });
      return result != null ? RawCalendarEvent.fromMap(result) : null;
    } on PlatformException catch (e) {
      throw PlatformFailure('getEventById failed: ${e.message}');
    }
  }

  Future<bool> hasPermission() async {
    try {
      return await _channel.invokeMethod<bool>('hasPermission') ?? false;
    } on PlatformException catch (e) {
      throw PlatformFailure('hasPermission failed: ${e.message}');
    }
  }

  Future<bool> requestPermission() async {
    try {
      return await _channel.invokeMethod<bool>('requestPermission') ?? false;
    } on PlatformException catch (e) {
      throw PlatformFailure('requestPermission failed: ${e.message}');
    }
  }
}
