import 'package:almonazim/core/constant/app_enums.dart'; // Assuming this path for app_enums.dart

/// Translates a [NotificationPriority] enum value to its English string representation.
/// Returns `null` if the state is not recognized or is `null`.
String? translateToEnNotificationPriorityEnum(NotificationPriority? priority) {
  switch (priority) {
    case NotificationPriority.critical:
      return "critical";
    case NotificationPriority.high:
      return "high";
    case NotificationPriority.medium:
      return "medium";
    case NotificationPriority.low:
      return "low";
    default:
      return null;
  }
}

NotificationPriority? translateEnNotificationPriorityToEnum(String? priority) {
  switch (priority) {
    case 'critical':
      return NotificationPriority.critical;
    case "high":
      return NotificationPriority.high;
    case "medium":
      return NotificationPriority.medium;
    case "low":
      return NotificationPriority.low;
    default:
      return null;
  }
}

/// Translates a [NotificationPriority] enum value to its Arabic string representation.
/// Returns `null` if the state is not recognized or is `null`.
String? translateToArNotificationPriorityEnum(NotificationPriority? priority) {
  switch (priority) {
    case NotificationPriority.critical:
      return "هام جداً";
    case NotificationPriority.high:
      return "مرتفع";
    case NotificationPriority.medium:
      return "متوسط";
    case NotificationPriority.low:
      return "منخفض";
    default:
      return null;
  }
}

/// Translates an Arabic string representation of notification priority to its English equivalent.
/// Returns `null` if the string is not recognized or is `null`.
String? translateToEnNotificationPriority(String? priorityString) {
  switch (priorityString) {
    case "هام جداً":
      return "critical";
    case "مرتفع":
      return "high";
    case "متوسط":
      return "medium";
    case "منخفض":
      return "low";
    default:
      return null;
  }
}

/// Translates an English string representation of notification priority to its Arabic equivalent.
/// Returns `null` if the string is not recognized or is `null`.
String? translateToArNotificationPriority(String? priorityString) {
  switch (priorityString) {
    case "critical":
      return "هام جداً";
    case "high":
      return "مرتفع";
    case "medium":
      return "متوسط";
    case "low":
      return "منخفض";
    default:
      return null;
  }
}
