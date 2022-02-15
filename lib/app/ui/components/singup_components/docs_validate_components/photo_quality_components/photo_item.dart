import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../controllers/signup/validate_docs/take_photo_tips_controller.dart';

class PhotoQualityItem extends StatelessWidget {
  PhotoQualityItem(
      {this.isFrontSide = false, required this.takePhotoTipsController});
  final TakePhotoTipsController takePhotoTipsController;
  final bool isFrontSide;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor)),
      child: isFrontSide
          ? Image.file(
              File(takePhotoTipsController.pickedImageFrontSide.value ?? ""),
              fit: BoxFit.cover,
            )
          : Image.file(
              File(takePhotoTipsController.pickedImageBackSide.value ?? ""),
              fit: BoxFit.cover),
    );
  }
}
