import '../../core/error/result.dart';

abstract interface class SettingsRepository {
  Future<bool> isAutoSilenceEnabled();
  Future<void> setAutoSilenceEnabled(bool enabled);

  Future<int> getSilenceLeadMinutes();
  Future<void> setSilenceLeadMinutes(int minutes);

  Future<int> getLookAheadHours();
  Future<void> setLookAheadHours(int hours);

  Future<bool> isMissedDigestEnabled();
  Future<void> setMissedDigestEnabled(bool enabled);

  Future<bool> isAutoRestoreEnabled();
  Future<void> setAutoRestoreEnabled(bool enabled);

  Future<bool> isOnboardingCompleted();
  Future<void> setOnboardingCompleted(bool completed);

  Future<List<String>> getEnabledCalendarIds();
  Future<void> setEnabledCalendarIds(List<String> ids);

  Future<Result<String?>> getSetting(String key);
  Future<Result<void>> setSetting(String key, String value);
}
