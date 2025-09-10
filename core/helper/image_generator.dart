import 'package:get/get.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ImageGenerator {
  /// Save the image file to the device
  static Future<File> saveImage({
    required Uint8List imageBytes,
    required String name,
  }) async {
    final root = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    final file = File('${root!.path}/$name');
    await file.writeAsBytes(imageBytes);
    debugPrint('Image saved at: ${file.path}');
    return file;
  }

  static Future<File> saveTempImage({
    required Uint8List imageBytes,
    required String name,
  }) async {
    final root = await getTemporaryDirectory();
    final file = File('${root.path}/$name');
    await file.writeAsBytes(imageBytes);
    debugPrint('Image saved at: ${file.path}');
    return file;
  }

  static Future<File> getImageFile({
    required String name,
  }) async {
    final root = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    final file = File('${root!.path}/$name');
    return file;
  }

  /// Open the image file using the system default viewer
  static Future<void> openImage(File file) async {
    final path = file.path;
    await OpenFile.open(path);
  }

  /// Share the image file
  static Future<void> shareImageFile(File imageFile) async {
    // get the context
    final context = Get.context!;
    final box = context.findRenderObject() as RenderBox?;

    XFile xfile = XFile(imageFile.path);
    await SharePlus.instance.share(ShareParams(
      files: [xfile],
      text: 'مشاركة صورة',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    ));
  }

  // download image
  static Future<File?> downloadAndSaveImage(
      String imageUrl, String fileName) async {
    File imageFile = await getImageFile(name: fileName);
    final result = await getIt
        .get<ApiService>()
        .download(url: imageUrl, targetPath: imageFile.path);
    return result.fold(
      (failure) => null,
      (response) {
        return imageFile;
      },
    );
  }
}
