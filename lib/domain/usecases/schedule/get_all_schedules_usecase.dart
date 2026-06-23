import '../../entities/silence_schedule.dart';
import '../../repositories/i_schedule_repository.dart';
import '../../../core/error/result.dart';

class GetAllSchedulesUseCase {
  const GetAllSchedulesUseCase(this._repository);
  final IScheduleRepository _repository;

  Future<Result<List<SilenceSchedule>>> call() =>
      _repository.getAllSchedules();
}
