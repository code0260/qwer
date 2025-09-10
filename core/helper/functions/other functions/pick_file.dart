import 'dart:io';

import 'package:almonazim/core/helper/functions/other%20functions/request_permissions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

Future<File?> pickFile(
    {List<String>? allowedExtensions, FileType? fileType}) async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: fileType ?? FileType.custom,
        allowedExtensions: allowedExtensions);
    if (result != null) {
      return File(result.files.single.path!);
    } else {
      return null;
    }
  } catch (e) {
    if (e is PlatformException &&
        e.message?.contains('User did not allow read') == true) {
      requestPermissions();
      return null;
    } else {
      return null;
    }
  }
}
