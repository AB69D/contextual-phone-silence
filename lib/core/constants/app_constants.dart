abstract final class AppConstants {
  // MethodChannel names
  static const channelCalendar = 'com.yonderchat.contextual_silence/calendar';
  static const channelAudio = 'com.yonderchat.contextual_silence/audio';
  static const channelAlarm = 'com.yonderchat.contextual_silence/alarm';
  static const channelPermissions = 'com.yonderchat.contextual_silence/permissions';

  // SharedPreferences keys
  static const prefAutoSilenceEnabled = 'cps_auto_silence_enabled';
  static const prefSilenceLeadMinutes = 'cps_silence_lead_minutes';
  static const prefLookAheadHours = 'cps_look_ahead_hours';
  static const prefMissedDigestEnabled = 'cps_missed_digest_enabled';
  static const prefAutoRestoreEnabled = 'cps_auto_restore_enabled';
  static const prefCalendarPermissionGranted = 'cps_calendar_permission_granted';
  static const prefEnabledCalendarIds = 'cps_enabled_calendar_ids';
  static const prefOnboardingCompleted = 'cps_onboarding_completed';
  static const prefActivePersona = 'cps_active_persona';

  // Defaults
  static const defaultLookAheadHours = 24;
  static const defaultLeadMinutes = 0;
  static const defaultSyncIntervalMinutes = 15;

  // Notification channels
  static const notifChannelSilenceId = 'silence_active';
  static const notifChannelSilenceName = 'Active Silence';
  static const notifChannelDigestId = 'missed_digest';
  static const notifChannelDigestName = 'Missed Digest';

  // Deep-link scheme
  static const deepLinkScheme = 'contextualsilence';
}
