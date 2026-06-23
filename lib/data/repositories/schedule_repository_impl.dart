import '../../domain/entities/silence_schedule.dart';
import '../../domain/repositories/i_schedule_repository.dart';
import '../../core/error/result.dart';
import '../database/app_database.dart';
import '../datasources/preferences_data_source.dart';

class ScheduleRepositoryImpl implements IScheduleRepository {
  const ScheduleRepositoryImpl({
    required this.database,
    required this.preferencesDataSource,
  });

  final AppDatabase database;
  final PreferencesDataSource preferencesDataSource;

  @override
  Future<Result<List<SilenceSchedule>>> getAllSchedules() =>
      Result.guardAsync(() async => []);

  @override
  Future<Result<SilenceSchedule>> createSchedule(
          SilenceSchedule schedule) =>
      Result.guardAsync(() async => schedule.copyWith(id: 1));

  @override
  Future<Result<SilenceSchedule>> updateSchedule(
          SilenceSchedule schedule) =>
      Result.guardAsync(() async => schedule);

  @override
  Future<Result<void>> deleteSchedule(int id) =>
      Result.guardAsync(() async {});

  @override
  Stream<List<SilenceSchedule>> watchSchedules() =>
      Stream.value([]);
}
