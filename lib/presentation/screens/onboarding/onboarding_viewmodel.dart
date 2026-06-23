import '../../../core/base/base_viewmodel.dart';
import '../../../data/datasources/alarm_data_source.dart';
import '../../../data/datasources/permission_data_source.dart';
import '../../../domain/repositories/settings_repository.dart';
import '../../../domain/usecases/audio/request_dnd_permission_usecase.dart';
import '../../../domain/usecases/calendar/request_calendar_permission_usecase.dart';

class OnboardingViewModel extends BaseViewModel {
  OnboardingViewModel({
    required this.requestCalendar,
    required this.requestDnd,
    required this.permissionDataSource,
    required this.settingsRepo,
    required this.alarmDataSource,
  });

  final RequestCalendarPermissionUseCase requestCalendar;
  final RequestDndPermissionUseCase requestDnd;
  final PermissionDataSource permissionDataSource;
  final SettingsRepository settingsRepo;
  final AlarmDataSource alarmDataSource;

  Map<String, dynamic> _permissionStatus = {};
  Map<String, dynamic> get permissionStatus => _permissionStatus;

  Future<void> checkPermissions() async {
    _permissionStatus = await permissionDataSource.checkAll();
    notifyListeners();
  }

  Future<bool> grantCalendarPermission() async {
    final result = await requestCalendar();
    await checkPermissions();
    return result.valueOrNull ?? false;
  }

  Future<void> openDndSettings() => permissionDataSource.openDndSettings();

  Future<void> completeOnboarding() async {
    await settingsRepo.setOnboardingCompleted(true);
    await alarmDataSource.triggerImmediateSync();
    await alarmDataSource.startPeriodicSync();
  }
}
