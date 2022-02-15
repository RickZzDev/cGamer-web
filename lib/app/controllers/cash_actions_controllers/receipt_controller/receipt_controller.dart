import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class ReceiptController extends GetxController {
  // File _imageFile;
  ScreenshotController screenshotController = ScreenshotController();
  final iconOnScreen = true.obs;

  Future<File?> capturePrint() async {
    Uint8List? bytes = await screenshotController.capture();
    List<int>? listInt = bytes?.toList();
    File? file;
    if (listInt != null) {
      final Directory directory = await getApplicationDocumentsDirectory();
      file =
          await File(directory.path + "/comprovante.png").writeAsBytes(listInt);
    }
    return file;
  }

  Future<ByteData?> convertToByte(File? _file) async {
    if (_file == null) {
      return null;
    }
    Uint8List bytes = _file.readAsBytesSync();
    return ByteData.view(bytes.buffer);
  }
  // await rootBundle.load(_path);

  showShareOptions(File file) async {
    await Share.shareFiles(
      [file.path],
      text: 'Comprovante',
      subject: 'comprovante.png',
    );
  }

  void captureScreenshot() async {
    removeIconShare();
    File? image = await capturePrint();
    // ByteData? bytes = await convertToByte(image);
    if (image == null) {
      return;
    }
    await showShareOptions(image);
    displayIcon();
  }

  removeIconShare() => iconOnScreen.value = false;

  displayIcon() {
    iconOnScreen.value = true;
  }
}
