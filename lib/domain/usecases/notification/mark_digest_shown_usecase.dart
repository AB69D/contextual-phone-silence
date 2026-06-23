import '../../repositories/missed_notification_repository.dart';
import '../../../core/error/result.dart';

class MarkDigestShownUseCase {
  const MarkDigestShownUseCase(this._repository);
  final MissedNotificationRepository _repository;

  Future<Result<void>> call(int sessionId) =>
      Result.guardAsync(
          () => _repository.markAllShownForSession(sessionId));
}
