import '../../repositories/i_schedule_repository.dart';
import '../../../core/error/result.dart';

class DeleteScheduleUseCase {
  const DeleteScheduleUseCase(this._repository);
  final IScheduleRepository _repository;

  Future<Result<void>> call(int id) => _repository.deleteSchedule(id);
}
