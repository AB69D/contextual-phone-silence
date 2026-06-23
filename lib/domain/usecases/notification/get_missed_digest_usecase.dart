import '../../entities/missed_notification.dart';
import '../../repositories/missed_notification_repository.dart';
import '../../../core/error/result.dart';

class GetMissedDigestUseCase {
  const GetMissedDigestUseCase(this._repository);
  final MissedNotificationRepository _repository;

  Future<Result<List<MissedNotification>>> call(int sessionId) =>
      Result.guardAsync(
          () => _repository.getPendingForSession(sessionId));
}
