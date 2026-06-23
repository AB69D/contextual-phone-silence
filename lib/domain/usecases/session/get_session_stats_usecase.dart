import '../../entities/silence_session.dart';
import '../../repositories/silence_session_repository.dart';
import '../../../core/error/result.dart';

class GetSessionStatsUseCase {
  const GetSessionStatsUseCase(this._repository);
  final SilenceSessionRepository _repository;

  Future<Result<SilenceStats>> call() => _repository.getStats();
}
