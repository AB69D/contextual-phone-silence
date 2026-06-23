import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/database/app_database.dart';
import '../../data/datasources/alarm_data_source.dart';
import '../../data/datasources/audio_data_source.dart';
import '../../data/datasources/calendar_data_source.dart';
import '../../data/datasources/permission_data_source.dart';
import '../../data/datasources/preferences_data_source.dart';
import '../../data/repositories/audio_repository_impl.dart';
import '../../data/repositories/calendar_repository_impl.dart';
import '../../data/repositories/missed_notification_repository_impl.dart';
import '../../data/repositories/schedule_repository_impl.dart';
import '../../data/repositories/scheduled_event_repository_impl.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../data/repositories/silence_session_repository_impl.dart';
import '../../domain/repositories/i_audio_repository.dart';
import '../../domain/repositories/i_calendar_repository.dart';
import '../../domain/repositories/i_schedule_repository.dart';
import '../../domain/repositories/missed_notification_repository.dart';
import '../../domain/repositories/scheduled_event_repository.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/repositories/silence_session_repository.dart';
import '../../domain/usecases/audio/get_current_ringer_mode_usecase.dart';
import '../../domain/usecases/audio/request_dnd_permission_usecase.dart';
import '../../domain/usecases/audio/set_ringer_mode_usecase.dart';
import '../../domain/usecases/calendar/get_upcoming_events_usecase.dart';
import '../../domain/usecases/calendar/request_calendar_permission_usecase.dart';
import '../../domain/usecases/notification/get_missed_digest_usecase.dart';
import '../../domain/usecases/notification/mark_digest_shown_usecase.dart';
import '../../domain/usecases/schedule/create_schedule_usecase.dart';
import '../../domain/usecases/schedule/delete_schedule_usecase.dart';
import '../../domain/usecases/schedule/get_all_schedules_usecase.dart';
import '../../domain/usecases/schedule/update_schedule_usecase.dart';
import '../../domain/usecases/session/end_silence_session_usecase.dart';
import '../../domain/usecases/session/get_session_stats_usecase.dart';
import '../../domain/usecases/session/start_silence_session_usecase.dart';
import '../../presentation/screens/history/history_viewmodel.dart';
import '../../presentation/screens/home/home_viewmodel.dart';
import '../../presentation/screens/manual_silence/manual_silence_viewmodel.dart';
import '../../presentation/screens/missed_digest/missed_digest_viewmodel.dart';
import '../../presentation/screens/onboarding/onboarding_viewmodel.dart';
import '../../presentation/screens/permissions/permissions_viewmodel.dart';
import '../../presentation/screens/profiles/profiles_viewmodel.dart';
import '../../presentation/screens/settings/settings_viewmodel.dart';
import '../../presentation/screens/splash/splash_viewmodel.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  await _registerExternals();
  _registerDataSources();
  _registerRepositories();
  _registerUseCases();
  _registerViewModels();
}

Future<void> _registerExternals() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);
  sl.registerSingleton<AppDatabase>(AppDatabase());
}

void _registerDataSources() {
  sl.registerLazySingleton<PreferencesDataSource>(
      () => PreferencesDataSource(sl<SharedPreferences>()));
  sl.registerLazySingleton<CalendarDataSource>(() => CalendarDataSource());
  sl.registerLazySingleton<AudioDataSource>(() => AudioDataSource());
  sl.registerLazySingleton<AlarmDataSource>(() => AlarmDataSource());
  sl.registerLazySingleton<PermissionDataSource>(() => PermissionDataSource());
}

void _registerRepositories() {
  sl.registerLazySingleton<ICalendarRepository>(() => CalendarRepositoryImpl(
        calendarDataSource: sl<CalendarDataSource>(),
        database: sl<AppDatabase>(),
      ));
  sl.registerLazySingleton<IAudioRepository>(
      () => AudioRepositoryImpl(audioDataSource: sl<AudioDataSource>()));
  sl.registerLazySingleton<IScheduleRepository>(() => ScheduleRepositoryImpl(
        database: sl<AppDatabase>(),
        preferencesDataSource: sl<PreferencesDataSource>(),
      ));
  sl.registerLazySingleton<SilenceSessionRepository>(
      () => SilenceSessionRepositoryImpl(database: sl<AppDatabase>()));
  sl.registerLazySingleton<ScheduledEventRepository>(
      () => ScheduledEventRepositoryImpl(database: sl<AppDatabase>()));
  sl.registerLazySingleton<SettingsRepository>(() => SettingsRepositoryImpl(
        database: sl<AppDatabase>(),
        prefs: sl<PreferencesDataSource>(),
      ));
  sl.registerLazySingleton<MissedNotificationRepository>(
      () => MissedNotificationRepositoryImpl(database: sl<AppDatabase>()));
}

