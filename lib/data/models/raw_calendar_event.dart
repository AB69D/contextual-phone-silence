class RawCalendarEvent {
  const RawCalendarEvent({
    required this.eventId,
    required this.title,
    required this.startMs,
    required this.endMs,
    required this.calendarId,
    required this.calendarName,
    required this.allDay,
    this.location,
    this.description,
    this.colorHex,
  });

  final String eventId;
  final String title;
  final int startMs;
  final int endMs;
  final String calendarId;
  final String calendarName;
  final bool allDay;
  final String? location;
  final String? description;
  final String? colorHex;

  factory RawCalendarEvent.fromMap(Map<dynamic, dynamic> map) =>
      RawCalendarEvent(
        eventId: map['eventId'] as String,
        title: map['title'] as String? ?? '(No title)',
        startMs: (map['startMs'] as num).toInt(),
        endMs: (map['endMs'] as num).toInt(),
        calendarId: map['calendarId'] as String,
        calendarName: map['calendarName'] as String? ?? '',
        allDay: (map['allDay'] as bool?) ?? false,
        location: map['location'] as String?,
        description: map['description'] as String?,
        colorHex: map['colorHex'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'eventId': eventId,
        'title': title,
        'startMs': startMs,
        'endMs': endMs,
        'calendarId': calendarId,
        'calendarName': calendarName,
        'allDay': allDay,
        'location': location,
        'description': description,
        'colorHex': colorHex,
      };
}
