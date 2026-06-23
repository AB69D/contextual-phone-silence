import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

// ─────────────────────────── Tables ─────────────────────────────────────────

class SilenceSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get eventTitle => text()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime().nullable()();
  TextColumn get silenceType => text()(); // 'automatic' | 'manual'
  IntColumn get missedCallCount => integer().withDefault(const Constant(0))();
  BoolColumn get restored => boolean().withDefault(const Constant(false))();
  TextColumn get calendarEventId => text().nullable()();
}

class ScheduledEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get calendarEventId => text().unique()();
  TextColumn get title => text()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime()();
  TextColumn get silenceLevel => text()(); // 'none' | 'vibrate' | 'fullSilent'
  TextColumn get status => text().withDefault(const Constant('pending'))();
}

class VipContacts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get contactId => text()();
  TextColumn get name => text()();
  TextColumn get phoneNumbersJson => text().withDefault(const Constant('[]'))();
}

class KeywordTiers extends Table {
  TextColumn get keyword => text()();
  TextColumn get tier => text()(); // 'fullSilent' | 'vibrate' | 'skip'
  BoolColumn get isDefault =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get isEnabled =>
      boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {keyword};
}

class SilenceProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get icon => integer().withDefault(const Constant(0xe047))(); // Icons.work
  IntColumn get color => integer().withDefault(const Constant(0xFF7C68EE))();
  TextColumn get keywordOverridesJson =>
      text().withDefault(const Constant('[]'))();
  BoolColumn get isActive =>
      boolean().withDefault(const Constant(false))();
}

class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

class MissedNotifications extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sessionId => integer().references(SilenceSessions, #id,
      onDelete: KeyAction.cascade)();
  TextColumn get category =>
      text().withDefault(const Constant('other'))(); // 'call' | 'message' | 'other'
  TextColumn get appPackageName => text()();
  TextColumn get senderName => text().nullable()();
  TextColumn get preview =>
      text().nullable()(); // max 200 chars — enforced in app layer
  DateTimeColumn get receivedAt => dateTime()();
  BoolColumn get digestShown =>
      boolean().withDefault(const Constant(false))();
}

// ─────────────────────────── Database ────────────────────────────────────────

