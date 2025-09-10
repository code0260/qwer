import 'package:almonazim/core/helper/functions/custom%20dialogs/my_snack_bar.dart';
import 'package:almonazim/data/model/almonazim_data_model.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchUrl {
  LaunchUrl._();

  static Future<void> launchAnyUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      mySnackBar(ToastificationType.error, "خطأ", 'لا يمكن فتح  $url');
    }
  }

  static Future<void> launchWithoutCheckUrl(String url) async {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  static Future<void> openWhatsApp(String phoneNumber, String message) async {
    String readyPhoneNumber = '';
    if (phoneNumber.startsWith('0')) {
      readyPhoneNumber = phoneNumber.substring(1);
    } else {
      readyPhoneNumber = phoneNumber;
    }

    String url =
        "https://wa.me/${AlmonazimDataModel.instance.phoneNumberCountryCode}$readyPhoneNumber/?text=${Uri.encodeFull(message)}";

    final Uri uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  static Future<void> openPhoneDialing(String phoneNumber) async {
    String readyPhoneNumber = '';
    if (phoneNumber.startsWith('0')) {
      readyPhoneNumber = phoneNumber.substring(1);
    } else {
      readyPhoneNumber = phoneNumber;
    }
    final Uri uri = Uri.parse(
        "tel:${AlmonazimDataModel.instance.phoneNumberCountryCode}$readyPhoneNumber");
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  static Future<void> openGoogleMap(String longitude, String latitude,
      {int zoomLevel = 20}) async {
    String url = "https://www.google.com/maps/@$longitude,$latitude,$zoomLevel";
    await launchAnyUrl(url);
  }
}
