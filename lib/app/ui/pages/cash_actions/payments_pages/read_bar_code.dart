import 'package:cGamer/app/controllers/cash_actions_controllers/payments_controllers/bar_code_controleller.dart';
import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:qr_mobile_vision/qr_camera.dart';

class ReadBarCodePage extends StatefulWidget {
  @override
  _ReadBarCodePageState createState() => _ReadBarCodePageState();
}

class _ReadBarCodePageState extends State<ReadBarCodePage> {
  final ReadBarCodeController _controller = Get.find<ReadBarCodeController>();
  String barcode = "";

  List<CameraDescription>? cameras;
  CameraController? controller;
  XFile? imageFile;
  String qr = "";

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  openCamera() async {
    cameras = await availableCameras();
    if ((cameras?.length ?? 0) == 0) return;

    controller = CameraController(cameras![0], ResolutionPreset.max);
    controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    return Scaffold(
      backgroundColor: utils.secondaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              SizedBox(
                width: 24,
              ),
              Center(
                child: Text(
                  "Posicione e escaneie o código de barras do boleto",
                  textAlign: TextAlign.center,
                  style: utils.textStyle,
                ),
              ),
              GestureDetector(
                  onTap: () {
                    SystemChrome.setPreferredOrientations([
                      DeviceOrientation.portraitUp,
                    ]);

                    Get.offAllNamed(Routes.MAIN_PAGES_HOLDER);
                  },
                  child: Icon(Icons.close, color: Colors.white, size: 32)),
            ]),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: Obx(
                () => ModalProgressHUD(
                  inAsyncCall: _controller.loading.value,
                  child: QrCamera(
                    onError: (context, error) => Text(
                      error.toString(),
                      style: TextStyle(color: Colors.red),
                    ),
                    fit: BoxFit.cover,
                    qrCodeCallback: (code) {
                      _controller.validateField(code);
                    },
                  ),
                ),
              ),
            ),
            //8362000000270160138000475470244110
            //83620000002701601380004754702441108092553448
            Container(
              width: utils.screenHeigthSize * 0.8,
              child: GenericButton(
                text: "Digite o número do boleto",
                onPressedFunction: () {
                  Get.toNamed(Routes.PAYMENT_WRITE_BAR_CODE);
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                  ]);
                },
                txtColor: Colors.white,
              ),
            )
            // Text(barcode),
          ],
        ),
      ),
    );
  }
}