void _registerUseCases() {
  sl.registerFactory(() => GetUpcomingEventsUseCase(sl<ICalendarRepository>()));
  sl.registerFactory(
      () => RequestCalendarPermissionUseCase(sl<ICalendarRepository>()));
  sl.registerFactory(
      () => GetCurrentRingerModeUseCase(sl<IAudioRepository>()));
  sl.registerFactory(() => SetRingerModeUseCase(sl<IAudioRepository>()));
  sl.registerFactory(
      () => RequestDndPermissionUseCase(sl<IAudioRepository>()));
  sl.registerFactory(() => GetAllSchedulesUseCase(sl<IScheduleRepository>()));
  sl.registerFactory(() => CreateScheduleUseCase(sl<IScheduleRepository>()));
  sl.registerFactory(() => UpdateScheduleUseCase(sl<IScheduleRepository>()));
  sl.registerFactory(() => DeleteScheduleUseCase(sl<IScheduleRepository>()));
  sl.registerFactory(() => StartSilenceSessionUseCase(
      sl<SilenceSessionRepository>(), sl<IAudioRepository>()));
  sl.registerFactory(() => EndSilenceSessionUseCase(
      sl<SilenceSessionRepository>(), sl<IAudioRepository>()));
  sl.registerFactory(
      () => GetSessionStatsUseCase(sl<SilenceSessionRepository>()));
  sl.registerFactory(
      () => GetMissedDigestUseCase(sl<MissedNotificationRepository>()));
  sl.registerFactory(
      () => MarkDigestShownUseCase(sl<MissedNotificationRepository>()));
}

void _registerViewModels() {
  sl.registerFactory(() => SplashViewModel(
        settings: sl<SettingsRepository>(),
        calendar: sl<ICalendarRepository>(),
      ));
  sl.registerFactory(() => OnboardingViewModel(
        requestCalendar: sl<RequestCalendarPermissionUseCase>(),
        requestDnd: sl<RequestDndPermissionUseCase>(),
        permissionDataSource: sl<PermissionDataSource>(),
        settingsRepo: sl<SettingsRepository>(),
        alarmDataSource: sl<AlarmDataSource>(),
      ));
  sl.registerFactory(() => HomeViewModel(
        getUpcomingEvents: sl<GetUpcomingEventsUseCase>(),
        getCurrentRingerMode: sl<GetCurrentRingerModeUseCase>(),
        setRingerMode: sl<SetRingerModeUseCase>(),
        getAllSchedules: sl<GetAllSchedulesUseCase>(),
        getStats: sl<GetSessionStatsUseCase>(),
        missedNotifRepo: sl<MissedNotificationRepository>(),
      ));
  sl.registerFactory(() => ProfilesViewModel(database: sl<AppDatabase>()));
  sl.registerFactory(
      () => HistoryViewModel(sessionRepo: sl<SilenceSessionRepository>()));
  sl.registerFactory(() => MissedDigestViewModel(
        getMissedDigest: sl<GetMissedDigestUseCase>(),
        markShown: sl<MarkDigestShownUseCase>(),
      ));
  sl.registerFactory(() => SettingsViewModel(
        settingsRepo: sl<SettingsRepository>(),
        permissionDataSource: sl<PermissionDataSource>(),
        alarmDataSource: sl<AlarmDataSource>(),
        database: sl<AppDatabase>(),
      ));
  sl.registerFactory(() => PermissionsViewModel(
        requestCalendar: sl<RequestCalendarPermissionUseCase>(),
        requestDnd: sl<RequestDndPermissionUseCase>(),
        permissionDataSource: sl<PermissionDataSource>(),
      ));
  sl.registerFactory(() => ManualSilenceViewModel(
        startSession: sl<StartSilenceSessionUseCase>(),
        endSession: sl<EndSilenceSessionUseCase>(),
        getAllSchedules: sl<GetAllSchedulesUseCase>(),
      ));
}
