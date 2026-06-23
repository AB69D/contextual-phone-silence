import '../../entities/missed_notification.dart';
import '../../repositories/missed_notification_repository.dart';
import '../../../core/error/result.dart';

class EnqueueMissedNotificationUseCase {
  const EnqueueMissedNotificationUseCase(this._repository);
  final MissedNotificationRepository _repository;

  Future<Result<void>> call(MissedNotification notification) =>
      Result.guardAsync(() => _repository.enqueue(notification));
}
