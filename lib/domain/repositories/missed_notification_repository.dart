import '../entities/missed_notification.dart';

abstract interface class MissedNotificationRepository {
  Future<void> enqueue(MissedNotification notification);
  Future<List<MissedNotification>> getPendingForSession(int sessionId);
  Future<void> markAllShownForSession(int sessionId);
  Stream<int> watchUnshownCount();
  Future<void> pruneOlderThan(DateTime before);
}
