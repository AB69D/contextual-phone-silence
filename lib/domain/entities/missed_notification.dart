import 'package:equatable/equatable.dart';

enum NotificationCategory { call, message, other }

class MissedNotification extends Equatable {
  const MissedNotification({
    this.id,
    required this.sessionId,
    required this.category,
    required this.appPackageName,
    this.senderName,
    this.preview,
    required this.receivedAt,
    this.digestShown = false,
  });

  final int? id;
  final int sessionId;
  final NotificationCategory category;
  final String appPackageName;
  final String? senderName;
  final String? preview;
  final DateTime receivedAt;
  final bool digestShown;

  String get displayName => senderName ?? appPackageName;

  @override
  List<Object?> get props => [id, sessionId, receivedAt];
}
