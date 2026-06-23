import 'package:equatable/equatable.dart';

class SilenceProfile extends Equatable {
  const SilenceProfile({
    this.id,
    required this.name,
    required this.icon,
    required this.color,
    this.keywordOverrides = const [],
    this.isActive = false,
  });

  final int? id;
  final String name;
  final int icon;
  final int color;
  final List<String> keywordOverrides;
  final bool isActive;

  SilenceProfile copyWith({
    int? id,
    String? name,
    int? icon,
    int? color,
    List<String>? keywordOverrides,
    bool? isActive,
  }) =>
      SilenceProfile(
        id: id ?? this.id,
        name: name ?? this.name,
        icon: icon ?? this.icon,
        color: color ?? this.color,
        keywordOverrides: keywordOverrides ?? this.keywordOverrides,
        isActive: isActive ?? this.isActive,
      );

  @override
  List<Object?> get props => [id, name, isActive];
}
