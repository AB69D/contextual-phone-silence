import '../../repositories/i_calendar_repository.dart';
import '../../../core/error/result.dart';

class RequestCalendarPermissionUseCase {
  const RequestCalendarPermissionUseCase(this._repository);
  final ICalendarRepository _repository;

  Future<Result<bool>> call() => _repository.requestCalendarPermission();
}
