// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SilenceSessionsTable extends SilenceSessions
    with TableInfo<$SilenceSessionsTable, SilenceSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SilenceSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _eventTitleMeta =
      const VerificationMeta('eventTitle');
  @override
  late final GeneratedColumn<String> eventTitle = GeneratedColumn<String>(
      'event_title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'start_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
      'end_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _silenceTypeMeta =
      const VerificationMeta('silenceType');
  @override
  late final GeneratedColumn<String> silenceType = GeneratedColumn<String>(
      'silence_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _missedCallCountMeta =
      const VerificationMeta('missedCallCount');
  @override
  late final GeneratedColumn<int> missedCallCount = GeneratedColumn<int>(
      'missed_call_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _restoredMeta =
      const VerificationMeta('restored');
  @override
  late final GeneratedColumn<bool> restored = GeneratedColumn<bool>(
      'restored', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("restored" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _calendarEventIdMeta =
      const VerificationMeta('calendarEventId');
  @override
  late final GeneratedColumn<String> calendarEventId = GeneratedColumn<String>(
      'calendar_event_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        eventTitle,
        startTime,
        endTime,
        silenceType,
        missedCallCount,
        restored,
        calendarEventId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'silence_sessions';
  @override
  VerificationContext validateIntegrity(Insertable<SilenceSession> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('event_title')) {
      context.handle(
          _eventTitleMeta,
          eventTitle.isAcceptableOrUnknown(
              data['event_title']!, _eventTitleMeta));
    } else if (isInserting) {
      context.missing(_eventTitleMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    }
    if (data.containsKey('silence_type')) {
      context.handle(
          _silenceTypeMeta,
          silenceType.isAcceptableOrUnknown(
              data['silence_type']!, _silenceTypeMeta));
    } else if (isInserting) {
      context.missing(_silenceTypeMeta);
    }
    if (data.containsKey('missed_call_count')) {
      context.handle(
          _missedCallCountMeta,
          missedCallCount.isAcceptableOrUnknown(
              data['missed_call_count']!, _missedCallCountMeta));
    }
    if (data.containsKey('restored')) {
      context.handle(_restoredMeta,
          restored.isAcceptableOrUnknown(data['restored']!, _restoredMeta));
    }
    if (data.containsKey('calendar_event_id')) {
      context.handle(
          _calendarEventIdMeta,
          calendarEventId.isAcceptableOrUnknown(
              data['calendar_event_id']!, _calendarEventIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SilenceSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SilenceSession(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      eventTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}event_title'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_time'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_time']),
      silenceType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}silence_type'])!,
      missedCallCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}missed_call_count'])!,
      restored: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}restored'])!,
      calendarEventId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}calendar_event_id']),
    );
  }

  @override
  $SilenceSessionsTable createAlias(String alias) {
    return $SilenceSessionsTable(attachedDatabase, alias);
  }
}

class SilenceSession extends DataClass implements Insertable<SilenceSession> {
  final int id;
  final String eventTitle;
  final DateTime startTime;
  final DateTime? endTime;
  final String silenceType;
  final int missedCallCount;
  final bool restored;
  final String? calendarEventId;
  const SilenceSession(
      {required this.id,
      required this.eventTitle,
      required this.startTime,
      this.endTime,
      required this.silenceType,
      required this.missedCallCount,
      required this.restored,
      this.calendarEventId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['event_title'] = Variable<String>(eventTitle);
    map['start_time'] = Variable<DateTime>(startTime);
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    map['silence_type'] = Variable<String>(silenceType);
    map['missed_call_count'] = Variable<int>(missedCallCount);
    map['restored'] = Variable<bool>(restored);
    if (!nullToAbsent || calendarEventId != null) {
      map['calendar_event_id'] = Variable<String>(calendarEventId);
    }
    return map;
  }

  SilenceSessionsCompanion toCompanion(bool nullToAbsent) {
    return SilenceSessionsCompanion(
      id: Value(id),
      eventTitle: Value(eventTitle),
      startTime: Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      silenceType: Value(silenceType),
      missedCallCount: Value(missedCallCount),
      restored: Value(restored),
      calendarEventId: calendarEventId == null && nullToAbsent
          ? const Value.absent()
          : Value(calendarEventId),
    );
  }

  factory SilenceSession.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SilenceSession(
      id: serializer.fromJson<int>(json['id']),
      eventTitle: serializer.fromJson<String>(json['eventTitle']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      silenceType: serializer.fromJson<String>(json['silenceType']),
      missedCallCount: serializer.fromJson<int>(json['missedCallCount']),
      restored: serializer.fromJson<bool>(json['restored']),
      calendarEventId: serializer.fromJson<String?>(json['calendarEventId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eventTitle': serializer.toJson<String>(eventTitle),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'silenceType': serializer.toJson<String>(silenceType),
      'missedCallCount': serializer.toJson<int>(missedCallCount),
      'restored': serializer.toJson<bool>(restored),
      'calendarEventId': serializer.toJson<String?>(calendarEventId),
    };
  }

  SilenceSession copyWith(
          {int? id,
          String? eventTitle,
          DateTime? startTime,
          Value<DateTime?> endTime = const Value.absent(),
          String? silenceType,
          int? missedCallCount,
          bool? restored,
          Value<String?> calendarEventId = const Value.absent()}) =>
      SilenceSession(
        id: id ?? this.id,
        eventTitle: eventTitle ?? this.eventTitle,
        startTime: startTime ?? this.startTime,
        endTime: endTime.present ? endTime.value : this.endTime,
        silenceType: silenceType ?? this.silenceType,
        missedCallCount: missedCallCount ?? this.missedCallCount,
        restored: restored ?? this.restored,
        calendarEventId: calendarEventId.present
            ? calendarEventId.value
            : this.calendarEventId,
      );
  SilenceSession copyWithCompanion(SilenceSessionsCompanion data) {
    return SilenceSession(
      id: data.id.present ? data.id.value : this.id,
      eventTitle:
          data.eventTitle.present ? data.eventTitle.value : this.eventTitle,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      silenceType:
          data.silenceType.present ? data.silenceType.value : this.silenceType,
      missedCallCount: data.missedCallCount.present
          ? data.missedCallCount.value
          : this.missedCallCount,
      restored: data.restored.present ? data.restored.value : this.restored,
      calendarEventId: data.calendarEventId.present
          ? data.calendarEventId.value
          : this.calendarEventId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SilenceSession(')
          ..write('id: $id, ')
          ..write('eventTitle: $eventTitle, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('silenceType: $silenceType, ')
          ..write('missedCallCount: $missedCallCount, ')
          ..write('restored: $restored, ')
          ..write('calendarEventId: $calendarEventId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, eventTitle, startTime, endTime,
      silenceType, missedCallCount, restored, calendarEventId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SilenceSession &&
          other.id == this.id &&
          other.eventTitle == this.eventTitle &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.silenceType == this.silenceType &&
          other.missedCallCount == this.missedCallCount &&
          other.restored == this.restored &&
          other.calendarEventId == this.calendarEventId);
}

class SilenceSessionsCompanion extends UpdateCompanion<SilenceSession> {
  final Value<int> id;
  final Value<String> eventTitle;
  final Value<DateTime> startTime;
  final Value<DateTime?> endTime;
  final Value<String> silenceType;
  final Value<int> missedCallCount;
  final Value<bool> restored;
  final Value<String?> calendarEventId;
  const SilenceSessionsCompanion({
    this.id = const Value.absent(),
    this.eventTitle = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.silenceType = const Value.absent(),
    this.missedCallCount = const Value.absent(),
    this.restored = const Value.absent(),
    this.calendarEventId = const Value.absent(),
  });
  SilenceSessionsCompanion.insert({
    this.id = const Value.absent(),
    required String eventTitle,
    required DateTime startTime,
    this.endTime = const Value.absent(),
    required String silenceType,
    this.missedCallCount = const Value.absent(),
    this.restored = const Value.absent(),
    this.calendarEventId = const Value.absent(),
  })  : eventTitle = Value(eventTitle),
        startTime = Value(startTime),
        silenceType = Value(silenceType);
  static Insertable<SilenceSession> custom({
    Expression<int>? id,
    Expression<String>? eventTitle,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<String>? silenceType,
    Expression<int>? missedCallCount,
    Expression<bool>? restored,
    Expression<String>? calendarEventId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventTitle != null) 'event_title': eventTitle,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (silenceType != null) 'silence_type': silenceType,
      if (missedCallCount != null) 'missed_call_count': missedCallCount,
      if (restored != null) 'restored': restored,
      if (calendarEventId != null) 'calendar_event_id': calendarEventId,
    });
  }

  SilenceSessionsCompanion copyWith(
      {Value<int>? id,
      Value<String>? eventTitle,
      Value<DateTime>? startTime,
      Value<DateTime?>? endTime,
      Value<String>? silenceType,
      Value<int>? missedCallCount,
      Value<bool>? restored,
      Value<String?>? calendarEventId}) {
    return SilenceSessionsCompanion(
      id: id ?? this.id,
      eventTitle: eventTitle ?? this.eventTitle,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      silenceType: silenceType ?? this.silenceType,
      missedCallCount: missedCallCount ?? this.missedCallCount,
      restored: restored ?? this.restored,
      calendarEventId: calendarEventId ?? this.calendarEventId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eventTitle.present) {
      map['event_title'] = Variable<String>(eventTitle.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (silenceType.present) {
      map['silence_type'] = Variable<String>(silenceType.value);
    }
    if (missedCallCount.present) {
      map['missed_call_count'] = Variable<int>(missedCallCount.value);
    }
    if (restored.present) {
      map['restored'] = Variable<bool>(restored.value);
    }
    if (calendarEventId.present) {
      map['calendar_event_id'] = Variable<String>(calendarEventId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SilenceSessionsCompanion(')
          ..write('id: $id, ')
          ..write('eventTitle: $eventTitle, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('silenceType: $silenceType, ')
          ..write('missedCallCount: $missedCallCount, ')
          ..write('restored: $restored, ')
          ..write('calendarEventId: $calendarEventId')
          ..write(')'))
        .toString();
  }
}

class $ScheduledEventsTable extends ScheduledEvents
    with TableInfo<$ScheduledEventsTable, ScheduledEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScheduledEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _calendarEventIdMeta =
      const VerificationMeta('calendarEventId');
  @override
  late final GeneratedColumn<String> calendarEventId = GeneratedColumn<String>(
      'calendar_event_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'start_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
      'end_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _silenceLevelMeta =
      const VerificationMeta('silenceLevel');
  @override
  late final GeneratedColumn<String> silenceLevel = GeneratedColumn<String>(
      'silence_level', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, calendarEventId, title, startTime, endTime, silenceLevel, status];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scheduled_events';
  @override
  VerificationContext validateIntegrity(Insertable<ScheduledEvent> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('calendar_event_id')) {
      context.handle(
          _calendarEventIdMeta,
          calendarEventId.isAcceptableOrUnknown(
              data['calendar_event_id']!, _calendarEventIdMeta));
    } else if (isInserting) {
      context.missing(_calendarEventIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('silence_level')) {
      context.handle(
          _silenceLevelMeta,
          silenceLevel.isAcceptableOrUnknown(
              data['silence_level']!, _silenceLevelMeta));
    } else if (isInserting) {
      context.missing(_silenceLevelMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScheduledEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScheduledEvent(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      calendarEventId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}calendar_event_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_time'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_time'])!,
      silenceLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}silence_level'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $ScheduledEventsTable createAlias(String alias) {
    return $ScheduledEventsTable(attachedDatabase, alias);
  }
}

class ScheduledEvent extends DataClass implements Insertable<ScheduledEvent> {
  final int id;
  final String calendarEventId;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String silenceLevel;
  final String status;
  const ScheduledEvent(
      {required this.id,
      required this.calendarEventId,
      required this.title,
      required this.startTime,
      required this.endTime,
      required this.silenceLevel,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['calendar_event_id'] = Variable<String>(calendarEventId);
    map['title'] = Variable<String>(title);
    map['start_time'] = Variable<DateTime>(startTime);
    map['end_time'] = Variable<DateTime>(endTime);
    map['silence_level'] = Variable<String>(silenceLevel);
    map['status'] = Variable<String>(status);
    return map;
  }

  ScheduledEventsCompanion toCompanion(bool nullToAbsent) {
    return ScheduledEventsCompanion(
      id: Value(id),
      calendarEventId: Value(calendarEventId),
      title: Value(title),
      startTime: Value(startTime),
      endTime: Value(endTime),
      silenceLevel: Value(silenceLevel),
      status: Value(status),
    );
  }

  factory ScheduledEvent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduledEvent(
      id: serializer.fromJson<int>(json['id']),
      calendarEventId: serializer.fromJson<String>(json['calendarEventId']),
      title: serializer.fromJson<String>(json['title']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
      silenceLevel: serializer.fromJson<String>(json['silenceLevel']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'calendarEventId': serializer.toJson<String>(calendarEventId),
      'title': serializer.toJson<String>(title),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
      'silenceLevel': serializer.toJson<String>(silenceLevel),
      'status': serializer.toJson<String>(status),
    };
  }

  ScheduledEvent copyWith(
          {int? id,
          String? calendarEventId,
          String? title,
          DateTime? startTime,
          DateTime? endTime,
          String? silenceLevel,
          String? status}) =>
      ScheduledEvent(
        id: id ?? this.id,
        calendarEventId: calendarEventId ?? this.calendarEventId,
        title: title ?? this.title,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        silenceLevel: silenceLevel ?? this.silenceLevel,
        status: status ?? this.status,
      );
  ScheduledEvent copyWithCompanion(ScheduledEventsCompanion data) {
    return ScheduledEvent(
      id: data.id.present ? data.id.value : this.id,
      calendarEventId: data.calendarEventId.present
          ? data.calendarEventId.value
          : this.calendarEventId,
      title: data.title.present ? data.title.value : this.title,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      silenceLevel: data.silenceLevel.present
          ? data.silenceLevel.value
          : this.silenceLevel,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScheduledEvent(')
          ..write('id: $id, ')
          ..write('calendarEventId: $calendarEventId, ')
          ..write('title: $title, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('silenceLevel: $silenceLevel, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, calendarEventId, title, startTime, endTime, silenceLevel, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduledEvent &&
          other.id == this.id &&
          other.calendarEventId == this.calendarEventId &&
          other.title == this.title &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.silenceLevel == this.silenceLevel &&
          other.status == this.status);
}

class ScheduledEventsCompanion extends UpdateCompanion<ScheduledEvent> {
  final Value<int> id;
  final Value<String> calendarEventId;
  final Value<String> title;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  final Value<String> silenceLevel;
  final Value<String> status;
  const ScheduledEventsCompanion({
    this.id = const Value.absent(),
    this.calendarEventId = const Value.absent(),
    this.title = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.silenceLevel = const Value.absent(),
    this.status = const Value.absent(),
  });
  ScheduledEventsCompanion.insert({
    this.id = const Value.absent(),
    required String calendarEventId,
    required String title,
    required DateTime startTime,
    required DateTime endTime,
    required String silenceLevel,
    this.status = const Value.absent(),
  })  : calendarEventId = Value(calendarEventId),
        title = Value(title),
        startTime = Value(startTime),
        endTime = Value(endTime),
        silenceLevel = Value(silenceLevel);
  static Insertable<ScheduledEvent> custom({
    Expression<int>? id,
    Expression<String>? calendarEventId,
    Expression<String>? title,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<String>? silenceLevel,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (calendarEventId != null) 'calendar_event_id': calendarEventId,
      if (title != null) 'title': title,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (silenceLevel != null) 'silence_level': silenceLevel,
      if (status != null) 'status': status,
    });
  }

  ScheduledEventsCompanion copyWith(
      {Value<int>? id,
      Value<String>? calendarEventId,
      Value<String>? title,
      Value<DateTime>? startTime,
      Value<DateTime>? endTime,
      Value<String>? silenceLevel,
      Value<String>? status}) {
    return ScheduledEventsCompanion(
      id: id ?? this.id,
      calendarEventId: calendarEventId ?? this.calendarEventId,
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      silenceLevel: silenceLevel ?? this.silenceLevel,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (calendarEventId.present) {
      map['calendar_event_id'] = Variable<String>(calendarEventId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (silenceLevel.present) {
      map['silence_level'] = Variable<String>(silenceLevel.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScheduledEventsCompanion(')
          ..write('id: $id, ')
          ..write('calendarEventId: $calendarEventId, ')
          ..write('title: $title, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('silenceLevel: $silenceLevel, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $VipContactsTable extends VipContacts
    with TableInfo<$VipContactsTable, VipContact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VipContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _contactIdMeta =
      const VerificationMeta('contactId');
  @override
  late final GeneratedColumn<String> contactId = GeneratedColumn<String>(
      'contact_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneNumbersJsonMeta =
      const VerificationMeta('phoneNumbersJson');
  @override
  late final GeneratedColumn<String> phoneNumbersJson = GeneratedColumn<String>(
      'phone_numbers_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  @override
  List<GeneratedColumn> get $columns => [id, contactId, name, phoneNumbersJson];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vip_contacts';
  @override
  VerificationContext validateIntegrity(Insertable<VipContact> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('contact_id')) {
      context.handle(_contactIdMeta,
          contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta));
    } else if (isInserting) {
      context.missing(_contactIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone_numbers_json')) {
      context.handle(
          _phoneNumbersJsonMeta,
          phoneNumbersJson.isAcceptableOrUnknown(
              data['phone_numbers_json']!, _phoneNumbersJsonMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VipContact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VipContact(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      contactId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contact_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      phoneNumbersJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}phone_numbers_json'])!,
    );
  }

  @override
  $VipContactsTable createAlias(String alias) {
    return $VipContactsTable(attachedDatabase, alias);
  }
}

class VipContact extends DataClass implements Insertable<VipContact> {
  final int id;
  final String contactId;
  final String name;
  final String phoneNumbersJson;
  const VipContact(
      {required this.id,
      required this.contactId,
      required this.name,
      required this.phoneNumbersJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['contact_id'] = Variable<String>(contactId);
    map['name'] = Variable<String>(name);
    map['phone_numbers_json'] = Variable<String>(phoneNumbersJson);
    return map;
  }

  VipContactsCompanion toCompanion(bool nullToAbsent) {
    return VipContactsCompanion(
      id: Value(id),
      contactId: Value(contactId),
      name: Value(name),
      phoneNumbersJson: Value(phoneNumbersJson),
    );
  }

  factory VipContact.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VipContact(
      id: serializer.fromJson<int>(json['id']),
      contactId: serializer.fromJson<String>(json['contactId']),
      name: serializer.fromJson<String>(json['name']),
      phoneNumbersJson: serializer.fromJson<String>(json['phoneNumbersJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'contactId': serializer.toJson<String>(contactId),
      'name': serializer.toJson<String>(name),
      'phoneNumbersJson': serializer.toJson<String>(phoneNumbersJson),
    };
  }

  VipContact copyWith(
          {int? id,
          String? contactId,
          String? name,
          String? phoneNumbersJson}) =>
      VipContact(
        id: id ?? this.id,
        contactId: contactId ?? this.contactId,
        name: name ?? this.name,
        phoneNumbersJson: phoneNumbersJson ?? this.phoneNumbersJson,
      );
  VipContact copyWithCompanion(VipContactsCompanion data) {
    return VipContact(
      id: data.id.present ? data.id.value : this.id,
      contactId: data.contactId.present ? data.contactId.value : this.contactId,
      name: data.name.present ? data.name.value : this.name,
      phoneNumbersJson: data.phoneNumbersJson.present
          ? data.phoneNumbersJson.value
          : this.phoneNumbersJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VipContact(')
          ..write('id: $id, ')
          ..write('contactId: $contactId, ')
          ..write('name: $name, ')
          ..write('phoneNumbersJson: $phoneNumbersJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, contactId, name, phoneNumbersJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VipContact &&
          other.id == this.id &&
          other.contactId == this.contactId &&
          other.name == this.name &&
          other.phoneNumbersJson == this.phoneNumbersJson);
}

class VipContactsCompanion extends UpdateCompanion<VipContact> {
  final Value<int> id;
  final Value<String> contactId;
  final Value<String> name;
  final Value<String> phoneNumbersJson;
  const VipContactsCompanion({
    this.id = const Value.absent(),
    this.contactId = const Value.absent(),
    this.name = const Value.absent(),
    this.phoneNumbersJson = const Value.absent(),
  });
  VipContactsCompanion.insert({
    this.id = const Value.absent(),
    required String contactId,
    required String name,
    this.phoneNumbersJson = const Value.absent(),
  })  : contactId = Value(contactId),
        name = Value(name);
  static Insertable<VipContact> custom({
    Expression<int>? id,
    Expression<String>? contactId,
    Expression<String>? name,
    Expression<String>? phoneNumbersJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (contactId != null) 'contact_id': contactId,
      if (name != null) 'name': name,
      if (phoneNumbersJson != null) 'phone_numbers_json': phoneNumbersJson,
    });
  }

  VipContactsCompanion copyWith(
      {Value<int>? id,
      Value<String>? contactId,
      Value<String>? name,
      Value<String>? phoneNumbersJson}) {
    return VipContactsCompanion(
      id: id ?? this.id,
      contactId: contactId ?? this.contactId,
      name: name ?? this.name,
      phoneNumbersJson: phoneNumbersJson ?? this.phoneNumbersJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (contactId.present) {
      map['contact_id'] = Variable<String>(contactId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phoneNumbersJson.present) {
      map['phone_numbers_json'] = Variable<String>(phoneNumbersJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VipContactsCompanion(')
          ..write('id: $id, ')
          ..write('contactId: $contactId, ')
          ..write('name: $name, ')
          ..write('phoneNumbersJson: $phoneNumbersJson')
          ..write(')'))
        .toString();
  }
}

class $KeywordTiersTable extends KeywordTiers
    with TableInfo<$KeywordTiersTable, KeywordTier> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KeywordTiersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keywordMeta =
      const VerificationMeta('keyword');
  @override
  late final GeneratedColumn<String> keyword = GeneratedColumn<String>(
      'keyword', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tierMeta = const VerificationMeta('tier');
  @override
  late final GeneratedColumn<String> tier = GeneratedColumn<String>(
      'tier', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isDefaultMeta =
      const VerificationMeta('isDefault');
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
      'is_default', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_default" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isEnabledMeta =
      const VerificationMeta('isEnabled');
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
      'is_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [keyword, tier, isDefault, isEnabled];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'keyword_tiers';
  @override
  VerificationContext validateIntegrity(Insertable<KeywordTier> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('keyword')) {
      context.handle(_keywordMeta,
          keyword.isAcceptableOrUnknown(data['keyword']!, _keywordMeta));
    } else if (isInserting) {
      context.missing(_keywordMeta);
    }
    if (data.containsKey('tier')) {
      context.handle(
          _tierMeta, tier.isAcceptableOrUnknown(data['tier']!, _tierMeta));
    } else if (isInserting) {
      context.missing(_tierMeta);
    }
    if (data.containsKey('is_default')) {
      context.handle(_isDefaultMeta,
          isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta));
    }
    if (data.containsKey('is_enabled')) {
      context.handle(_isEnabledMeta,
          isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {keyword};
  @override
  KeywordTier map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KeywordTier(
      keyword: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}keyword'])!,
      tier: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tier'])!,
      isDefault: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_default'])!,
      isEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_enabled'])!,
    );
  }

  @override
  $KeywordTiersTable createAlias(String alias) {
    return $KeywordTiersTable(attachedDatabase, alias);
  }
}

class KeywordTier extends DataClass implements Insertable<KeywordTier> {
  final String keyword;
  final String tier;
  final bool isDefault;
  final bool isEnabled;
  const KeywordTier(
      {required this.keyword,
      required this.tier,
      required this.isDefault,
      required this.isEnabled});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['keyword'] = Variable<String>(keyword);
    map['tier'] = Variable<String>(tier);
    map['is_default'] = Variable<bool>(isDefault);
    map['is_enabled'] = Variable<bool>(isEnabled);
    return map;
  }

  KeywordTiersCompanion toCompanion(bool nullToAbsent) {
    return KeywordTiersCompanion(
      keyword: Value(keyword),
      tier: Value(tier),
      isDefault: Value(isDefault),
      isEnabled: Value(isEnabled),
    );
  }

  factory KeywordTier.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KeywordTier(
      keyword: serializer.fromJson<String>(json['keyword']),
      tier: serializer.fromJson<String>(json['tier']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'keyword': serializer.toJson<String>(keyword),
      'tier': serializer.toJson<String>(tier),
      'isDefault': serializer.toJson<bool>(isDefault),
      'isEnabled': serializer.toJson<bool>(isEnabled),
    };
  }

  KeywordTier copyWith(
          {String? keyword, String? tier, bool? isDefault, bool? isEnabled}) =>
      KeywordTier(
        keyword: keyword ?? this.keyword,
        tier: tier ?? this.tier,
        isDefault: isDefault ?? this.isDefault,
        isEnabled: isEnabled ?? this.isEnabled,
      );
  KeywordTier copyWithCompanion(KeywordTiersCompanion data) {
    return KeywordTier(
      keyword: data.keyword.present ? data.keyword.value : this.keyword,
      tier: data.tier.present ? data.tier.value : this.tier,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KeywordTier(')
          ..write('keyword: $keyword, ')
          ..write('tier: $tier, ')
          ..write('isDefault: $isDefault, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(keyword, tier, isDefault, isEnabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KeywordTier &&
          other.keyword == this.keyword &&
          other.tier == this.tier &&
          other.isDefault == this.isDefault &&
          other.isEnabled == this.isEnabled);
}

class KeywordTiersCompanion extends UpdateCompanion<KeywordTier> {
  final Value<String> keyword;
  final Value<String> tier;
  final Value<bool> isDefault;
  final Value<bool> isEnabled;
  final Value<int> rowid;
  const KeywordTiersCompanion({
    this.keyword = const Value.absent(),
    this.tier = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KeywordTiersCompanion.insert({
    required String keyword,
    required String tier,
    this.isDefault = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : keyword = Value(keyword),
        tier = Value(tier);
  static Insertable<KeywordTier> custom({
    Expression<String>? keyword,
    Expression<String>? tier,
    Expression<bool>? isDefault,
    Expression<bool>? isEnabled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (keyword != null) 'keyword': keyword,
      if (tier != null) 'tier': tier,
      if (isDefault != null) 'is_default': isDefault,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KeywordTiersCompanion copyWith(
      {Value<String>? keyword,
      Value<String>? tier,
      Value<bool>? isDefault,
      Value<bool>? isEnabled,
      Value<int>? rowid}) {
    return KeywordTiersCompanion(
      keyword: keyword ?? this.keyword,
      tier: tier ?? this.tier,
      isDefault: isDefault ?? this.isDefault,
      isEnabled: isEnabled ?? this.isEnabled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (keyword.present) {
      map['keyword'] = Variable<String>(keyword.value);
    }
    if (tier.present) {
      map['tier'] = Variable<String>(tier.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KeywordTiersCompanion(')
          ..write('keyword: $keyword, ')
          ..write('tier: $tier, ')
          ..write('isDefault: $isDefault, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SilenceProfilesTable extends SilenceProfiles
    with TableInfo<$SilenceProfilesTable, SilenceProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SilenceProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<int> icon = GeneratedColumn<int>(
      'icon', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0xe047));
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
      'color', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0xFF7C68EE));
  static const VerificationMeta _keywordOverridesJsonMeta =
      const VerificationMeta('keywordOverridesJson');
  @override
  late final GeneratedColumn<String> keywordOverridesJson =
      GeneratedColumn<String>('keyword_overrides_json', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('[]'));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, icon, color, keywordOverridesJson, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'silence_profiles';
  @override
  VerificationContext validateIntegrity(Insertable<SilenceProfile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('keyword_overrides_json')) {
      context.handle(
          _keywordOverridesJsonMeta,
          keywordOverridesJson.isAcceptableOrUnknown(
              data['keyword_overrides_json']!, _keywordOverridesJsonMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SilenceProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SilenceProfile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}icon'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color'])!,
      keywordOverridesJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}keyword_overrides_json'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $SilenceProfilesTable createAlias(String alias) {
    return $SilenceProfilesTable(attachedDatabase, alias);
  }
}

class SilenceProfile extends DataClass implements Insertable<SilenceProfile> {
  final int id;
  final String name;
  final int icon;
  final int color;
  final String keywordOverridesJson;
  final bool isActive;
  const SilenceProfile(
      {required this.id,
      required this.name,
      required this.icon,
      required this.color,
      required this.keywordOverridesJson,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<int>(icon);
    map['color'] = Variable<int>(color);
    map['keyword_overrides_json'] = Variable<String>(keywordOverridesJson);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  SilenceProfilesCompanion toCompanion(bool nullToAbsent) {
    return SilenceProfilesCompanion(
      id: Value(id),
      name: Value(name),
      icon: Value(icon),
      color: Value(color),
      keywordOverridesJson: Value(keywordOverridesJson),
      isActive: Value(isActive),
    );
  }

  factory SilenceProfile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SilenceProfile(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<int>(json['icon']),
      color: serializer.fromJson<int>(json['color']),
      keywordOverridesJson:
          serializer.fromJson<String>(json['keywordOverridesJson']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<int>(icon),
      'color': serializer.toJson<int>(color),
      'keywordOverridesJson': serializer.toJson<String>(keywordOverridesJson),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  SilenceProfile copyWith(
          {int? id,
          String? name,
          int? icon,
          int? color,
          String? keywordOverridesJson,
          bool? isActive}) =>
      SilenceProfile(
        id: id ?? this.id,
        name: name ?? this.name,
        icon: icon ?? this.icon,
        color: color ?? this.color,
        keywordOverridesJson: keywordOverridesJson ?? this.keywordOverridesJson,
        isActive: isActive ?? this.isActive,
      );
  SilenceProfile copyWithCompanion(SilenceProfilesCompanion data) {
    return SilenceProfile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
      color: data.color.present ? data.color.value : this.color,
      keywordOverridesJson: data.keywordOverridesJson.present
          ? data.keywordOverridesJson.value
          : this.keywordOverridesJson,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SilenceProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('keywordOverridesJson: $keywordOverridesJson, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, icon, color, keywordOverridesJson, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SilenceProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.color == this.color &&
          other.keywordOverridesJson == this.keywordOverridesJson &&
          other.isActive == this.isActive);
}

class SilenceProfilesCompanion extends UpdateCompanion<SilenceProfile> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> icon;
  final Value<int> color;
  final Value<String> keywordOverridesJson;
  final Value<bool> isActive;
  const SilenceProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.keywordOverridesJson = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  SilenceProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.keywordOverridesJson = const Value.absent(),
    this.isActive = const Value.absent(),
  }) : name = Value(name);
  static Insertable<SilenceProfile> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? icon,
    Expression<int>? color,
    Expression<String>? keywordOverridesJson,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      if (keywordOverridesJson != null)
        'keyword_overrides_json': keywordOverridesJson,
      if (isActive != null) 'is_active': isActive,
    });
  }

  SilenceProfilesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? icon,
      Value<int>? color,
      Value<String>? keywordOverridesJson,
      Value<bool>? isActive}) {
    return SilenceProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      keywordOverridesJson: keywordOverridesJson ?? this.keywordOverridesJson,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<int>(icon.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (keywordOverridesJson.present) {
      map['keyword_overrides_json'] =
          Variable<String>(keywordOverridesJson.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SilenceProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('keywordOverridesJson: $keywordOverridesJson, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(Insertable<AppSetting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String key;
  final String value;
  const AppSetting({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      key: Value(key),
      value: Value(value),
    );
  }

  factory AppSetting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppSetting copyWith({String? key, String? value}) => AppSetting(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.key == this.key &&
          other.value == this.value);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<AppSetting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith(
      {Value<String>? key, Value<String>? value, Value<int>? rowid}) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MissedNotificationsTable extends MissedNotifications
    with TableInfo<$MissedNotificationsTable, MissedNotification> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MissedNotificationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
      'session_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES silence_sessions (id) ON DELETE CASCADE'));
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('other'));
  static const VerificationMeta _appPackageNameMeta =
      const VerificationMeta('appPackageName');
  @override
  late final GeneratedColumn<String> appPackageName = GeneratedColumn<String>(
      'app_package_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _senderNameMeta =
      const VerificationMeta('senderName');
  @override
  late final GeneratedColumn<String> senderName = GeneratedColumn<String>(
      'sender_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _previewMeta =
      const VerificationMeta('preview');
  @override
  late final GeneratedColumn<String> preview = GeneratedColumn<String>(
      'preview', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _receivedAtMeta =
      const VerificationMeta('receivedAt');
  @override
  late final GeneratedColumn<DateTime> receivedAt = GeneratedColumn<DateTime>(
      'received_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _digestShownMeta =
      const VerificationMeta('digestShown');
  @override
  late final GeneratedColumn<bool> digestShown = GeneratedColumn<bool>(
      'digest_shown', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("digest_shown" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sessionId,
        category,
        appPackageName,
        senderName,
        preview,
        receivedAt,
        digestShown
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'missed_notifications';
  @override
  VerificationContext validateIntegrity(Insertable<MissedNotification> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('app_package_name')) {
      context.handle(
          _appPackageNameMeta,
          appPackageName.isAcceptableOrUnknown(
              data['app_package_name']!, _appPackageNameMeta));
    } else if (isInserting) {
      context.missing(_appPackageNameMeta);
    }
    if (data.containsKey('sender_name')) {
      context.handle(
          _senderNameMeta,
          senderName.isAcceptableOrUnknown(
              data['sender_name']!, _senderNameMeta));
    }
    if (data.containsKey('preview')) {
      context.handle(_previewMeta,
          preview.isAcceptableOrUnknown(data['preview']!, _previewMeta));
    }
    if (data.containsKey('received_at')) {
      context.handle(
          _receivedAtMeta,
          receivedAt.isAcceptableOrUnknown(
              data['received_at']!, _receivedAtMeta));
    } else if (isInserting) {
      context.missing(_receivedAtMeta);
    }
    if (data.containsKey('digest_shown')) {
      context.handle(
          _digestShownMeta,
          digestShown.isAcceptableOrUnknown(
              data['digest_shown']!, _digestShownMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MissedNotification map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MissedNotification(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}session_id'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      appPackageName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}app_package_name'])!,
      senderName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sender_name']),
      preview: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}preview']),
      receivedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}received_at'])!,
      digestShown: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}digest_shown'])!,
    );
  }

  @override
  $MissedNotificationsTable createAlias(String alias) {
    return $MissedNotificationsTable(attachedDatabase, alias);
  }
}

class MissedNotification extends DataClass
    implements Insertable<MissedNotification> {
  final int id;
  final int sessionId;
  final String category;
  final String appPackageName;
  final String? senderName;
  final String? preview;
  final DateTime receivedAt;
  final bool digestShown;
  const MissedNotification(
      {required this.id,
      required this.sessionId,
      required this.category,
      required this.appPackageName,
      this.senderName,
      this.preview,
      required this.receivedAt,
      required this.digestShown});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<int>(sessionId);
    map['category'] = Variable<String>(category);
    map['app_package_name'] = Variable<String>(appPackageName);
    if (!nullToAbsent || senderName != null) {
      map['sender_name'] = Variable<String>(senderName);
    }
    if (!nullToAbsent || preview != null) {
      map['preview'] = Variable<String>(preview);
    }
    map['received_at'] = Variable<DateTime>(receivedAt);
    map['digest_shown'] = Variable<bool>(digestShown);
    return map;
  }

  MissedNotificationsCompanion toCompanion(bool nullToAbsent) {
    return MissedNotificationsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      category: Value(category),
      appPackageName: Value(appPackageName),
      senderName: senderName == null && nullToAbsent
          ? const Value.absent()
          : Value(senderName),
      preview: preview == null && nullToAbsent
          ? const Value.absent()
          : Value(preview),
      receivedAt: Value(receivedAt),
      digestShown: Value(digestShown),
    );
  }

  factory MissedNotification.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MissedNotification(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<int>(json['sessionId']),
      category: serializer.fromJson<String>(json['category']),
      appPackageName: serializer.fromJson<String>(json['appPackageName']),
      senderName: serializer.fromJson<String?>(json['senderName']),
      preview: serializer.fromJson<String?>(json['preview']),
      receivedAt: serializer.fromJson<DateTime>(json['receivedAt']),
      digestShown: serializer.fromJson<bool>(json['digestShown']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<int>(sessionId),
      'category': serializer.toJson<String>(category),
      'appPackageName': serializer.toJson<String>(appPackageName),
      'senderName': serializer.toJson<String?>(senderName),
      'preview': serializer.toJson<String?>(preview),
      'receivedAt': serializer.toJson<DateTime>(receivedAt),
      'digestShown': serializer.toJson<bool>(digestShown),
    };
  }

  MissedNotification copyWith(
          {int? id,
          int? sessionId,
          String? category,
          String? appPackageName,
          Value<String?> senderName = const Value.absent(),
          Value<String?> preview = const Value.absent(),
          DateTime? receivedAt,
          bool? digestShown}) =>
      MissedNotification(
        id: id ?? this.id,
        sessionId: sessionId ?? this.sessionId,
        category: category ?? this.category,
        appPackageName: appPackageName ?? this.appPackageName,
        senderName: senderName.present ? senderName.value : this.senderName,
        preview: preview.present ? preview.value : this.preview,
        receivedAt: receivedAt ?? this.receivedAt,
        digestShown: digestShown ?? this.digestShown,
      );
  MissedNotification copyWithCompanion(MissedNotificationsCompanion data) {
    return MissedNotification(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      category: data.category.present ? data.category.value : this.category,
      appPackageName: data.appPackageName.present
          ? data.appPackageName.value
          : this.appPackageName,
      senderName:
          data.senderName.present ? data.senderName.value : this.senderName,
      preview: data.preview.present ? data.preview.value : this.preview,
      receivedAt:
          data.receivedAt.present ? data.receivedAt.value : this.receivedAt,
      digestShown:
          data.digestShown.present ? data.digestShown.value : this.digestShown,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MissedNotification(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('category: $category, ')
          ..write('appPackageName: $appPackageName, ')
          ..write('senderName: $senderName, ')
          ..write('preview: $preview, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('digestShown: $digestShown')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionId, category, appPackageName,
      senderName, preview, receivedAt, digestShown);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MissedNotification &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.category == this.category &&
          other.appPackageName == this.appPackageName &&
          other.senderName == this.senderName &&
          other.preview == this.preview &&
          other.receivedAt == this.receivedAt &&
          other.digestShown == this.digestShown);
}

class MissedNotificationsCompanion extends UpdateCompanion<MissedNotification> {
  final Value<int> id;
  final Value<int> sessionId;
  final Value<String> category;
  final Value<String> appPackageName;
  final Value<String?> senderName;
  final Value<String?> preview;
  final Value<DateTime> receivedAt;
  final Value<bool> digestShown;
  const MissedNotificationsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.category = const Value.absent(),
    this.appPackageName = const Value.absent(),
    this.senderName = const Value.absent(),
    this.preview = const Value.absent(),
    this.receivedAt = const Value.absent(),
    this.digestShown = const Value.absent(),
  });
  MissedNotificationsCompanion.insert({
    this.id = const Value.absent(),
    required int sessionId,
    this.category = const Value.absent(),
    required String appPackageName,
    this.senderName = const Value.absent(),
    this.preview = const Value.absent(),
    required DateTime receivedAt,
    this.digestShown = const Value.absent(),
  })  : sessionId = Value(sessionId),
        appPackageName = Value(appPackageName),
        receivedAt = Value(receivedAt);
  static Insertable<MissedNotification> custom({
    Expression<int>? id,
    Expression<int>? sessionId,
    Expression<String>? category,
    Expression<String>? appPackageName,
    Expression<String>? senderName,
    Expression<String>? preview,
    Expression<DateTime>? receivedAt,
    Expression<bool>? digestShown,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (category != null) 'category': category,
      if (appPackageName != null) 'app_package_name': appPackageName,
      if (senderName != null) 'sender_name': senderName,
      if (preview != null) 'preview': preview,
      if (receivedAt != null) 'received_at': receivedAt,
      if (digestShown != null) 'digest_shown': digestShown,
    });
  }

  MissedNotificationsCompanion copyWith(
      {Value<int>? id,
      Value<int>? sessionId,
      Value<String>? category,
      Value<String>? appPackageName,
      Value<String?>? senderName,
      Value<String?>? preview,
      Value<DateTime>? receivedAt,
      Value<bool>? digestShown}) {
    return MissedNotificationsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      category: category ?? this.category,
      appPackageName: appPackageName ?? this.appPackageName,
      senderName: senderName ?? this.senderName,
      preview: preview ?? this.preview,
      receivedAt: receivedAt ?? this.receivedAt,
      digestShown: digestShown ?? this.digestShown,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (appPackageName.present) {
      map['app_package_name'] = Variable<String>(appPackageName.value);
    }
    if (senderName.present) {
      map['sender_name'] = Variable<String>(senderName.value);
    }
    if (preview.present) {
      map['preview'] = Variable<String>(preview.value);
    }
    if (receivedAt.present) {
      map['received_at'] = Variable<DateTime>(receivedAt.value);
    }
    if (digestShown.present) {
      map['digest_shown'] = Variable<bool>(digestShown.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MissedNotificationsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('category: $category, ')
          ..write('appPackageName: $appPackageName, ')
          ..write('senderName: $senderName, ')
          ..write('preview: $preview, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('digestShown: $digestShown')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SilenceSessionsTable silenceSessions =
      $SilenceSessionsTable(this);
  late final $ScheduledEventsTable scheduledEvents =
      $ScheduledEventsTable(this);
  late final $VipContactsTable vipContacts = $VipContactsTable(this);
  late final $KeywordTiersTable keywordTiers = $KeywordTiersTable(this);
  late final $SilenceProfilesTable silenceProfiles =
      $SilenceProfilesTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $MissedNotificationsTable missedNotifications =
      $MissedNotificationsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        silenceSessions,
        scheduledEvents,
        vipContacts,
        keywordTiers,
        silenceProfiles,
        appSettings,
        missedNotifications
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('silence_sessions',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('missed_notifications', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$SilenceSessionsTableCreateCompanionBuilder = SilenceSessionsCompanion
    Function({
  Value<int> id,
  required String eventTitle,
  required DateTime startTime,
  Value<DateTime?> endTime,
  required String silenceType,
  Value<int> missedCallCount,
  Value<bool> restored,
  Value<String?> calendarEventId,
});
typedef $$SilenceSessionsTableUpdateCompanionBuilder = SilenceSessionsCompanion
    Function({
  Value<int> id,
  Value<String> eventTitle,
  Value<DateTime> startTime,
  Value<DateTime?> endTime,
  Value<String> silenceType,
  Value<int> missedCallCount,
  Value<bool> restored,
  Value<String?> calendarEventId,
});

final class $$SilenceSessionsTableReferences extends BaseReferences<
    _$AppDatabase, $SilenceSessionsTable, SilenceSession> {
  $$SilenceSessionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MissedNotificationsTable,
      List<MissedNotification>> _missedNotificationsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.missedNotifications,
          aliasName: $_aliasNameGenerator(
              db.silenceSessions.id, db.missedNotifications.sessionId));

  $$MissedNotificationsTableProcessedTableManager get missedNotificationsRefs {
    final manager =
        $$MissedNotificationsTableTableManager($_db, $_db.missedNotifications)
            .filter((f) => f.sessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_missedNotificationsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SilenceSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $SilenceSessionsTable> {
  $$SilenceSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get eventTitle => $composableBuilder(
      column: $table.eventTitle, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get silenceType => $composableBuilder(
      column: $table.silenceType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get missedCallCount => $composableBuilder(
      column: $table.missedCallCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get restored => $composableBuilder(
      column: $table.restored, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get calendarEventId => $composableBuilder(
      column: $table.calendarEventId,
      builder: (column) => ColumnFilters(column));

  Expression<bool> missedNotificationsRefs(
      Expression<bool> Function($$MissedNotificationsTableFilterComposer f) f) {
    final $$MissedNotificationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.missedNotifications,
        getReferencedColumn: (t) => t.sessionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MissedNotificationsTableFilterComposer(
              $db: $db,
              $table: $db.missedNotifications,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SilenceSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SilenceSessionsTable> {
  $$SilenceSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get eventTitle => $composableBuilder(
      column: $table.eventTitle, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get silenceType => $composableBuilder(
      column: $table.silenceType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get missedCallCount => $composableBuilder(
      column: $table.missedCallCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get restored => $composableBuilder(
      column: $table.restored, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get calendarEventId => $composableBuilder(
      column: $table.calendarEventId,
      builder: (column) => ColumnOrderings(column));
}

class $$SilenceSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SilenceSessionsTable> {
  $$SilenceSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get eventTitle => $composableBuilder(
      column: $table.eventTitle, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get silenceType => $composableBuilder(
      column: $table.silenceType, builder: (column) => column);

  GeneratedColumn<int> get missedCallCount => $composableBuilder(
      column: $table.missedCallCount, builder: (column) => column);

  GeneratedColumn<bool> get restored =>
      $composableBuilder(column: $table.restored, builder: (column) => column);

  GeneratedColumn<String> get calendarEventId => $composableBuilder(
      column: $table.calendarEventId, builder: (column) => column);

  Expression<T> missedNotificationsRefs<T extends Object>(
      Expression<T> Function($$MissedNotificationsTableAnnotationComposer a)
          f) {
    final $$MissedNotificationsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.missedNotifications,
            getReferencedColumn: (t) => t.sessionId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$MissedNotificationsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.missedNotifications,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$SilenceSessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SilenceSessionsTable,
    SilenceSession,
    $$SilenceSessionsTableFilterComposer,
    $$SilenceSessionsTableOrderingComposer,
    $$SilenceSessionsTableAnnotationComposer,
    $$SilenceSessionsTableCreateCompanionBuilder,
    $$SilenceSessionsTableUpdateCompanionBuilder,
    (SilenceSession, $$SilenceSessionsTableReferences),
    SilenceSession,
    PrefetchHooks Function({bool missedNotificationsRefs})> {
  $$SilenceSessionsTableTableManager(
      _$AppDatabase db, $SilenceSessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SilenceSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SilenceSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SilenceSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> eventTitle = const Value.absent(),
            Value<DateTime> startTime = const Value.absent(),
            Value<DateTime?> endTime = const Value.absent(),
            Value<String> silenceType = const Value.absent(),
            Value<int> missedCallCount = const Value.absent(),
            Value<bool> restored = const Value.absent(),
            Value<String?> calendarEventId = const Value.absent(),
          }) =>
              SilenceSessionsCompanion(
            id: id,
            eventTitle: eventTitle,
            startTime: startTime,
            endTime: endTime,
            silenceType: silenceType,
            missedCallCount: missedCallCount,
            restored: restored,
            calendarEventId: calendarEventId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String eventTitle,
            required DateTime startTime,
            Value<DateTime?> endTime = const Value.absent(),
            required String silenceType,
            Value<int> missedCallCount = const Value.absent(),
            Value<bool> restored = const Value.absent(),
            Value<String?> calendarEventId = const Value.absent(),
          }) =>
              SilenceSessionsCompanion.insert(
            id: id,
            eventTitle: eventTitle,
            startTime: startTime,
            endTime: endTime,
            silenceType: silenceType,
            missedCallCount: missedCallCount,
            restored: restored,
            calendarEventId: calendarEventId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SilenceSessionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({missedNotificationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (missedNotificationsRefs) db.missedNotifications
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (missedNotificationsRefs)
                    await $_getPrefetchedData<SilenceSession,
                            $SilenceSessionsTable, MissedNotification>(
                        currentTable: table,
                        referencedTable: $$SilenceSessionsTableReferences
                            ._missedNotificationsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SilenceSessionsTableReferences(db, table, p0)
                                .missedNotificationsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.sessionId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SilenceSessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SilenceSessionsTable,
    SilenceSession,
    $$SilenceSessionsTableFilterComposer,
    $$SilenceSessionsTableOrderingComposer,
    $$SilenceSessionsTableAnnotationComposer,
    $$SilenceSessionsTableCreateCompanionBuilder,
    $$SilenceSessionsTableUpdateCompanionBuilder,
    (SilenceSession, $$SilenceSessionsTableReferences),
    SilenceSession,
    PrefetchHooks Function({bool missedNotificationsRefs})>;
typedef $$ScheduledEventsTableCreateCompanionBuilder = ScheduledEventsCompanion
    Function({
  Value<int> id,
  required String calendarEventId,
  required String title,
  required DateTime startTime,
  required DateTime endTime,
  required String silenceLevel,
  Value<String> status,
});
typedef $$ScheduledEventsTableUpdateCompanionBuilder = ScheduledEventsCompanion
    Function({
  Value<int> id,
  Value<String> calendarEventId,
  Value<String> title,
  Value<DateTime> startTime,
  Value<DateTime> endTime,
  Value<String> silenceLevel,
  Value<String> status,
});

class $$ScheduledEventsTableFilterComposer
    extends Composer<_$AppDatabase, $ScheduledEventsTable> {
  $$ScheduledEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get calendarEventId => $composableBuilder(
      column: $table.calendarEventId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get silenceLevel => $composableBuilder(
      column: $table.silenceLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));
}

class $$ScheduledEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $ScheduledEventsTable> {
  $$ScheduledEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get calendarEventId => $composableBuilder(
      column: $table.calendarEventId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get silenceLevel => $composableBuilder(
      column: $table.silenceLevel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));
}

class $$ScheduledEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScheduledEventsTable> {
  $$ScheduledEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get calendarEventId => $composableBuilder(
      column: $table.calendarEventId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get silenceLevel => $composableBuilder(
      column: $table.silenceLevel, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$ScheduledEventsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ScheduledEventsTable,
    ScheduledEvent,
    $$ScheduledEventsTableFilterComposer,
    $$ScheduledEventsTableOrderingComposer,
    $$ScheduledEventsTableAnnotationComposer,
    $$ScheduledEventsTableCreateCompanionBuilder,
    $$ScheduledEventsTableUpdateCompanionBuilder,
    (
      ScheduledEvent,
      BaseReferences<_$AppDatabase, $ScheduledEventsTable, ScheduledEvent>
    ),
    ScheduledEvent,
    PrefetchHooks Function()> {
  $$ScheduledEventsTableTableManager(
      _$AppDatabase db, $ScheduledEventsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScheduledEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScheduledEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScheduledEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> calendarEventId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<DateTime> startTime = const Value.absent(),
            Value<DateTime> endTime = const Value.absent(),
            Value<String> silenceLevel = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              ScheduledEventsCompanion(
            id: id,
            calendarEventId: calendarEventId,
            title: title,
            startTime: startTime,
            endTime: endTime,
            silenceLevel: silenceLevel,
            status: status,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String calendarEventId,
            required String title,
            required DateTime startTime,
            required DateTime endTime,
            required String silenceLevel,
            Value<String> status = const Value.absent(),
          }) =>
              ScheduledEventsCompanion.insert(
            id: id,
            calendarEventId: calendarEventId,
            title: title,
            startTime: startTime,
            endTime: endTime,
            silenceLevel: silenceLevel,
            status: status,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ScheduledEventsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ScheduledEventsTable,
    ScheduledEvent,
    $$ScheduledEventsTableFilterComposer,
    $$ScheduledEventsTableOrderingComposer,
    $$ScheduledEventsTableAnnotationComposer,
    $$ScheduledEventsTableCreateCompanionBuilder,
    $$ScheduledEventsTableUpdateCompanionBuilder,
    (
      ScheduledEvent,
      BaseReferences<_$AppDatabase, $ScheduledEventsTable, ScheduledEvent>
    ),
    ScheduledEvent,
    PrefetchHooks Function()>;
typedef $$VipContactsTableCreateCompanionBuilder = VipContactsCompanion
    Function({
  Value<int> id,
  required String contactId,
  required String name,
  Value<String> phoneNumbersJson,
});
typedef $$VipContactsTableUpdateCompanionBuilder = VipContactsCompanion
    Function({
  Value<int> id,
  Value<String> contactId,
  Value<String> name,
  Value<String> phoneNumbersJson,
});

class $$VipContactsTableFilterComposer
    extends Composer<_$AppDatabase, $VipContactsTable> {
  $$VipContactsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contactId => $composableBuilder(
      column: $table.contactId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phoneNumbersJson => $composableBuilder(
      column: $table.phoneNumbersJson,
      builder: (column) => ColumnFilters(column));
}

class $$VipContactsTableOrderingComposer
    extends Composer<_$AppDatabase, $VipContactsTable> {
  $$VipContactsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contactId => $composableBuilder(
      column: $table.contactId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phoneNumbersJson => $composableBuilder(
      column: $table.phoneNumbersJson,
      builder: (column) => ColumnOrderings(column));
}

class $$VipContactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VipContactsTable> {
  $$VipContactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get contactId =>
      $composableBuilder(column: $table.contactId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phoneNumbersJson => $composableBuilder(
      column: $table.phoneNumbersJson, builder: (column) => column);
}

class $$VipContactsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VipContactsTable,
    VipContact,
    $$VipContactsTableFilterComposer,
    $$VipContactsTableOrderingComposer,
    $$VipContactsTableAnnotationComposer,
    $$VipContactsTableCreateCompanionBuilder,
    $$VipContactsTableUpdateCompanionBuilder,
    (VipContact, BaseReferences<_$AppDatabase, $VipContactsTable, VipContact>),
    VipContact,
    PrefetchHooks Function()> {
  $$VipContactsTableTableManager(_$AppDatabase db, $VipContactsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VipContactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VipContactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VipContactsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> contactId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> phoneNumbersJson = const Value.absent(),
          }) =>
              VipContactsCompanion(
            id: id,
            contactId: contactId,
            name: name,
            phoneNumbersJson: phoneNumbersJson,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String contactId,
            required String name,
            Value<String> phoneNumbersJson = const Value.absent(),
          }) =>
              VipContactsCompanion.insert(
            id: id,
            contactId: contactId,
            name: name,
            phoneNumbersJson: phoneNumbersJson,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$VipContactsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VipContactsTable,
    VipContact,
    $$VipContactsTableFilterComposer,
    $$VipContactsTableOrderingComposer,
    $$VipContactsTableAnnotationComposer,
    $$VipContactsTableCreateCompanionBuilder,
    $$VipContactsTableUpdateCompanionBuilder,
    (VipContact, BaseReferences<_$AppDatabase, $VipContactsTable, VipContact>),
    VipContact,
    PrefetchHooks Function()>;
typedef $$KeywordTiersTableCreateCompanionBuilder = KeywordTiersCompanion
    Function({
  required String keyword,
  required String tier,
  Value<bool> isDefault,
  Value<bool> isEnabled,
  Value<int> rowid,
});
typedef $$KeywordTiersTableUpdateCompanionBuilder = KeywordTiersCompanion
    Function({
  Value<String> keyword,
  Value<String> tier,
  Value<bool> isDefault,
  Value<bool> isEnabled,
  Value<int> rowid,
});

class $$KeywordTiersTableFilterComposer
    extends Composer<_$AppDatabase, $KeywordTiersTable> {
  $$KeywordTiersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get keyword => $composableBuilder(
      column: $table.keyword, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tier => $composableBuilder(
      column: $table.tier, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDefault => $composableBuilder(
      column: $table.isDefault, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isEnabled => $composableBuilder(
      column: $table.isEnabled, builder: (column) => ColumnFilters(column));
}

class $$KeywordTiersTableOrderingComposer
    extends Composer<_$AppDatabase, $KeywordTiersTable> {
  $$KeywordTiersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get keyword => $composableBuilder(
      column: $table.keyword, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tier => $composableBuilder(
      column: $table.tier, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDefault => $composableBuilder(
      column: $table.isDefault, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
      column: $table.isEnabled, builder: (column) => ColumnOrderings(column));
}

class $$KeywordTiersTableAnnotationComposer
    extends Composer<_$AppDatabase, $KeywordTiersTable> {
  $$KeywordTiersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get keyword =>
      $composableBuilder(column: $table.keyword, builder: (column) => column);

  GeneratedColumn<String> get tier =>
      $composableBuilder(column: $table.tier, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);
}

class $$KeywordTiersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $KeywordTiersTable,
    KeywordTier,
    $$KeywordTiersTableFilterComposer,
    $$KeywordTiersTableOrderingComposer,
    $$KeywordTiersTableAnnotationComposer,
    $$KeywordTiersTableCreateCompanionBuilder,
    $$KeywordTiersTableUpdateCompanionBuilder,
    (
      KeywordTier,
      BaseReferences<_$AppDatabase, $KeywordTiersTable, KeywordTier>
    ),
    KeywordTier,
    PrefetchHooks Function()> {
  $$KeywordTiersTableTableManager(_$AppDatabase db, $KeywordTiersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KeywordTiersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KeywordTiersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KeywordTiersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> keyword = const Value.absent(),
            Value<String> tier = const Value.absent(),
            Value<bool> isDefault = const Value.absent(),
            Value<bool> isEnabled = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              KeywordTiersCompanion(
            keyword: keyword,
            tier: tier,
            isDefault: isDefault,
            isEnabled: isEnabled,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String keyword,
            required String tier,
            Value<bool> isDefault = const Value.absent(),
            Value<bool> isEnabled = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              KeywordTiersCompanion.insert(
            keyword: keyword,
            tier: tier,
            isDefault: isDefault,
            isEnabled: isEnabled,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$KeywordTiersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $KeywordTiersTable,
    KeywordTier,
    $$KeywordTiersTableFilterComposer,
    $$KeywordTiersTableOrderingComposer,
    $$KeywordTiersTableAnnotationComposer,
    $$KeywordTiersTableCreateCompanionBuilder,
    $$KeywordTiersTableUpdateCompanionBuilder,
    (
      KeywordTier,
      BaseReferences<_$AppDatabase, $KeywordTiersTable, KeywordTier>
    ),
    KeywordTier,
    PrefetchHooks Function()>;
typedef $$SilenceProfilesTableCreateCompanionBuilder = SilenceProfilesCompanion
    Function({
  Value<int> id,
  required String name,
  Value<int> icon,
  Value<int> color,
  Value<String> keywordOverridesJson,
  Value<bool> isActive,
});
typedef $$SilenceProfilesTableUpdateCompanionBuilder = SilenceProfilesCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<int> icon,
  Value<int> color,
  Value<String> keywordOverridesJson,
  Value<bool> isActive,
});

class $$SilenceProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $SilenceProfilesTable> {
  $$SilenceProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get keywordOverridesJson => $composableBuilder(
      column: $table.keywordOverridesJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));
}

class $$SilenceProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $SilenceProfilesTable> {
  $$SilenceProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get keywordOverridesJson => $composableBuilder(
      column: $table.keywordOverridesJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));
}

class $$SilenceProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SilenceProfilesTable> {
  $$SilenceProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get keywordOverridesJson => $composableBuilder(
      column: $table.keywordOverridesJson, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$SilenceProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SilenceProfilesTable,
    SilenceProfile,
    $$SilenceProfilesTableFilterComposer,
    $$SilenceProfilesTableOrderingComposer,
    $$SilenceProfilesTableAnnotationComposer,
    $$SilenceProfilesTableCreateCompanionBuilder,
    $$SilenceProfilesTableUpdateCompanionBuilder,
    (
      SilenceProfile,
      BaseReferences<_$AppDatabase, $SilenceProfilesTable, SilenceProfile>
    ),
    SilenceProfile,
    PrefetchHooks Function()> {
  $$SilenceProfilesTableTableManager(
      _$AppDatabase db, $SilenceProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SilenceProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SilenceProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SilenceProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> icon = const Value.absent(),
            Value<int> color = const Value.absent(),
            Value<String> keywordOverridesJson = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
          }) =>
              SilenceProfilesCompanion(
            id: id,
            name: name,
            icon: icon,
            color: color,
            keywordOverridesJson: keywordOverridesJson,
            isActive: isActive,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<int> icon = const Value.absent(),
            Value<int> color = const Value.absent(),
            Value<String> keywordOverridesJson = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
          }) =>
              SilenceProfilesCompanion.insert(
            id: id,
            name: name,
            icon: icon,
            color: color,
            keywordOverridesJson: keywordOverridesJson,
            isActive: isActive,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SilenceProfilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SilenceProfilesTable,
    SilenceProfile,
    $$SilenceProfilesTableFilterComposer,
    $$SilenceProfilesTableOrderingComposer,
    $$SilenceProfilesTableAnnotationComposer,
    $$SilenceProfilesTableCreateCompanionBuilder,
    $$SilenceProfilesTableUpdateCompanionBuilder,
    (
      SilenceProfile,
      BaseReferences<_$AppDatabase, $SilenceProfilesTable, SilenceProfile>
    ),
    SilenceProfile,
    PrefetchHooks Function()>;
typedef $$AppSettingsTableCreateCompanionBuilder = AppSettingsCompanion
    Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$AppSettingsTableUpdateCompanionBuilder = AppSettingsCompanion
    Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppSettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppSettingsTable,
    AppSetting,
    $$AppSettingsTableFilterComposer,
    $$AppSettingsTableOrderingComposer,
    $$AppSettingsTableAnnotationComposer,
    $$AppSettingsTableCreateCompanionBuilder,
    $$AppSettingsTableUpdateCompanionBuilder,
    (AppSetting, BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>),
    AppSetting,
    PrefetchHooks Function()> {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppSettingsCompanion(
            key: key,
            value: value,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) =>
              AppSettingsCompanion.insert(
            key: key,
            value: value,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppSettingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppSettingsTable,
    AppSetting,
    $$AppSettingsTableFilterComposer,
    $$AppSettingsTableOrderingComposer,
    $$AppSettingsTableAnnotationComposer,
    $$AppSettingsTableCreateCompanionBuilder,
    $$AppSettingsTableUpdateCompanionBuilder,
    (AppSetting, BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>),
    AppSetting,
    PrefetchHooks Function()>;
typedef $$MissedNotificationsTableCreateCompanionBuilder
    = MissedNotificationsCompanion Function({
  Value<int> id,
  required int sessionId,
  Value<String> category,
  required String appPackageName,
  Value<String?> senderName,
  Value<String?> preview,
  required DateTime receivedAt,
  Value<bool> digestShown,
});
typedef $$MissedNotificationsTableUpdateCompanionBuilder
    = MissedNotificationsCompanion Function({
  Value<int> id,
  Value<int> sessionId,
  Value<String> category,
  Value<String> appPackageName,
  Value<String?> senderName,
  Value<String?> preview,
  Value<DateTime> receivedAt,
  Value<bool> digestShown,
});

final class $$MissedNotificationsTableReferences extends BaseReferences<
    _$AppDatabase, $MissedNotificationsTable, MissedNotification> {
  $$MissedNotificationsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $SilenceSessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.silenceSessions.createAlias($_aliasNameGenerator(
          db.missedNotifications.sessionId, db.silenceSessions.id));

  $$SilenceSessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<int>('session_id')!;

    final manager =
        $$SilenceSessionsTableTableManager($_db, $_db.silenceSessions)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MissedNotificationsTableFilterComposer
    extends Composer<_$AppDatabase, $MissedNotificationsTable> {
  $$MissedNotificationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get appPackageName => $composableBuilder(
      column: $table.appPackageName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get senderName => $composableBuilder(
      column: $table.senderName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get preview => $composableBuilder(
      column: $table.preview, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get receivedAt => $composableBuilder(
      column: $table.receivedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get digestShown => $composableBuilder(
      column: $table.digestShown, builder: (column) => ColumnFilters(column));

  $$SilenceSessionsTableFilterComposer get sessionId {
    final $$SilenceSessionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionId,
        referencedTable: $db.silenceSessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SilenceSessionsTableFilterComposer(
              $db: $db,
              $table: $db.silenceSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MissedNotificationsTableOrderingComposer
    extends Composer<_$AppDatabase, $MissedNotificationsTable> {
  $$MissedNotificationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get appPackageName => $composableBuilder(
      column: $table.appPackageName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get senderName => $composableBuilder(
      column: $table.senderName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get preview => $composableBuilder(
      column: $table.preview, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get receivedAt => $composableBuilder(
      column: $table.receivedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get digestShown => $composableBuilder(
      column: $table.digestShown, builder: (column) => ColumnOrderings(column));

  $$SilenceSessionsTableOrderingComposer get sessionId {
    final $$SilenceSessionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionId,
        referencedTable: $db.silenceSessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SilenceSessionsTableOrderingComposer(
              $db: $db,
              $table: $db.silenceSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MissedNotificationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MissedNotificationsTable> {
  $$MissedNotificationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get appPackageName => $composableBuilder(
      column: $table.appPackageName, builder: (column) => column);

  GeneratedColumn<String> get senderName => $composableBuilder(
      column: $table.senderName, builder: (column) => column);

  GeneratedColumn<String> get preview =>
      $composableBuilder(column: $table.preview, builder: (column) => column);

  GeneratedColumn<DateTime> get receivedAt => $composableBuilder(
      column: $table.receivedAt, builder: (column) => column);

  GeneratedColumn<bool> get digestShown => $composableBuilder(
      column: $table.digestShown, builder: (column) => column);

  $$SilenceSessionsTableAnnotationComposer get sessionId {
    final $$SilenceSessionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionId,
        referencedTable: $db.silenceSessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SilenceSessionsTableAnnotationComposer(
              $db: $db,
              $table: $db.silenceSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MissedNotificationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MissedNotificationsTable,
    MissedNotification,
    $$MissedNotificationsTableFilterComposer,
    $$MissedNotificationsTableOrderingComposer,
    $$MissedNotificationsTableAnnotationComposer,
    $$MissedNotificationsTableCreateCompanionBuilder,
    $$MissedNotificationsTableUpdateCompanionBuilder,
    (MissedNotification, $$MissedNotificationsTableReferences),
    MissedNotification,
    PrefetchHooks Function({bool sessionId})> {
  $$MissedNotificationsTableTableManager(
      _$AppDatabase db, $MissedNotificationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MissedNotificationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MissedNotificationsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MissedNotificationsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> sessionId = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> appPackageName = const Value.absent(),
            Value<String?> senderName = const Value.absent(),
            Value<String?> preview = const Value.absent(),
            Value<DateTime> receivedAt = const Value.absent(),
            Value<bool> digestShown = const Value.absent(),
          }) =>
              MissedNotificationsCompanion(
            id: id,
            sessionId: sessionId,
            category: category,
            appPackageName: appPackageName,
            senderName: senderName,
            preview: preview,
            receivedAt: receivedAt,
            digestShown: digestShown,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int sessionId,
            Value<String> category = const Value.absent(),
            required String appPackageName,
            Value<String?> senderName = const Value.absent(),
            Value<String?> preview = const Value.absent(),
            required DateTime receivedAt,
            Value<bool> digestShown = const Value.absent(),
          }) =>
              MissedNotificationsCompanion.insert(
            id: id,
            sessionId: sessionId,
            category: category,
            appPackageName: appPackageName,
            senderName: senderName,
            preview: preview,
            receivedAt: receivedAt,
            digestShown: digestShown,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MissedNotificationsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({sessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (sessionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sessionId,
                    referencedTable: $$MissedNotificationsTableReferences
                        ._sessionIdTable(db),
                    referencedColumn: $$MissedNotificationsTableReferences
                        ._sessionIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$MissedNotificationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MissedNotificationsTable,
    MissedNotification,
    $$MissedNotificationsTableFilterComposer,
    $$MissedNotificationsTableOrderingComposer,
    $$MissedNotificationsTableAnnotationComposer,
    $$MissedNotificationsTableCreateCompanionBuilder,
    $$MissedNotificationsTableUpdateCompanionBuilder,
    (MissedNotification, $$MissedNotificationsTableReferences),
    MissedNotification,
    PrefetchHooks Function({bool sessionId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SilenceSessionsTableTableManager get silenceSessions =>
      $$SilenceSessionsTableTableManager(_db, _db.silenceSessions);
  $$ScheduledEventsTableTableManager get scheduledEvents =>
      $$ScheduledEventsTableTableManager(_db, _db.scheduledEvents);
  $$VipContactsTableTableManager get vipContacts =>
      $$VipContactsTableTableManager(_db, _db.vipContacts);
  $$KeywordTiersTableTableManager get keywordTiers =>
      $$KeywordTiersTableTableManager(_db, _db.keywordTiers);
  $$SilenceProfilesTableTableManager get silenceProfiles =>
      $$SilenceProfilesTableTableManager(_db, _db.silenceProfiles);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$MissedNotificationsTableTableManager get missedNotifications =>
      $$MissedNotificationsTableTableManager(_db, _db.missedNotifications);
}
