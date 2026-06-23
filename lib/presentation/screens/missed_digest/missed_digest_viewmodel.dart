import '../../../core/base/base_viewmodel.dart';
import '../../../domain/entities/missed_notification.dart';
import '../../../domain/usecases/notification/get_missed_digest_usecase.dart';
import '../../../domain/usecases/notification/mark_digest_shown_usecase.dart';

class MissedDigestViewModel extends BaseViewModel {
  MissedDigestViewModel({
    required this.getMissedDigest,
    required this.markShown,
  });

  final GetMissedDigestUseCase getMissedDigest;
  final MarkDigestShownUseCase markShown;

  List<MissedNotification> _notifications = [];
  int _sessionId = 0;

  List<MissedNotification> get notifications => _notifications;

  List<MissedNotification> get calls => _notifications
      .where((n) => n.category == NotificationCategory.call)
      .toList();

  List<MissedNotification> get messages => _notifications
      .where((n) => n.category == NotificationCategory.message)
      .toList();

  Future<void> load(int sessionId) async {
    _sessionId = sessionId;
    setLoading(true);
    final result = await getMissedDigest(sessionId);
    if (result.isSuccess) {
      _notifications = result.valueOrNull ?? [];
    }
    setLoading(false);
  }

  Future<void> markAllHandled() async {
    await markShown(_sessionId);
    _notifications = _notifications
        .map((n) => MissedNotification(
              id: n.id,
              sessionId: n.sessionId,
              category: n.category,
              appPackageName: n.appPackageName,
              senderName: n.senderName,
              preview: n.preview,
              receivedAt: n.receivedAt,
              digestShown: true,
            ))
        .toList();
    notifyListeners();
  }
}
