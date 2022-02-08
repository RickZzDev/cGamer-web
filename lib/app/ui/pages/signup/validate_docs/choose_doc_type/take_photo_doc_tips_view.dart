import 'package:cGamer/app/controllers/signup/validate_docs/take_photo_tips_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/singup_components/docs_validate_components/photo_box.dart';
import 'package:cGamer/app/ui/components/singup_components/docs_validate_components/tips_row.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class TakePhotoTipsView extends StatefulWidget {
  @override
  _TakePhotoTipsViewState createState() => _TakePhotoTipsViewState();
}

class _TakePhotoTipsViewState extends State<TakePhotoTipsView> {
  final TakePhotoTipsController _controller =
      Get.find<TakePhotoTipsController>();

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(secondaryColor);
    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: _controller.isLoading.value,
        child: Scaffold(
          backgroundColor: Theme.of(context).accentColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: CustomAppBar(
              appBarTxt: "Validação de documentos",
            ),
          ),
          body: Container(
            height: screenHeigthSize,
            width: screenWidthhSize,
            child: SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: textStyle,
                            children: <TextSpan>[
                              TextSpan(
                                text: "Ai vai algumas ",
                              ),
                              TextSpan(
                                text: "dicas",
                                style: textStyle.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: " para sua foto ser aprovada!",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TipRow(
                          icon: Icons.circle,
                          text:
                              "Encontre um ambiente com uma boa iluminação para uma visibilidade melhor",
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TipRow(
                          icon: Icons.circle,
                          text:
                              "Tire a foto e veja se está legível antes de enviar, caso não esteja você pode tirar outra",
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TipRow(
                          icon: Icons.circle,
                          text:
                              "Retire o plástico dos documentos para tirar sua foto.",
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TipRow(
                          icon: Icons.circle,
                          text:
                              "Posicione o documento corretamente na câmera na posição vertical",
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Tire a foto da frente e verso do seu documento clicando abaixo",
                          style: textStyle.copyWith(fontSize: 15),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                () => GestureDetector(
                                  // onTap: () => showDialog(
                                  //   context: context,
                                  // builder: (context) => CameraWidget(
                                  //     mode: CameraMode.fullscreen,
                                  //     initialCamera: CameraSide.back,
                                  //     enableCameraChange: false,
                                  //     orientationEnablePhoto:
                                  //         CameraOrientation.portrait,
                                  //     onFile: (image) {
                                  //       _controller.pickImage(true, image);
                                  //       Get.back();
                                  //     },
                                  //     imageMask: FrontDocMask(),
                                  //   ),
                                  // ),

                                  onTap: () => _controller.showExampleModal(
                                      takePhotoTipsController: _controller,
                                      isFrontSide: true),
                                  child: PhotoBox(
                                      frontSide: true,
                                      docType: _controller.docType,
                                      file: _controller
                                              .pickedImageFrontSide.value ??
                                          ""),
                                  // ),
                                ),
                              ),
                              Text(
                                "e",
                                style: textStyle,
                              ),
                              Obx(
                                () => GestureDetector(
                                  onTap: () => _controller.showExampleModal(
                                      takePhotoTipsController: _controller,
                                      isFrontSide: false),
                                  child: PhotoBox(
                                    frontSide: false,
                                    docType: _controller.docType,
                                    file:
                                        _controller.pickedImageBackSide.value ??
                                            "",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              GenericButton(
                                text: "Avançar",
                                haveToReturnContext: false,
                                onPressedFunction: () =>
                                    _controller.verifyToChangePage(),
                                txtColor: Colors.white,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
