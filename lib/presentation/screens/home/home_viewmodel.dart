import '../../../core/base/base_viewmodel.dart';
import '../../../domain/entities/audio_profile.dart';
import '../../../domain/entities/calendar_event.dart';
import '../../../domain/entities/silence_session.dart';
import '../../../domain/entities/silence_schedule.dart';
import '../../../domain/repositories/missed_notification_repository.dart';
import '../../../domain/usecases/audio/get_current_ringer_mode_usecase.dart';
import '../../../domain/usecases/audio/set_ringer_mode_usecase.dart';
import '../../../domain/usecases/calendar/get_upcoming_events_usecase.dart';
import '../../../domain/usecases/schedule/get_all_schedules_usecase.dart';
import '../../../domain/usecases/session/get_session_stats_usecase.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel({
    required this.getUpcomingEvents,
    required this.getCurrentRingerMode,
    required this.setRingerMode,
    required this.getAllSchedules,
    required this.getStats,
    required this.missedNotifRepo,
  });

  final GetUpcomingEventsUseCase getUpcomingEvents;
  final GetCurrentRingerModeUseCase getCurrentRingerMode;
  final SetRingerModeUseCase setRingerMode;
  final GetAllSchedulesUseCase getAllSchedules;
  final GetSessionStatsUseCase getStats;
  final MissedNotificationRepository missedNotifRepo;

  List<CalendarEvent> _upcomingEvents = [];
  AudioProfile _currentProfile = AudioProfile.normal;
  SilenceStats? _stats;
  List<SilenceSchedule> _schedules = [];
  int _unshownDigestCount = 0;

  List<CalendarEvent> get upcomingEvents => _upcomingEvents;
  AudioProfile get currentProfile => _currentProfile;
  SilenceStats? get stats => _stats;
  List<SilenceSchedule> get schedules => _schedules;
  int get unshownDigestCount => _unshownDigestCount;

  bool get isSilenced => _currentProfile.isSilent;

  Future<void> loadInitialData() async {
    setLoading(true);
    clearError();

    final results = await Future.wait([
      getUpcomingEvents(),
      getCurrentRingerMode(),
      getAllSchedules(),
      getStats(),
    ]);

    final eventsResult = results[0];
    final audioResult = results[1];
    final schedulesResult = results[2];
    final statsResult = results[3];

    if (eventsResult.isSuccess) {
      _upcomingEvents =
          (eventsResult.valueOrNull as List<CalendarEvent>?) ?? [];
    }
    if (audioResult.isSuccess) {
      _currentProfile =
          (audioResult.valueOrNull as AudioProfile?) ?? AudioProfile.normal;
    }
    if (schedulesResult.isSuccess) {
      _schedules =
          (schedulesResult.valueOrNull as List<SilenceSchedule>?) ?? [];
    }
    if (statsResult.isSuccess) {
      _stats = statsResult.valueOrNull as SilenceStats?;
    }

    setLoading(false);
  }

  Future<void> toggleSilence() async {
    final newProfile =
        isSilenced ? AudioProfile.normal : AudioProfile.silent;
    final result = await setRingerMode(newProfile);
    if (result.isSuccess) {
      _currentProfile = newProfile;
      notifyListeners();
    }
  }

  void onDigestCountChanged(int count) {
    _unshownDigestCount = count;
    notifyListeners();
  }
}
