import 'package:cGamer/app/controllers/signup/validate_docs/selfie_controller.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../camera_view.dart';

class FaceDetectorView extends StatefulWidget {
  FaceDetectorView(this.selfieController) : assert(selfieController != null);
  final SelfieController selfieController;

  @override
  _FaceDetectorViewState createState() => _FaceDetectorViewState();
}

class _FaceDetectorViewState extends State<FaceDetectorView> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      title: 'Selfie',
      onImage: (file) {
        widget.selfieController.goToSelfieQuality(file);
      },
      screenType: CameraScreenType.selfie,
      initialDirection: CameraLensDirection.front,
    );
  }
}
