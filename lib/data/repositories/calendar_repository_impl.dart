import 'dart:convert';
import '../../domain/entities/calendar_event.dart';
import '../../domain/repositories/i_calendar_repository.dart';
import '../../core/error/result.dart';
import '../datasources/calendar_data_source.dart';
import '../database/app_database.dart' as db;

class CalendarRepositoryImpl implements ICalendarRepository {
  const CalendarRepositoryImpl({
    required this.calendarDataSource,
    required this.database,
  });

  final CalendarDataSource calendarDataSource;
  final db.AppDatabase database;

  @override
  Future<bool> hasCalendarPermission() =>
      calendarDataSource.hasPermission();

  @override
  Future<Result<bool>> requestCalendarPermission() =>
      Result.guardAsync(() => calendarDataSource.requestPermission());

  @override
  Future<Result<List<CalendarEvent>>> getUpcomingEvents({
    int lookaheadHours = 24,
    List<String> calendarIds = const [],
  }) =>
      getEventsInRange(
        DateTime.now(),
        DateTime.now().add(Duration(hours: lookaheadHours)),
      );

  @override
  Future<Result<List<CalendarEvent>>> getEventsInRange(
      DateTime from, DateTime to) async {
    return Result.guardAsync(() async {
      final rawEvents = await calendarDataSource.getEvents(
        fromMillis: from.millisecondsSinceEpoch,
        toMillis: to.millisecondsSinceEpoch,
      );

      final keywordTierRows = await database.getAllKeywordTiers();
      final activeProfile = await database.getActiveProfile();

      List<String> profileKeywords = [];
      if (activeProfile != null) {
        try {
          final decoded =
              jsonDecode(activeProfile.keywordOverridesJson) as List;
          profileKeywords = decoded.cast<String>();
        } catch (_) {}
      }

      return rawEvents
          .where((r) => !r.allDay)
          .map((r) {
            final resolved = _resolveKeywordTier(
              title: r.title,
              description: r.description ?? '',
              keywordTiers: keywordTierRows,
              profileKeywords: profileKeywords,
            );
            return CalendarEvent(
              id: r.eventId,
              title: r.title,
              startTime:
                  DateTime.fromMillisecondsSinceEpoch(r.startMs),
              endTime: DateTime.fromMillisecondsSinceEpoch(r.endMs),
              calendarId: r.calendarId,
              calendarName: r.calendarName,
              isAllDay: r.allDay,
              location: r.location,
              description: r.description,
              colorHex: r.colorHex,
              resolvedSilenceLevel: resolved.$1,
              matchedKeyword: resolved.$2,
            );
          })
          .toList();
    });
  }

  @override
  Future<Result<CalendarEvent?>> getEventById(
      String calendarEventId) async {
    return Result.guardAsync(() async {
      final raw =
          await calendarDataSource.getEventById(calendarEventId);
      if (raw == null) return null;
      return CalendarEvent(
        id: raw.eventId,
        title: raw.title,
        startTime: DateTime.fromMillisecondsSinceEpoch(raw.startMs),
        endTime: DateTime.fromMillisecondsSinceEpoch(raw.endMs),
        calendarId: raw.calendarId,
        calendarName: raw.calendarName,
        isAllDay: raw.allDay,
        location: raw.location,
        description: raw.description,
        colorHex: raw.colorHex,
      );
    });
  }

  (SilenceLevel, String?) _resolveKeywordTier({
    required String title,
    required String description,
    required List<db.KeywordTier> keywordTiers,
    required List<String> profileKeywords,
  }) {
    final searchText = '${title.toLowerCase()} ${description.toLowerCase()}';

    for (final kw in profileKeywords) {
      if (searchText.contains(kw.toLowerCase())) {
        return (SilenceLevel.none, kw);
      }
    }

    db.KeywordTier? matched;
    for (final tier in keywordTiers) {
      if (!tier.isEnabled) continue;
      if (searchText.contains(tier.keyword.toLowerCase())) {
        if (matched == null ||
            tier.keyword.length > matched.keyword.length) {
          matched = tier;
        }
      }
    }

    if (matched == null) return (SilenceLevel.none, null);

    return switch (matched.tier) {
      'fullSilent' => (SilenceLevel.fullSilent, matched.keyword),
      'vibrate' => (SilenceLevel.vibrate, matched.keyword),
      _ => (SilenceLevel.none, matched.keyword),
    };
  }
}
