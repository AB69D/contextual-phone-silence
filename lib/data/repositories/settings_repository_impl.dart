import '../../domain/repositories/settings_repository.dart';
import '../../core/error/result.dart';
import '../database/app_database.dart';
import '../datasources/preferences_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl({
    required this.database,
    required this.prefs,
  });

  final AppDatabase database;
  final PreferencesDataSource prefs;

  @override
  Future<bool> isAutoSilenceEnabled() async =>
      prefs.getAutoSilenceEnabled();
  @override
  Future<void> setAutoSilenceEnabled(bool enabled) =>
      prefs.setAutoSilenceEnabled(enabled);

  @override
  Future<int> getSilenceLeadMinutes() async =>
      prefs.getSilenceLeadMinutes();
  @override
  Future<void> setSilenceLeadMinutes(int minutes) =>
      prefs.setSilenceLeadMinutes(minutes);

  @override
  Future<int> getLookAheadHours() async => prefs.getLookAheadHours();
  @override
  Future<void> setLookAheadHours(int hours) =>
      prefs.setLookAheadHours(hours);

  @override
  Future<bool> isMissedDigestEnabled() async =>
      prefs.getMissedDigestEnabled();
  @override
  Future<void> setMissedDigestEnabled(bool enabled) =>
      prefs.setMissedDigestEnabled(enabled);

  @override
  Future<bool> isAutoRestoreEnabled() async =>
      prefs.getAutoRestoreEnabled();
  @override
  Future<void> setAutoRestoreEnabled(bool enabled) =>
      prefs.setAutoRestoreEnabled(enabled);

  @override
  Future<bool> isOnboardingCompleted() async =>
      prefs.getOnboardingCompleted();
  @override
  Future<void> setOnboardingCompleted(bool completed) =>
      prefs.setOnboardingCompleted(completed);

  @override
  Future<List<String>> getEnabledCalendarIds() async =>
      prefs.getEnabledCalendarIds();
  @override
  Future<void> setEnabledCalendarIds(List<String> ids) =>
      prefs.setEnabledCalendarIds(ids);

  @override
  Future<Result<String?>> getSetting(String key) =>
      Result.guardAsync(() => database.getSetting(key));

  @override
  Future<Result<void>> setSetting(String key, String value) =>
      Result.guardAsync(() => database.setSetting(key, value));
}
