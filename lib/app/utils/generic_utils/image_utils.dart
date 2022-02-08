import 'dart:io';

import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_native_resizer/image_native_resizer.dart';

abstract class ImageUtils {
  static Future<File> resizeImage(File _image) async {
    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(_image.path);
    File compressedFile = await FlutterNativeImage.compressImage(_image.path,
        quality: 100,
        targetWidth: 768,
        targetHeight: ((properties.height ?? 1 )  *  768 / (properties.width?? 1)).round());
    ImageProperties properties1 =
        await FlutterNativeImage.getImageProperties(compressedFile.path);
    final resizedPath = await ImageNativeResizer.resize(
        imagePath: compressedFile.path,
        maxHeight: double.parse('${properties1.height}'),
        maxWidth: 768,
        quality: 100);

    return File(resizedPath);
  }

  static Future<File> compressImage(File _image, int _percentOfQuality) async {
    final resizedPath = await ImageNativeResizer.resize(
        imagePath: _image.path, quality: _percentOfQuality);
    return File(resizedPath);
  }
}
