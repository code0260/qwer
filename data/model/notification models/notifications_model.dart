import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final int? notificationsId;
  final int? notificationsUsersId;
  final String? notificationsTitle;
  final String? notificationsMessage;
  final String? notificationsCreatedAt;
  final int? notificationsIsRead;
  final dynamic notificationsRelatedEntityType;
  final dynamic notificationsRelatedEntityId;
  final String? notificationsPriority;

  const NotificationModel({
    this.notificationsId,
    this.notificationsUsersId,
    this.notificationsTitle,
    this.notificationsMessage,
    this.notificationsCreatedAt,
    this.notificationsIsRead,
    this.notificationsRelatedEntityType,
    this.notificationsRelatedEntityId,
    this.notificationsPriority,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        notificationsId: json['notifications_id'] as int?,
        notificationsUsersId: json['notifications_users_id'] as int?,
        notificationsTitle: json['notifications_title'] as String?,
        notificationsMessage: json['notifications_message'] as String?,
        notificationsCreatedAt: json['notifications_created_at'] as String?,
        notificationsIsRead: json['notifications_is_read'] as int?,
        notificationsRelatedEntityType:
            json['notifications_related_entity_type'] as dynamic,
        notificationsRelatedEntityId:
            json['notifications_related_entity_id'] as dynamic,
        notificationsPriority: json['notifications_priority'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'notifications_id': notificationsId,
        'notifications_users_id': notificationsUsersId,
        'notifications_title': notificationsTitle,
        'notifications_message': notificationsMessage,
        'notifications_created_at': notificationsCreatedAt,
        'notifications_is_read': notificationsIsRead,
        'notifications_related_entity_type': notificationsRelatedEntityType,
        'notifications_related_entity_id': notificationsRelatedEntityId,
        'notifications_priority': notificationsPriority,
      };

  NotificationModel copyWith({
    int? notificationsId,
    int? notificationsUsersId,
    String? notificationsTitle,
    String? notificationsMessage,
    String? notificationsCreatedAt,
    int? notificationsIsRead,
    dynamic notificationsRelatedEntityType,
    dynamic notificationsRelatedEntityId,
    String? notificationsPriority,
  }) {
    return NotificationModel(
      notificationsId: notificationsId ?? this.notificationsId,
      notificationsUsersId: notificationsUsersId ?? this.notificationsUsersId,
      notificationsTitle: notificationsTitle ?? this.notificationsTitle,
      notificationsMessage: notificationsMessage ?? this.notificationsMessage,
      notificationsCreatedAt:
          notificationsCreatedAt ?? this.notificationsCreatedAt,
      notificationsIsRead: notificationsIsRead ?? this.notificationsIsRead,
      notificationsRelatedEntityType:
          notificationsRelatedEntityType ?? this.notificationsRelatedEntityType,
      notificationsRelatedEntityId:
          notificationsRelatedEntityId ?? this.notificationsRelatedEntityId,
      notificationsPriority:
          notificationsPriority ?? this.notificationsPriority,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      notificationsId,
      notificationsUsersId,
      notificationsTitle,
      notificationsMessage,
      notificationsCreatedAt,
      notificationsIsRead,
      notificationsRelatedEntityType,
      notificationsRelatedEntityId,
      notificationsPriority,
    ];
  }
}
