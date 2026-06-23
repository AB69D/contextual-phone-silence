import '../entities/scheduled_event.dart';
import '../../core/error/result.dart';

abstract interface class ScheduledEventRepository {
  Future<Result<void>> upsert(ScheduledEvent event);
  Future<Result<void>> updateStatus(
      String calendarEventId, ScheduledEventStatus status);
  Future<Result<List<ScheduledEvent>>> getPending();
  Future<Result<void>> deleteByCalendarId(String calendarEventId);
  Stream<List<ScheduledEvent>> watchPending();
}
