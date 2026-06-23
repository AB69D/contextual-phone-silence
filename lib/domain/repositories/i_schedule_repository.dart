import '../entities/silence_schedule.dart';
import '../../core/error/result.dart';

abstract interface class IScheduleRepository {
  Future<Result<List<SilenceSchedule>>> getAllSchedules();
  Future<Result<SilenceSchedule>> createSchedule(SilenceSchedule schedule);
  Future<Result<SilenceSchedule>> updateSchedule(SilenceSchedule schedule);
  Future<Result<void>> deleteSchedule(int id);
  Stream<List<SilenceSchedule>> watchSchedules();
}
