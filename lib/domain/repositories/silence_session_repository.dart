import '../entities/silence_session.dart';
import '../../core/error/result.dart';

abstract interface class SilenceSessionRepository {
  Future<Result<int>> startSession(String eventTitle, String silenceType,
      {String? calendarEventId});
  Future<Result<void>> endSession(int sessionId, {bool restored = true});
  Future<Result<List<SilenceSession>>> getRecentSessions({int limit = 30});
  Future<Result<List<SilenceSession>>> getSessionsInRange(
      DateTime from, DateTime to);
  Future<Result<SilenceSession?>> getActiveSession();
  Future<Result<SilenceStats>> getStats();
  Stream<List<SilenceSession>> watchRecentSessions();
  Future<Result<void>> incrementMissedCalls(int sessionId);
}
