import 'package:equatable/equatable.dart';
import 'calendar_event.dart';

enum ScheduledEventStatus { pending, active, completed, cancelled }

class ScheduledEvent extends Equatable {
  const ScheduledEvent({
    this.id,
    required this.calendarEventId,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.silenceLevel,
    this.status = ScheduledEventStatus.pending,
  });

  final int? id;
  final String calendarEventId;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final SilenceLevel silenceLevel;
  final ScheduledEventStatus status;

  @override
  List<Object?> get props => [calendarEventId];
}