@DriftDatabase(tables: [
  SilenceSessions,
  ScheduledEvents,
  VipContacts,
  KeywordTiers,
  SilenceProfiles,
  AppSettings,
  MissedNotifications,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seedDefaultKeywords();
          await _seedDefaultProfile();
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  // ── Silence Sessions ──────────────────────────────────────────────────────

  Future<int> insertSession(SilenceSessionsCompanion entry) =>
      into(silenceSessions).insert(entry);

  Future<void> updateSession(SilenceSessionsCompanion entry) =>
      (update(silenceSessions)..where((t) => t.id.equals(entry.id.value)))
          .write(entry);

  Future<List<SilenceSession>> getRecentSessions({int limit = 30}) =>
      (select(silenceSessions)
            ..orderBy([(t) => OrderingTerm.desc(t.startTime)])
            ..limit(limit))
          .get();

  Future<List<SilenceSession>> getSessionsInRange(
          DateTime from, DateTime to) =>
      (select(silenceSessions)
            ..where((t) => t.startTime.isBetweenValues(from, to))
            ..orderBy([(t) => OrderingTerm.desc(t.startTime)]))
          .get();

  Stream<List<SilenceSession>> watchRecentSessions({int limit = 30}) =>
      (select(silenceSessions)
            ..orderBy([(t) => OrderingTerm.desc(t.startTime)])
            ..limit(limit))
          .watch();

  Future<SilenceSession?> getActiveSession() =>
      (select(silenceSessions)
            ..where((t) => t.endTime.isNull())
            ..limit(1))
          .getSingleOrNull();

  Future<void> incrementMissedCalls(int sessionId) =>
      customUpdate(
        'UPDATE silence_sessions SET missed_call_count = missed_call_count + 1 WHERE id = ?',
        variables: [Variable.withInt(sessionId)],
        updates: {silenceSessions},
      );

  // ── Scheduled Events ──────────────────────────────────────────────────────

  Future<void> upsertScheduledEvent(ScheduledEventsCompanion entry) =>
      into(scheduledEvents).insertOnConflictUpdate(entry);

  Future<void> updateScheduledEventStatus(
          String calendarEventId, String status) =>
      (update(scheduledEvents)
            ..where((t) => t.calendarEventId.equals(calendarEventId)))
          .write(ScheduledEventsCompanion(status: Value(status)));

  Future<List<ScheduledEvent>> getPendingScheduledEvents() =>
      (select(scheduledEvents)
            ..where((t) => t.status.equals('pending'))
            ..orderBy([(t) => OrderingTerm.asc(t.startTime)]))
          .get();

  Stream<List<ScheduledEvent>> watchPendingScheduledEvents() =>
      (select(scheduledEvents)
            ..where((t) => t.status.equals('pending'))
            ..orderBy([(t) => OrderingTerm.asc(t.startTime)]))
          .watch();

  Future<int> deleteScheduledEvent(String calendarEventId) =>
      (delete(scheduledEvents)
            ..where((t) => t.calendarEventId.equals(calendarEventId)))
          .go();

  // ── VIP Contacts ──────────────────────────────────────────────────────────

  Future<List<VipContact>> getAllVipContacts() => select(vipContacts).get();

  Stream<List<VipContact>> watchVipContacts() =>
      select(vipContacts).watch();

  Future<int> insertVipContact(VipContactsCompanion entry) =>
      into(vipContacts).insert(entry);

  Future<int> deleteVipContact(int id) =>
      (delete(vipContacts)..where((t) => t.id.equals(id))).go();

  // ── Keyword Tiers ─────────────────────────────────────────────────────────

  Future<List<KeywordTier>> getAllKeywordTiers() =>
      select(keywordTiers).get();

  Stream<List<KeywordTier>> watchKeywordTiers() =>
      select(keywordTiers).watch();

  Future<void> upsertKeywordTier(KeywordTiersCompanion entry) =>
      into(keywordTiers).insertOnConflictUpdate(entry);

  Future<int> deleteKeywordTier(String keyword) =>
      (delete(keywordTiers)..where((t) => t.keyword.equals(keyword))).go();

  // ── Silence Profiles ──────────────────────────────────────────────────────

  Future<List<SilenceProfile>> getAllProfiles() =>
      select(silenceProfiles).get();

  Stream<List<SilenceProfile>> watchProfiles() =>
      select(silenceProfiles).watch();

  Future<SilenceProfile?> getActiveProfile() =>
      (select(silenceProfiles)
            ..where((t) => t.isActive.equals(true))
            ..limit(1))
          .getSingleOrNull();

  Future<int> insertProfile(SilenceProfilesCompanion entry) =>
      into(silenceProfiles).insert(entry);

  Future<void> updateProfile(SilenceProfilesCompanion entry) =>
      (update(silenceProfiles)..where((t) => t.id.equals(entry.id.value)))
          .write(entry);

  Future<int> deleteProfile(int id) =>
      (delete(silenceProfiles)..where((t) => t.id.equals(id))).go();

  Future<void> activateProfile(int id) async {
    await transaction(() async {
      await (update(silenceProfiles))
          .write(const SilenceProfilesCompanion(isActive: Value(false)));
      await (update(silenceProfiles)..where((t) => t.id.equals(id)))
          .write(const SilenceProfilesCompanion(isActive: Value(true)));
    });
  }

  // ── App Settings ──────────────────────────────────────────────────────────

  Future<String?> getSetting(String key) async {
    final row = await (select(appSettings)
          ..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    return row?.value;
  }

  Future<void> setSetting(String key, String value) =>
      into(appSettings).insertOnConflictUpdate(
          AppSettingsCompanion(key: Value(key), value: Value(value)));

  // ── Missed Notifications ──────────────────────────────────────────────────

  Future<void> insertMissedNotification(
          MissedNotificationsCompanion entry) =>
      into(missedNotifications).insert(entry);

  Future<List<MissedNotification>> getMissedForSession(
          int sessionId) =>
      (select(missedNotifications)
            ..where((t) => t.sessionId.equals(sessionId))
            ..orderBy([(t) => OrderingTerm.desc(t.receivedAt)]))
          .get();

  Future<void> markDigestShown(int sessionId) =>
      (update(missedNotifications)
            ..where((t) => t.sessionId.equals(sessionId)))
          .write(const MissedNotificationsCompanion(
              digestShown: Value(true)));

  Stream<int> watchUnshownCount() {
    final query = selectOnly(missedNotifications)
      ..addColumns([missedNotifications.id.count()])
      ..where(missedNotifications.digestShown.equals(false));
    return query.map((row) => row.read(missedNotifications.id.count()) ?? 0)
        .watchSingle();
  }

  Future<int> pruneBefore(DateTime before) =>
      (delete(missedNotifications)
            ..where((t) => t.receivedAt.isSmallerThanValue(before)))
          .go();

  // ── Seeds ─────────────────────────────────────────────────────────────────

  Future<void> _seedDefaultKeywords() async {
    final defaults = [
      ('meeting', 'fullSilent'),
      ('interview', 'fullSilent'),
      ('standup', 'fullSilent'),
      ('call', 'fullSilent'),
      ('surgery', 'fullSilent'),
      ('appointment', 'fullSilent'),
      ('class', 'fullSilent'),
      ('lecture', 'fullSilent'),
      ('exam', 'fullSilent'),
      ('prayer', 'fullSilent'),
      ('cinema', 'fullSilent'),
      ('gym', 'vibrate'),
      ('lunch', 'skip'),
    ];
    for (final (kw, tier) in defaults) {
      await into(keywordTiers).insert(KeywordTiersCompanion(
        keyword: Value(kw),
        tier: Value(tier),
        isDefault: const Value(true),
      ));
    }
  }

  Future<void> _seedDefaultProfile() async {
    await into(silenceProfiles).insert(const SilenceProfilesCompanion(
      name: Value('Work'),
      icon: Value(0xe047),
      color: Value(0xFF7C68EE),
      isActive: Value(true),
    ));
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'contextual_silence.db'));
    return NativeDatabase.createInBackground(file);
  });
}
