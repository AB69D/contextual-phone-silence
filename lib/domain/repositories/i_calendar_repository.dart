import '../entities/calendar_event.dart';
import '../../core/error/result.dart';

abstract interface class ICalendarRepository {
  Future<Result<List<CalendarEvent>>> getUpcomingEvents({
    int lookaheadHours = 24,
    List<String> calendarIds = const [],
  });

  Future<Result<List<CalendarEvent>>> getEventsInRange(
      DateTime from, DateTime to);

  Future<Result<CalendarEvent?>> getEventById(String calendarEventId);

  Future<Result<bool>> requestCalendarPermission();

  Future<bool> hasCalendarPermission();
}
