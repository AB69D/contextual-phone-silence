import 'package:equatable/equatable.dart';

class SilenceSchedule extends Equatable {
  const SilenceSchedule({
    this.id,
    required this.name,
    this.targetProfileId,
    this.isEnabled = true,
    this.keywordFilter,
    this.calendarIds = const [],
  });

  final int? id;
  final String name;
  final int? targetProfileId;
  final bool isEnabled;
  final String? keywordFilter;
  final List<String> calendarIds;

  SilenceSchedule copyWith({
    int? id,
    String? name,
    int? targetProfileId,
    bool? isEnabled,
    String? keywordFilter,
    List<String>? calendarIds,
  }) =>
      SilenceSchedule(
        id: id ?? this.id,
        name: name ?? this.name,
        targetProfileId: targetProfileId ?? this.targetProfileId,
        isEnabled: isEnabled ?? this.isEnabled,
        keywordFilter: keywordFilter ?? this.keywordFilter,
        calendarIds: calendarIds ?? this.calendarIds,
      );

  @override
  List<Object?> get props => [id, name];
}
