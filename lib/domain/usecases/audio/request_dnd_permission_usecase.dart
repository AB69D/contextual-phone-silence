import '../../repositories/i_audio_repository.dart';
import '../../../core/error/result.dart';

class RequestDndPermissionUseCase {
  const RequestDndPermissionUseCase(this._repository);
  final IAudioRepository _repository;

  Future<Result<bool>> call() => _repository.requestDndPermission();
}
