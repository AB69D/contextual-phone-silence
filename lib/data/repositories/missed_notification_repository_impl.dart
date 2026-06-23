import 'package:drift/drift.dart';
import '../../domain/entities/missed_notification.dart';
import '../../domain/repositories/missed_notification_repository.dart';
import '../database/app_database.dart' as db;

class MissedNotificationRepositoryImpl
    implements MissedNotificationRepository {
  const MissedNotificationRepositoryImpl({required this.database});
  final db.AppDatabase database;

  @override
  Future<void> enqueue(MissedNotification notification) =>
      database.insertMissedNotification(db.MissedNotificationsCompanion(
        sessionId: Value(notification.sessionId),
        category: Value(_categoryToString(notification.category)),
        appPackageName: Value(notification.appPackageName),
        senderName: Value(notification.senderName),
        preview: Value(notification.preview != null
            ? notification.preview!.length > 200
                ? notification.preview!.substring(0, 200)
                : notification.preview!
            : null),
        receivedAt: Value(notification.receivedAt),
      ));

  @override
  Future<List<MissedNotification>> getPendingForSession(
          int sessionId) =>
      database
          .getMissedForSession(sessionId)
          .then((rows) => rows.map(_toEntity).toList());

  @override
  Future<void> markAllShownForSession(int sessionId) =>
      database.markDigestShown(sessionId);

  @override
  Stream<int> watchUnshownCount() => database.watchUnshownCount();

  @override
  Future<void> pruneOlderThan(DateTime before) =>
      database.pruneBefore(before);

  MissedNotification _toEntity(db.MissedNotification row) =>
      MissedNotification(
        id: row.id,
        sessionId: row.sessionId,
        category: _categoryFromString(row.category),
        appPackageName: row.appPackageName,
        senderName: row.senderName,
        preview: row.preview,
        receivedAt: row.receivedAt,
        digestShown: row.digestShown,
      );

  String _categoryToString(NotificationCategory c) => switch (c) {
        NotificationCategory.call => 'call',
        NotificationCategory.message => 'message',
        NotificationCategory.other => 'other',
      };

  NotificationCategory _categoryFromString(String s) => switch (s) {
        'call' => NotificationCategory.call,
        'message' => NotificationCategory.message,
        _ => NotificationCategory.other,
      };
}
