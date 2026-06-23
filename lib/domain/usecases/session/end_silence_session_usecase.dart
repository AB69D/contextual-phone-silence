import '../../repositories/silence_session_repository.dart';
import '../../repositories/i_audio_repository.dart';
import '../../../core/error/result.dart';

class EndSilenceSessionUseCase {
  const EndSilenceSessionUseCase(this._sessionRepo, this._audioRepo);
  final SilenceSessionRepository _sessionRepo;
  final IAudioRepository _audioRepo;

  Future<Result<void>> call(int sessionId) async {
    // Always restore audio even if session record is missing
    await _audioRepo.restore();
    return _sessionRepo.endSession(sessionId, restored: true);
  }
}
