import 'package:equatable/equatable.dart';

enum SilenceType { automatic, manual }

class SilenceSession extends Equatable {
  const SilenceSession({
    required this.id,
    required this.eventTitle,
    required this.startTime,
    this.endTime,
    required this.silenceType,
    this.missedCallCount = 0,
    this.restored = false,
    this.calendarEventId,
  });

  final int id;
  final String eventTitle;
  final DateTime startTime;
  final DateTime? endTime;
  final SilenceType silenceType;
  final int missedCallCount;
  final bool restored;
  final String? calendarEventId;

  bool get isActive => endTime == null;

  Duration? get duration =>
      endTime != null ? endTime!.difference(startTime) : null;

  @override
  List<Object?> get props => [id];
}

class SilenceStats extends Equatable {
  const SilenceStats({
    required this.totalSessions,
    required this.totalDurationMinutes,
    required this.missedCallsProtected,
    required this.thisWeekSessions,
    required this.thisWeekMinutes,
  });

  final int totalSessions;
  final int totalDurationMinutes;
  final int missedCallsProtected;
  final int thisWeekSessions;
  final int thisWeekMinutes;

  @override
  List<Object?> get props => [totalSessions, totalDurationMinutes];
}
