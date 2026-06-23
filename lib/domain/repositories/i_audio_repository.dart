import '../entities/audio_profile.dart';
import '../../core/error/result.dart';

abstract interface class IAudioRepository {
  Future<Result<AudioProfile>> getCurrentProfile();
  Future<Result<void>> setProfile(AudioProfile profile);
  Future<Result<void>> silence();
  Future<Result<void>> restore();
  Future<bool> isSilenced();
  Future<Result<bool>> requestDndPermission();
  Future<bool> hasDndPermission();
}
