import 'dart:io';

import 'package:cGamer/app/controllers/signup/validate_docs/take_photo_tips_controller.dart';
import 'package:cGamer/app/ui/pages/signup/validate_docs/camera_view.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DocumentCameraView extends StatefulWidget {
  DocumentCameraView(this.takePhotoTipsController, this.screenType, this.title)
      : assert(takePhotoTipsController != null);

  final TakePhotoTipsController takePhotoTipsController;
  final CameraScreenType screenType;
  final String title;

  @override
  _DocumentCameraViewState createState() => _DocumentCameraViewState();
}

class _DocumentCameraViewState extends State<DocumentCameraView> {
  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      title: widget.title,
      onImage: (file) {
        widget.takePhotoTipsController.verifyPhotoQuality(
            file,
            widget.screenType == CameraScreenType.cnh_frente ||
                widget.screenType == CameraScreenType.rg_frente);
      },
      screenType: widget.screenType,
      initialDirection: CameraLensDirection.back,
    );
  }
}
