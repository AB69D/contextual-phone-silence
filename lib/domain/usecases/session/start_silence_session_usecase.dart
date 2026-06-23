import '../../repositories/silence_session_repository.dart';
import '../../repositories/i_audio_repository.dart';
import '../../../core/error/result.dart';

class StartSilenceSessionUseCase {
  const StartSilenceSessionUseCase(this._sessionRepo, this._audioRepo);
  final SilenceSessionRepository _sessionRepo;
  final IAudioRepository _audioRepo;

  Future<Result<int>> call({
    required String eventTitle,
    bool isManual = false,
    String? calendarEventId,
  }) async {
    final silenceResult = await _audioRepo.silence();
    if (silenceResult.isFailure) return Result.failure(silenceResult.failureOrNull!);

    return _sessionRepo.startSession(
      eventTitle,
      isManual ? 'manual' : 'automatic',
      calendarEventId: calendarEventId,
    );
  }
}
