import 'package:equatable/equatable.dart';

enum SilenceLevel { none, vibrate, fullSilent }

class CalendarEvent extends Equatable {
  const CalendarEvent({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.calendarId,
    required this.calendarName,
    required this.isAllDay,
    this.location,
    this.description,
    this.colorHex,
    this.resolvedSilenceLevel = SilenceLevel.none,
    this.matchedKeyword,
  });

  final String id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String calendarId;
  final String calendarName;
  final bool isAllDay;
  final String? location;
  final String? description;
  final String? colorHex;
  final SilenceLevel resolvedSilenceLevel;
  final String? matchedKeyword;

  Duration get duration => endTime.difference(startTime);
  bool get isOngoing => DateTime.now().isAfter(startTime) && DateTime.now().isBefore(endTime);
  bool get shouldSilence => resolvedSilenceLevel != SilenceLevel.none;

  CalendarEvent copyWith({
    SilenceLevel? resolvedSilenceLevel,
    String? matchedKeyword,
  }) =>
      CalendarEvent(
        id: id,
        title: title,
        startTime: startTime,
        endTime: endTime,
        calendarId: calendarId,
        calendarName: calendarName,
        isAllDay: isAllDay,
        location: location,
        description: description,
        colorHex: colorHex,
        resolvedSilenceLevel: resolvedSilenceLevel ?? this.resolvedSilenceLevel,
        matchedKeyword: matchedKeyword ?? this.matchedKeyword,
      );

  @override
  List<Object?> get props => [id, startTime, endTime, resolvedSilenceLevel];
}
