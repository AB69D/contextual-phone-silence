import '../../entities/audio_profile.dart';
import '../../repositories/i_audio_repository.dart';
import '../../../core/error/result.dart';

class SetRingerModeUseCase {
  const SetRingerModeUseCase(this._repository);
  final IAudioRepository _repository;

  Future<Result<void>> call(AudioProfile profile) =>
      _repository.setProfile(profile);
}
