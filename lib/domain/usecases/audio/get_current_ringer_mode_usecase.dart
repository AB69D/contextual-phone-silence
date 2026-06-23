import '../../entities/audio_profile.dart';
import '../../repositories/i_audio_repository.dart';
import '../../../core/error/result.dart';

class GetCurrentRingerModeUseCase {
  const GetCurrentRingerModeUseCase(this._repository);
  final IAudioRepository _repository;

  Future<Result<AudioProfile>> call() => _repository.getCurrentProfile();
}
