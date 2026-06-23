import '../../../core/base/base_viewmodel.dart';
import '../../../domain/entities/silence_schedule.dart';
import '../../../domain/usecases/schedule/get_all_schedules_usecase.dart';
import '../../../domain/usecases/session/end_silence_session_usecase.dart';
import '../../../domain/usecases/session/start_silence_session_usecase.dart';

class ManualSilenceViewModel extends BaseViewModel {
  ManualSilenceViewModel({
    required this.startSession,
    required this.endSession,
    required this.getAllSchedules,
  });

  final StartSilenceSessionUseCase startSession;
  final EndSilenceSessionUseCase endSession;
  final GetAllSchedulesUseCase getAllSchedules;

  int? _activeSessionId;
  Duration _selectedDuration = const Duration(minutes: 30);
  bool _isSilenced = false;
  List<SilenceSchedule> _schedules = [];

  bool get isSilenced => _isSilenced;
  Duration get selectedDuration => _selectedDuration;
  List<SilenceSchedule> get schedules => _schedules;
  DateTime? get endsAt =>
      _isSilenced ? DateTime.now().add(_selectedDuration) : null;

  void selectDuration(Duration d) {
    _selectedDuration = d;
    notifyListeners();
  }

  Future<void> startManualSilence() async {
    setLoading(true);
    final result = await startSession(
      eventTitle: 'Manual silence',
      isManual: true,
    );
    if (result.isSuccess) {
      _activeSessionId = result.valueOrNull;
      _isSilenced = true;
    } else {
      setError(result.failureOrNull);
    }
    setLoading(false);
  }

  Future<void> endManualSilence() async {
    if (_activeSessionId == null) return;
    setLoading(true);
    await endSession(_activeSessionId!);
    _isSilenced = false;
    _activeSessionId = null;
    setLoading(false);
  }
}
