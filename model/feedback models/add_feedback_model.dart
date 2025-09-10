import 'package:almonazim/core/constant/app_release_data.dart';
import 'package:almonazim/core/device/device_utility.dart';

class AddFeedbackModel {
  String? feedbackText;
  String? feedbackScreenshotName;
  int? feedbackUsersId;
  String? feedbackDeviceInfo;
  String? feedbackAppVersion;
  String? feedbackPlatform;

  String? imagePath;
  AddFeedbackModel({
    this.feedbackText,
    this.feedbackScreenshotName,
    this.feedbackUsersId,
    this.feedbackDeviceInfo,
    this.feedbackAppVersion,
    this.feedbackPlatform,
  });

  Future<Map<String, dynamic>> toMap() async {
    // Resolve device info and platform if null
    String resolvedDeviceInfo =
        feedbackDeviceInfo ?? await AppDevice.getDeviceInfo();
    String resolvedPlatform =
        feedbackPlatform ?? (AppDevice.getCurrentPlatform());
    String resolvedAppVersion = feedbackAppVersion ?? AppReleaseData.version;

    return {
      "feedback_text": feedbackText,
      "feedback_users_id": feedbackUsersId,
      "feedback_screenshot_name": feedbackScreenshotName,
      "feedback_device_info": resolvedDeviceInfo,
      "feedback_app_version": resolvedAppVersion,
      "feedback_platform": resolvedPlatform,
    };
  }
}
