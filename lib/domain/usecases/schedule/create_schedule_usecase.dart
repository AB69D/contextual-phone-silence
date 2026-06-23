import '../../entities/silence_schedule.dart';
import '../../repositories/i_schedule_repository.dart';
import '../../../core/error/result.dart';

class CreateScheduleUseCase {
  const CreateScheduleUseCase(this._repository);
  final IScheduleRepository _repository;

  Future<Result<SilenceSchedule>> call(SilenceSchedule schedule) =>
      _repository.createSchedule(schedule);
}
