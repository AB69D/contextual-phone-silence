import '../../domain/entities/audio_profile.dart';
import '../../domain/repositories/i_audio_repository.dart';
import '../../core/error/result.dart';
import '../datasources/audio_data_source.dart';

class AudioRepositoryImpl implements IAudioRepository {
  const AudioRepositoryImpl({required this.audioDataSource});
  final AudioDataSource audioDataSource;

  @override
  Future<Result<AudioProfile>> getCurrentProfile() =>
      Result.guardAsync(() async {
        final mode = await audioDataSource.getRingerMode();
        return AudioProfile.fromAndroidRingerMode(mode);
      });

  @override
  Future<Result<void>> setProfile(AudioProfile profile) =>
      Result.guardAsync(
          () => audioDataSource.setRingerMode(profile.androidRingerMode));

  @override
  Future<Result<void>> silence() =>
      Result.guardAsync(() => audioDataSource.silence());

  @override
  Future<Result<void>> restore() =>
      Result.guardAsync(() => audioDataSource.restore());

  @override
  Future<bool> isSilenced() => audioDataSource.isSilenced();

  @override
  Future<Result<bool>> requestDndPermission() async {
    // DND permission is opened via PermissionDataSource; check-only here
    return Result.guardAsync(() async {
      final state = await audioDataSource.getAudioState();
      return (state['hasDndPermission'] as bool?) ?? false;
    });
  }

  @override
  Future<bool> hasDndPermission() async {
    final state = await audioDataSource.getAudioState();
    return (state['hasDndPermission'] as bool?) ?? false;
  }
}
