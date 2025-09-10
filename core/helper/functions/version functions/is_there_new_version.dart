import 'package:almonazim/core/constant/app_release_data.dart';
import 'package:almonazim/core/extension/string_extensions.dart';

bool isThereNewVersion(String latestVersion) {
  var currentVersion = AppReleaseData.version.replaceAll('.', '').toDouble();
  var lsVersion = latestVersion.replaceAll('.', '').toDouble();
  if (lsVersion > currentVersion) {
    return true;
  } else {
    return false;
  }
}
