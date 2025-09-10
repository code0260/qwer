import 'dart:io';

import 'package:almonazim/core/helper/image_generator.dart';
import 'package:almonazim/data/model/user%20models/store_user_model.dart';
import 'package:pdf/widgets.dart';

Future<Image?> getBusinessLogoImage() async {
  Image? logo;
  if (StoreUserModel.instance.businessImage != null) {
    File file = await ImageGenerator.getImageFile(
        name: StoreUserModel.instance.businessImage!);
    final img = file.readAsBytesSync();
    logo = Image(MemoryImage(img));
  }
  return logo;
}
