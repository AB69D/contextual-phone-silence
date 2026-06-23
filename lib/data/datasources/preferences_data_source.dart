import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

class PreferencesDataSource {
  const PreferencesDataSource(this._prefs);
  final SharedPreferences _prefs;

  bool getAutoSilenceEnabled() =>
      _prefs.getBool(AppConstants.prefAutoSilenceEnabled) ?? true;
  Future<void> setAutoSilenceEnabled(bool v) =>
      _prefs.setBool(AppConstants.prefAutoSilenceEnabled, v);

  int getSilenceLeadMinutes() =>
      _prefs.getInt(AppConstants.prefSilenceLeadMinutes) ??
      AppConstants.defaultLeadMinutes;
  Future<void> setSilenceLeadMinutes(int v) =>
      _prefs.setInt(AppConstants.prefSilenceLeadMinutes, v);

  int getLookAheadHours() =>
      _prefs.getInt(AppConstants.prefLookAheadHours) ??
      AppConstants.defaultLookAheadHours;
  Future<void> setLookAheadHours(int v) =>
      _prefs.setInt(AppConstants.prefLookAheadHours, v);

  bool getMissedDigestEnabled() =>
      _prefs.getBool(AppConstants.prefMissedDigestEnabled) ?? true;
  Future<void> setMissedDigestEnabled(bool v) =>
      _prefs.setBool(AppConstants.prefMissedDigestEnabled, v);

  bool getAutoRestoreEnabled() =>
      _prefs.getBool(AppConstants.prefAutoRestoreEnabled) ?? true;
  Future<void> setAutoRestoreEnabled(bool v) =>
      _prefs.setBool(AppConstants.prefAutoRestoreEnabled, v);

  bool getCalendarPermissionGranted() =>
      _prefs.getBool(AppConstants.prefCalendarPermissionGranted) ?? false;
  Future<void> setCalendarPermissionGranted(bool v) =>
      _prefs.setBool(AppConstants.prefCalendarPermissionGranted, v);

  bool getOnboardingCompleted() =>
      _prefs.getBool(AppConstants.prefOnboardingCompleted) ?? false;
  Future<void> setOnboardingCompleted(bool v) =>
      _prefs.setBool(AppConstants.prefOnboardingCompleted, v);

  List<String> getEnabledCalendarIds() {
    final json = _prefs.getString(AppConstants.prefEnabledCalendarIds);
    if (json == null || json.isEmpty) return [];
    try {
      return List<String>.from(
          (json.replaceAll('[', '').replaceAll(']', '')
                  .split(',')
                  .map((s) => s.trim().replaceAll('"', '')))
              .where((s) => s.isNotEmpty));
    } catch (_) {
      return [];
    }
  }

  Future<void> setEnabledCalendarIds(List<String> ids) =>
      _prefs.setString(
          AppConstants.prefEnabledCalendarIds,
          '[' + ids.map((id) => '"' + id + '"').join(',') + ']');
}
