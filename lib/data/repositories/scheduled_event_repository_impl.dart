import 'package:drift/drift.dart';
import '../../domain/entities/scheduled_event.dart';
import '../../domain/entities/calendar_event.dart';
import '../../domain/repositories/scheduled_event_repository.dart';
import '../../core/error/result.dart';
import '../database/app_database.dart' as db;

class ScheduledEventRepositoryImpl implements ScheduledEventRepository {
  const ScheduledEventRepositoryImpl({required this.database});
  final db.AppDatabase database;

  @override
  Future<Result<void>> upsert(ScheduledEvent event) =>
      Result.guardAsync(() => database.upsertScheduledEvent(
            db.ScheduledEventsCompanion(
              calendarEventId: Value(event.calendarEventId),
              title: Value(event.title),
              startTime: Value(event.startTime),
              endTime: Value(event.endTime),
              silenceLevel: Value(_levelToString(event.silenceLevel)),
              status: Value(_statusToString(event.status)),
            ),
          ));

  @override
  Future<Result<void>> updateStatus(
          String calendarEventId, ScheduledEventStatus status) =>
      Result.guardAsync(() => database.updateScheduledEventStatus(
          calendarEventId, _statusToString(status)));

  @override
  Future<Result<List<ScheduledEvent>>> getPending() =>
      Result.guardAsync(() => database
          .getPendingScheduledEvents()
          .then((rows) => rows.map(_toEntity).toList()));

  @override
  Future<Result<void>> deleteByCalendarId(String calendarEventId) =>
      Result.guardAsync(
          () => database.deleteScheduledEvent(calendarEventId));

  @override
  Stream<List<ScheduledEvent>> watchPending() =>
      database.watchPendingScheduledEvents().map((rows) => rows.map(_toEntity).toList());

  ScheduledEvent _toEntity(db.ScheduledEvent row) => ScheduledEvent(
        id: row.id,
        calendarEventId: row.calendarEventId,
        title: row.title,
        startTime: row.startTime,
        endTime: row.endTime,
        silenceLevel: _levelFromString(row.silenceLevel),
        status: _statusFromString(row.status),
      );

  String _levelToString(SilenceLevel level) => switch (level) {
        SilenceLevel.fullSilent => 'fullSilent',
        SilenceLevel.vibrate => 'vibrate',
        SilenceLevel.none => 'none',
      };

  SilenceLevel _levelFromString(String s) => switch (s) {
        'fullSilent' => SilenceLevel.fullSilent,
        'vibrate' => SilenceLevel.vibrate,
        _ => SilenceLevel.none,
      };

  String _statusToString(ScheduledEventStatus s) => switch (s) {
        ScheduledEventStatus.pending => 'pending',
        ScheduledEventStatus.active => 'active',
        ScheduledEventStatus.completed => 'completed',
        ScheduledEventStatus.cancelled => 'cancelled',
      };

  ScheduledEventStatus _statusFromString(String s) => switch (s) {
        'active' => ScheduledEventStatus.active,
        'completed' => ScheduledEventStatus.completed,
        'cancelled' => ScheduledEventStatus.cancelled,
        _ => ScheduledEventStatus.pending,
      };
}
