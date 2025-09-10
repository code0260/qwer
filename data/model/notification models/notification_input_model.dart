class NotificationInputModel {
  int? requestNumber;
  int? notificationsId;
  int? notificationsUsersId;
  String? notificationsTitle;
  String? notificationsMessage;
  String? notificationsCreatedAt;
  int? notificationsIsRead;
  dynamic notificationsRelatedEntityType;
  dynamic notificationsRelatedEntityId;
  String? notificationsPriority;
  DateTime? startDate; // Added property
  DateTime? endDate; // Added property

  NotificationInputModel({
    this.requestNumber,
    this.notificationsId,
    this.notificationsUsersId,
    this.notificationsTitle,
    this.notificationsMessage,
    this.notificationsCreatedAt,
    this.notificationsIsRead,
    this.notificationsRelatedEntityType,
    this.notificationsRelatedEntityId,
    this.notificationsPriority,
    this.startDate, // Added property
    this.endDate, // Added property
  });

  Map<String, dynamic> toMap() => {
        'request_number': requestNumber,
        'notifications_id': notificationsId,
        'notifications_users_id': notificationsUsersId,
        'notifications_title': notificationsTitle,
        'notifications_message': notificationsMessage,
        'notifications_created_at': notificationsCreatedAt,
        'notifications_is_read': notificationsIsRead,
        'notifications_related_entity_type': notificationsRelatedEntityType,
        'notifications_related_entity_id': notificationsRelatedEntityId,
        'notifications_priority': notificationsPriority,
        'start_date': startDate?.toUtc().toString(), // Added property
        'end_date': endDate?.toUtc().toString(), // Added property
      };
}
