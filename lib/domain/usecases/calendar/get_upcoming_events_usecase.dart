import '../../entities/calendar_event.dart';
import '../../repositories/i_calendar_repository.dart';
import '../../../core/error/result.dart';
import '../../../core/error/failures.dart';

class GetUpcomingEventsParams {
  const GetUpcomingEventsParams({
    this.lookaheadHours = 24,
    this.calendarIds = const [],
    this.keywordFilter,
  });

  final int lookaheadHours;
  final List<String> calendarIds;
  final String? keywordFilter;
}

class GetUpcomingEventsUseCase {
  const GetUpcomingEventsUseCase(this._repository);
  final ICalendarRepository _repository;

  Future<Result<List<CalendarEvent>>> call(
      [GetUpcomingEventsParams params =
          const GetUpcomingEventsParams()]) async {
    final hasPermission = await _repository.hasCalendarPermission();
    if (!hasPermission) {
      return Result.failure(
          AppFailure.permission('Calendar permission not granted'));
    }
    final result = await _repository.getUpcomingEvents(
      lookaheadHours: params.lookaheadHours,
      calendarIds: params.calendarIds,
    );
    return result.map((events) {
      var filtered = events.where((e) => !e.isAllDay).toList();
      if (params.keywordFilter != null && params.keywordFilter!.isNotEmpty) {
        final kw = params.keywordFilter!.toLowerCase();
        filtered = filtered
            .where((e) => e.title.toLowerCase().contains(kw))
            .toList();
      }
      filtered.sort((a, b) => a.startTime.compareTo(b.startTime));
      return filtered;
    });
  }
}
