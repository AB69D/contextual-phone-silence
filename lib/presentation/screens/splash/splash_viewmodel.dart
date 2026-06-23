import '../../../core/base/base_viewmodel.dart';
import '../../../domain/repositories/settings_repository.dart';
import '../../../domain/repositories/i_calendar_repository.dart';

enum SplashDestination { home, onboarding }

class SplashViewModel extends BaseViewModel {
  SplashViewModel({required this.settings, required this.calendar});

  final SettingsRepository settings;
  final ICalendarRepository calendar;

  SplashDestination? _destination;
  SplashDestination? get destination => _destination;

  Future<void> init() async {
    setLoading(true);
    final onboardingDone = await settings.isOnboardingCompleted();
    _destination =
        onboardingDone ? SplashDestination.home : SplashDestination.onboarding;
    setLoading(false);
    notifyListeners();
  }
}
