import '../../../core/base/base_viewmodel.dart';
import '../../../data/database/app_database.dart';
import '../../../data/datasources/alarm_data_source.dart';
import '../../../data/datasources/permission_data_source.dart';
import '../../../domain/repositories/settings_repository.dart';

class SettingsViewModel extends BaseViewModel {
  SettingsViewModel({
    required this.settingsRepo,
    required this.permissionDataSource,
    required this.alarmDataSource,
    required this.database,
  });

  final SettingsRepository settingsRepo;
  final PermissionDataSource permissionDataSource;
  final AlarmDataSource alarmDataSource;
  final AppDatabase database;

  bool _autoSilenceEnabled = true;
  bool _missedDigestEnabled = true;
  bool _autoRestoreEnabled = true;
  int _leadMinutes = 0;
  int _lookAheadHours = 24;
  Map<String, dynamic> _permissionStatus = {};
  int _pendingAlarmCount = 0;

  bool get autoSilenceEnabled => _autoSilenceEnabled;
  bool get missedDigestEnabled => _missedDigestEnabled;
  bool get autoRestoreEnabled => _autoRestoreEnabled;
  int get leadMinutes => _leadMinutes;
  int get lookAheadHours => _lookAheadHours;
  Map<String, dynamic> get permissionStatus => _permissionStatus;
  int get pendingAlarmCount => _pendingAlarmCount;

  bool get serviceHealthy =>
      (_permissionStatus['dndAccess'] as bool? ?? false) &&
      (_permissionStatus['exactAlarm'] as bool? ?? false) &&
      (_permissionStatus['batteryOptimizationExcluded'] as bool? ?? false);

  Future<void> load() async {
    setLoading(true);
    _autoSilenceEnabled = await settingsRepo.isAutoSilenceEnabled();
    _missedDigestEnabled = await settingsRepo.isMissedDigestEnabled();
    _autoRestoreEnabled = await settingsRepo.isAutoRestoreEnabled();
    _leadMinutes = await settingsRepo.getSilenceLeadMinutes();
    _lookAheadHours = await settingsRepo.getLookAheadHours();
    _permissionStatus = await permissionDataSource.checkAll();
    _pendingAlarmCount = await alarmDataSource.getPendingAlarmCount();
    setLoading(false);
  }

  Future<void> setAutoSilence(bool v) async {
    await settingsRepo.setAutoSilenceEnabled(v);
    _autoSilenceEnabled = v;
    notifyListeners();
  }

  Future<void> setMissedDigest(bool v) async {
    await settingsRepo.setMissedDigestEnabled(v);
    _missedDigestEnabled = v;
    notifyListeners();
  }

  Future<void> setAutoRestore(bool v) async {
    await settingsRepo.setAutoRestoreEnabled(v);
    _autoRestoreEnabled = v;
    notifyListeners();
  }
}
