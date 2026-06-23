import 'package:equatable/equatable.dart';

enum KeywordTierAction { fullSilent, vibrate, skip }

class KeywordTier extends Equatable {
  const KeywordTier({
    required this.keyword,
    required this.tier,
    this.isDefault = false,
    this.isEnabled = true,
  });

  final String keyword;
  final KeywordTierAction tier;
  final bool isDefault;
  final bool isEnabled;

  KeywordTier copyWith({KeywordTierAction? tier, bool? isEnabled}) =>
      KeywordTier(
        keyword: keyword,
        tier: tier ?? this.tier,
        isDefault: isDefault,
        isEnabled: isEnabled ?? this.isEnabled,
      );

  @override
  List<Object?> get props => [keyword];
}
