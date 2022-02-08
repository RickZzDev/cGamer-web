import 'dart:async';
import 'dart:io';

import 'package:cGamer/app/ui/components/generic_components/buttons/generic_button.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/state_manager.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;

enum CameraScreenType { selfie, cnh_frente, cnh_verso, rg_frente, rg_verso }

List<CameraDescription> cameras = [];

class CameraView extends StatefulWidget {
  CameraView(
      {Key? key,
      this.title = "",
      this.onImage,
      this.screenType,
      this.initialDirection = CameraLensDirection.back})
      : super(key: key);

  final String title;
  final Function(File file)? onImage;
  final CameraLensDirection initialDirection;
  final CameraScreenType? screenType;

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController? _controller; // CameraController(null,ResolutionPreset.low);

  int _cameraIndex = 0;
  var instructions = "".obs;
  final isFloatButtonVisible = false.obs;
  bool isBusy = false;
  FaceDetector? faceDetector;
  TextDetector? textDetector;
  int quarter = 0;
  int cameraQuarter = 0;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _startLiveFeed();
    _startServices();
  }

  void setupFaceDetector() {
    instructions.value = "Posicione o rosto no centro da tela";
    faceDetector = GoogleMlKit.vision.faceDetector(FaceDetectorOptions(
        enableContours: true,
        enableClassification: true,
        enableLandmarks: true,
        enableTracking: false,
        mode: FaceDetectorMode.accurate,
        minFaceSize: 0.1));
  }

  void setupCNH(bool isFront) {
    instructions.value = isFront
        ? "Posicione a CNH (frente) na área marcada"
        : "Posicione a CNH (verso) na área marcada";
    textDetector = GoogleMlKit.vision.textDetector();
  }

  void setupRG(bool isFront) {
    instructions.value = isFront
        ? "Posicione o RG (frente) na área marcada"
        : "Posicione o RG (verso) na área marcada";
    textDetector = GoogleMlKit.vision.textDetector();
  }

  void _startServices() async {
    switch (widget.screenType) {
      case CameraScreenType.selfie:
        setupFaceDetector();
        break;
      case CameraScreenType.cnh_frente:
        setupCNH(true);
        break;
      case CameraScreenType.cnh_verso:
        setupCNH(false);
        break;
      case CameraScreenType.rg_frente:
        setupRG(true);
        break;
      case CameraScreenType.rg_verso:
        setupRG(false);
        break;
      default:
    }
  }

  void _stopServices(CameraScreenType screenType) {
    switch (screenType) {
      case CameraScreenType.selfie:
        stopFaceDetector();
        break;
      default:
        stopTextDetector();
        break;
    }
  }

  void stopFaceDetector() {
    faceDetector?.close();
  }

  void stopTextDetector() {
    textDetector?.close();
  }

  @override
  void dispose() {
    _stopLiveFeed();
    _stopServices(widget.screenType ?? CameraScreenType.selfie);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.screenType == CameraScreenType.selfie) {
      FlutterStatusbarcolor.setStatusBarColor(secondaryColor);
      return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text(
            widget.title,
            style: textStyle.copyWith(),
          ),
          backgroundColor: secondaryColor,
        ),
        body: _body(),
        floatingActionButton: widget.screenType == CameraScreenType.selfie
            ? _selfieFloatingActionButton()
            : null,
        floatingActionButtonLocation:
            widget.screenType == CameraScreenType.selfie
                ? FloatingActionButtonLocation.centerFloat
                : null,
      );
    } else {
      FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
      return Scaffold(
        body: _body(),
      );
    }
  }

  Widget _selfieFloatingActionButton() {
    return Container(
      height: 70,
      width: 70,
      child: FloatingActionButton(
          onPressed: () async {
            _controller?.setFlashMode(FlashMode.off);

            ///await _controller.stopImageStream();
            await Future.delayed(Duration(milliseconds: 200));
            if (Platform.isAndroid) {
              XFile xFile = await _controller!.takePicture();
              File file = File(xFile.path);

              List<int> imageBytes = await file.readAsBytes();
              final originalImage = img.decodeImage(imageBytes);
              img.Image fixedImage;
              fixedImage = img.copyRotate(originalImage!, 90);
              final fixedFile =
                  await file.writeAsBytes(img.encodeJpg(fixedImage));
              widget.onImage!(fixedFile);
            } else {
              XFile file = await _controller!.takePicture();
              widget.onImage!(File(file.path));
            }
          },
          child: Icon(
            Icons.camera_alt,
            size: 40,
          )),
    );
  }

  Widget _floatingActionButton() {
    // if (!isFloatButtonVisible.value) return Container();
    return Container(
        height: 70.0,
        width: 70.0,
        child: FloatingActionButton(
          child: Icon(
            Icons.camera_alt,
            size: 40,
          ),
          onPressed: () async {
            _controller?.setFlashMode(FlashMode.off);
            //await _controller.stopImageStream();
            await Future.delayed(Duration(milliseconds: 200));
            XFile xFile = await _controller!.takePicture();
            File file = File(xFile.path);

            List<int> imageBytes = await file.readAsBytes();
            final originalImage = img.decodeImage(imageBytes);
            img.Image fixedImage;
            fixedImage = img.copyRotate(originalImage!, 270);
            final fixedFile =
                await file.writeAsBytes(img.encodeJpg(fixedImage));
            widget.onImage!(fixedFile);
            SystemChrome.setPreferredOrientations(
                [DeviceOrientation.portraitUp]);
            //_stopLiveFeed();
          },
        ));
  }

  Widget? _body() {
    Widget? body;
    if (widget.screenType == CameraScreenType.selfie) body = _selfieBody();
    if (widget.screenType == CameraScreenType.cnh_frente)
      body = _cnhFrontBody();
    if (widget.screenType == CameraScreenType.cnh_verso) body = _cnhBackBody();
    if (widget.screenType == CameraScreenType.rg_frente) body = _rgFrontBody();
    if (widget.screenType == CameraScreenType.rg_verso) body = _rgBackBody();
    return body;
  }

  Widget _selfieBody() {
    if (_controller == null ||
        _controller?.value == null ||
        _controller?.value.isInitialized == false) {
      return Container();
    }
    return Container(
      color: Colors.black,
      height: Get.height,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Platform.isAndroid
              ? RotatedBox(quarterTurns: 3, child: CameraPreview(_controller!))
              : CameraPreview(_controller!),
          Center(
            child: Container(
                padding: EdgeInsets.all(32),
                margin: EdgeInsets.only(bottom: 48),
                height: screenHeigthSize,
                width: screenWidthhSize,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/complete_data_icons/Asset_Rosto_01.svg',
                        fit: BoxFit.fill,
                        width: screenWidthhSize / 1.2,
                      ),
                    ])),
          ),
          Container(
              margin: EdgeInsets.only(top: screenHeigthSize / 9),
              child: Text(
                instructions.value,
                textAlign: TextAlign.center,
                style: textStyle.copyWith(fontSize: 20),
              )),
        ],
      ),
    );
  }

  Widget _cnhFrontBody() {
    if (_controller == null ||
        _controller?.value == null ||
        _controller?.value.isInitialized == false) {
      return Container();
    }
    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          RotatedBox(
              quarterTurns: cameraQuarter, child: CameraPreview(_controller!)),
          Container(
              margin: EdgeInsets.only(top: 16),
              child: Text(
                instructions.value,
                textAlign: TextAlign.center,
                style: textStyle.copyWith(
                    fontSize: 16, fontWeight: FontWeight.bold),
              )),
          Center(
            child: RotatedBox(
                quarterTurns: quarter,
                child: Container(
                    height: screenWidthhSize / 1.1,
                    width: screenHeigthSize / 1.1,
                    child: SvgPicture.asset(
                      'assets/images/complete_data_icons/Asset_CNH_frente.svg',
                      color: primaryColor,
                      fit: BoxFit.contain,
                    ))),
          ),
          Stack(
            children: [
              Container(
                  margin: EdgeInsets.only(right: 40),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: _floatingActionButton())),
              Container(
                  margin: EdgeInsets.only(left: 60, top: 20),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(Icons.close, size: 36, color: Colors.white),
                        onPressed: () {
                          Get.back();
                          Get.back();
                        },
                      ))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cnhBackBody() {
    if (_controller == null ||
        _controller?.value == null ||
        _controller?.value.isInitialized == false) {
      return Container();
    }
    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          RotatedBox(
              quarterTurns: cameraQuarter, child: CameraPreview(_controller!)),
          Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                instructions.value,
                textAlign: TextAlign.center,
                style: textStyle.copyWith(fontSize: 16),
              )),
          Center(
            child: RotatedBox(
                quarterTurns: quarter,
                child: Container(
                    height: screenWidthhSize / 1.1,
                    width: screenHeigthSize / 1.1,
                    child: SvgPicture.asset(
                      'assets/images/complete_data_icons/Asset_CNH_verso.svg',
                      color: primaryColor,
                      fit: BoxFit.contain,
                    ))),
          ),
          Stack(
            children: [
              Container(
                  margin: EdgeInsets.only(right: 40),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: _floatingActionButton())),
              Container(
                  margin: EdgeInsets.only(left: 60, top: 20),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(Icons.close, size: 36, color: Colors.white),
                        onPressed: () {
                          Get.back();
                          Get.back();
                        },
                      ))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _rgFrontBody() {
    if (_controller == null ||
        _controller?.value == null ||
        _controller?.value.isInitialized == false) {
      return Container();
    }
    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          RotatedBox(
              quarterTurns: cameraQuarter, child: CameraPreview(_controller!)),
          Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                instructions.value,
                textAlign: TextAlign.center,
                style: textStyle.copyWith(fontSize: 16),
              )),
          Center(
            child: RotatedBox(
              quarterTurns: quarter,
              child: Container(
                  height: screenWidthhSize / 1.1,
                  width: screenHeigthSize / 1.1,
                  child: SvgPicture.asset(
                    'assets/images/complete_data_icons/Asset_RG_Frente.svg',
                    color: primaryColor,
                    fit: BoxFit.contain,
                  )),
            ),
          ),
          Stack(
            children: [
              Container(
                  margin: EdgeInsets.only(right: 40),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: _floatingActionButton())),
              Container(
                  margin: EdgeInsets.only(left: 60, top: 20),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(Icons.close, size: 36, color: Colors.white),
                        onPressed: () {
                          Get.back();
                          Get.back();
                        },
                      ))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _rgBackBody() {
    if (_controller == null ||
        _controller?.value == null ||
        _controller?.value.isInitialized == false) {
      return Container();
    }
    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          RotatedBox(
              quarterTurns: cameraQuarter, child: CameraPreview(_controller!)),
          Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                instructions.value,
                textAlign: TextAlign.center,
                style: textStyle.copyWith(fontSize: 16),
              )),
          Center(
            child: RotatedBox(
              quarterTurns: quarter,
              child: Container(
                  height: screenWidthhSize / 1.1,
                  width: screenHeigthSize / 1.1,
                  child: SvgPicture.asset(
                    'assets/images/complete_data_icons/Asset_RG_Verso_1.svg',
                    color: primaryColor,
                    fit: BoxFit.contain,
                  )),
            ),
          ),
          Stack(
            children: [
              Container(
                  margin: EdgeInsets.only(right: 40),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: _floatingActionButton())),
              Container(
                  margin: EdgeInsets.only(left: 60, top: 20),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(Icons.close, size: 36, color: Colors.white),
                        onPressed: () {
                          Get.back();
                          Get.back();
                        },
                      ))),
            ],
          ),
        ],
      ),
    );
  }

  Future _initCameras() async {
    try {
      cameras = await availableCameras();
    } on CameraException catch (e) {
      SnackBarUtils.showSnackBar(
          desc: "Ocorreu um erro ao abrir a câmera: ${e.description}",
          title: "Atenção");
    }
  }

  Future _startLiveFeed() async {
    await _initCameras();
    List<int> cameraIndexes = [];
    for (var i = 0; i < cameras.length; i++) {
      if (cameras[i].lensDirection == widget.initialDirection) {
        cameraIndexes.add(i);
      }
    }

    // _cameraIndex =
    //     cameraIndexes.length > 1 ? cameraIndexes[1] : cameraIndexes[0];
    _cameraIndex = cameraIndexes[0];
    final camera = cameras[_cameraIndex];

    ResolutionPreset resolution = ResolutionPreset.high;

    _controller = CameraController(camera, resolution, enableAudio: false);

    if (widget.screenType != CameraScreenType.selfie) {
      if (Platform.isAndroid) {
        quarter = 4;
        cameraQuarter = 2;
      } else {
        quarter = 0;
        cameraQuarter = 0;
      }
    }

    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }

      DeviceOrientation deviceOrientation =
          widget.screenType != CameraScreenType.selfie
              ? Platform.isAndroid
                  ? DeviceOrientation.landscapeLeft
                  : DeviceOrientation.landscapeRight
              : Platform.isAndroid
                  ? DeviceOrientation.landscapeLeft
                  : DeviceOrientation.portraitUp;

      _controller?.lockCaptureOrientation(deviceOrientation);
      // if (widget.screenType == CameraScreenType.selfie) {
      //   _controller?.startImageStream(_processCameraImage);
      // }

      setState(() {});
    });
  }

  Future _stopLiveFeed() async {
    // await _controller?.stopImageStream();

    await _controller?.dispose();
    _controller = null;
  }

  Future _processCameraImage(CameraImage image) async {
    if (isBusy) return;
    isBusy = true;

    Future.delayed(Duration(milliseconds: 800), () {
      final WriteBuffer allBytes = WriteBuffer();

      for (Plane plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      final Size imageSize = Size(
          Platform.isAndroid
              ? image.planes[0].bytesPerRow.toDouble()
              : image.width.toDouble(),
          image.height.toDouble());

      final camera = cameras[_cameraIndex];

      final imageRotation = Platform.isAndroid &&
              widget.screenType != CameraScreenType.selfie
          ? InputImageRotation.Rotation_0deg
          : InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
              InputImageRotation.Rotation_0deg;

      final inputImageFormat =
          InputImageFormatMethods.fromRawValue(image.format.raw) ??
              InputImageFormat.NV21;

      final planeData = image.planes.map(
        (Plane plane) {
          return InputImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          );
        },
      ).toList();

      final inputImageData = InputImageData(
        size: imageSize,
        imageRotation: imageRotation,
        inputImageFormat: inputImageFormat,
        planeData: planeData,
      );

      final inputImage =
          InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

      switch (widget.screenType) {
        case CameraScreenType.selfie:
          //processFaceDetectorImage(inputImage);
          break;
        default:
          // processTextDetector(inputImage);
          break;
      }
      isBusy = false;
    });
  }

  // Future<void> processFaceDetectorImage(InputImage inputImage) async {
  //   setState(() {});

  //   final faces = await faceDetector.processImage(inputImage);

  //   if (faces.length > 0) {
  //     if (faces[0] != null &&
  //         faces[0].headEulerAngleY != null &&
  //         faces[0].headEulerAngleY <= 5.0 &&
  //         faces[0].headEulerAngleY >= -5.0 &&
  //         faces[0].headEulerAngleZ <= 5.0 &&
  //         faces[0].headEulerAngleZ >= -5.0 &&
  //         faces[0].boundingBox.left >= 30 &&
  //         faces[0].boundingBox.left <= 150 &&
  //         faces[0].boundingBox.top >= ((screenHeigthSize / 3) - 150) &&
  //         faces[0].boundingBox.top <= ((screenHeigthSize / 3) + 150)) {
  //       instructions.value = 'Agora de um sorriso para finalizar';
  //       if (faces[0] != null &&
  //           faces[0].smilingProbability != null &&
  //           faces[0].smilingProbability > 0.85) {
  //         instructions.value = 'Obrigado :)';
  //         _controller.setFlashMode(FlashMode.off);
  //         await _controller.stopImageStream();
  //         await Future.delayed(Duration(milliseconds: 200));
  //         if (Platform.isAndroid) {
  //           XFile xFile = await _controller.takePicture();
  //           File file = File(xFile.path);

  //           List<int> imageBytes = await file.readAsBytes();
  //           final originalImage = img.decodeImage(imageBytes);
  //           img.Image fixedImage;
  //           fixedImage = img.copyRotate(originalImage, 90);
  //           final fixedFile =
  //               await file.writeAsBytes(img.encodeJpg(fixedImage));
  //           widget.onImage(fixedFile);
  //         } else {
  //           XFile file = await _controller.takePicture();
  //           widget.onImage(File(file.path));
  //         }
  //         _stopLiveFeed();
  //       }
  //     } else {
  //       instructions.value = 'Posicione o rosto no centro da tela';
  //     }
  //   } else {
  //     instructions.value = 'Posicione o rosto no centro da tela';
  //   }
  // }

  Future<void> processTextDetector(InputImage inputImage) async {
    setState(() {});
    final recognisedText = await textDetector?.processImage(inputImage);

    print('text: ${recognisedText?.text}');
    String text = recognisedText?.text ?? "";

    switch (widget.screenType) {
      case CameraScreenType.cnh_frente:
        if (text.contains('CARTEIRA NACIONAL DE HABILITAÇÃO') ||
            text.contains('HABILITAÇÃO') ||
            text.contains('HABILITACAO') ||
            text.contains('TRÂNSITO') ||
            text.contains('TRANSITO') ||
            text.contains('HABIL') ||
            text.contains('1HABILITAÇĂO')) {
          instructions.value =
              'Perfeito, encaixe o documento na área e tire a foto :)';
          isFloatButtonVisible.value = true;
        } else {
          isFloatButtonVisible.value = false;
          instructions.value =
              'Tentando identificar a CNH (frente) na área marcada...';
        }
        break;
      case CameraScreenType.cnh_verso:
        if (text.contains('DETRAN') ||
            text.contains('PORTADOR') ||
            text.contains('LOCAL') ||
            text.contains('EMISSÃO') ||
            text.contains('EMISSAO')) {
          instructions.value =
              'Perfeito, encaixe o documento na área e tire a foto :)';
          isFloatButtonVisible.value = true;
        } else {
          isFloatButtonVisible.value = false;
          instructions.value =
              'Tentando identificar a CNH (verso) na área marcada...';
        }
        break;
      case CameraScreenType.rg_frente:
        if (text.contains('CARTEIRA DE IDENTIDADE') ||
            text.contains('REPUBLICA FEDERATIVA DO BRASIL') ||
            text.contains('CARTEIRA') ||
            text.contains('IDENTIDADE') ||
            text.contains('REPUBLICA') ||
            text.contains('FEDERATIVA') ||
            text.contains('BRASIL')) {
          instructions.value =
              'Perfeito, encaixe o documento na área e tire a foto :)';
          isFloatButtonVisible.value = true;
        } else {
          isFloatButtonVisible.value = false;
          instructions.value =
              'Tentando identificar o RG (frente) na área marcada...';
        }
        break;
      case CameraScreenType.rg_verso:
        if (text.contains('VÁLIDA') ||
            text.contains('TERRITÓRIO NACIONAL') ||
            text.contains('NACIONAL') ||
            text.contains('TERRITÓRIO') ||
            text.contains('ASSINATURA DO DIRETOR') ||
            text.contains('AGOSTO') ||
            text.contains('LEI NO 7.116')) {
          instructions.value =
              'Perfeito, encaixe o documento na área e tire a foto :)';
          isFloatButtonVisible.value = true;
        } else {
          isFloatButtonVisible.value = false;
          instructions.value =
              'Tentando identificar o RG (verso) na área marcada...';
        }
        break;

      default:
    }
  }
}
