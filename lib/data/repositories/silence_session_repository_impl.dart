import 'package:drift/drift.dart';
import '../../domain/entities/silence_session.dart';
import '../../domain/repositories/silence_session_repository.dart';
import '../../core/error/result.dart';
import '../database/app_database.dart' as db;

class SilenceSessionRepositoryImpl implements SilenceSessionRepository {
  const SilenceSessionRepositoryImpl({required this.database});
  final db.AppDatabase database;

  @override
  Future<Result<int>> startSession(String eventTitle, String silenceType,
      {String? calendarEventId}) =>
      Result.guardAsync(() => database.insertSession(
            db.SilenceSessionsCompanion(
              eventTitle: Value(eventTitle),
              silenceType: Value(silenceType),
              startTime: Value(DateTime.now()),
              calendarEventId: Value(calendarEventId),
            ),
          ));

  @override
  Future<Result<void>> endSession(int sessionId,
      {bool restored = true}) =>
      Result.guardAsync(() => database.updateSession(
            db.SilenceSessionsCompanion(
              id: Value(sessionId),
              endTime: Value(DateTime.now()),
              restored: Value(restored),
            ),
          ));

  @override
  Future<Result<List<SilenceSession>>> getRecentSessions(
          {int limit = 30}) =>
      Result.guardAsync(() => database
          .getRecentSessions(limit: limit)
          .then((rows) => rows.map(_toEntity).toList()));

  @override
  Future<Result<List<SilenceSession>>> getSessionsInRange(
          DateTime from, DateTime to) =>
      Result.guardAsync(() => database
          .getSessionsInRange(from, to)
          .then((rows) => rows.map(_toEntity).toList()));

  @override
  Future<Result<SilenceSession?>> getActiveSession() =>
      Result.guardAsync(() =>
          database.getActiveSession().then((r) => r != null ? _toEntity(r) : null));

  @override
  Future<Result<SilenceStats>> getStats() async {
    return Result.guardAsync(() async {
      final sessions = await database.getRecentSessions(limit: 10000);
      final now = DateTime.now();
      final weekStart = now.subtract(Duration(days: now.weekday - 1));
      final thisWeek = sessions.where((s) =>
          s.startTime.isAfter(weekStart)).toList();

      int totalMinutes = 0;
      int weekMinutes = 0;
      int missedCalls = 0;

      for (final s in sessions) {
        if (s.endTime != null) {
          totalMinutes += s.endTime!.difference(s.startTime).inMinutes;
        }
        missedCalls += s.missedCallCount;
      }
      for (final s in thisWeek) {
        if (s.endTime != null) {
          weekMinutes += s.endTime!.difference(s.startTime).inMinutes;
        }
      }

      return SilenceStats(
        totalSessions: sessions.length,
        totalDurationMinutes: totalMinutes,
        missedCallsProtected: missedCalls,
        thisWeekSessions: thisWeek.length,
        thisWeekMinutes: weekMinutes,
      );
    });
  }

  @override
  Stream<List<SilenceSession>> watchRecentSessions() =>
      database.watchRecentSessions().map((rows) => rows.map(_toEntity).toList());

  @override
  Future<Result<void>> incrementMissedCalls(int sessionId) =>
      Result.guardAsync(() => database.incrementMissedCalls(sessionId));

  SilenceSession _toEntity(db.SilenceSession row) => SilenceSession(
        id: row.id,
        eventTitle: row.eventTitle,
        startTime: row.startTime,
        endTime: row.endTime,
        silenceType: row.silenceType == 'manual'
            ? SilenceType.manual
            : SilenceType.automatic,
        missedCallCount: row.missedCallCount,
        restored: row.restored,
        calendarEventId: row.calendarEventId,
      );
}
