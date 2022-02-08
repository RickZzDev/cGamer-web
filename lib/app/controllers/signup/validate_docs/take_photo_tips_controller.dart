import 'dart:async';
import 'dart:io';
import 'package:cGamer/app/ui/pages/signup/validate_docs/choose_doc_type/document_camera_view.dart';
import 'package:cGamer/app/ui/pages/signup/validate_docs/choose_doc_type/photo_quality_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cGamer/app/data/models/photo_docs_model/photo_docs_model.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/generic_utils/image_utils.dart';
import 'package:cGamer/app/utils/generic_utils/security_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as style;
import 'package:get/get.dart';
import 'package:cGamer/app/ui/pages/signup/validate_docs/camera_view.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../ui/components/generic_components/buttons/generic_button.dart';

class TakePhotoTipsController extends GetxController {
  @override
  void onInit() {
    docType = Get.arguments["doc_type"];
    super.onInit();
  }

  var isLoading = false.obs;

  String docType = "";
  PhotoDocsModel docsModel = PhotoDocsModel();

  Rx<XFile?> file = Rx<XFile?>(null);
  Rx<XFile?> fileVerso = Rx<XFile?>(null);

  Rx<String?> pickedImageFrontSide = Rx<String?>(null);
  Rx<String?> pickedImageBackSide = Rx<String?>(null);

  var frontLoading = false.obs;
  var backLoading = false.obs;
  var blockClick = false.obs;

  final picker = ImagePicker();

  @override
  void onReady() {
    super.onReady();
  }

  Future pickImage(bool isFrontSide, File _image) async {
    if (isFrontSide) {
      pickedImageFrontSide.value = _image.path;
      docsModel.frontDocPhoto = await ImageUtils.resizeImage(_image);
      encodePhoto(isFrontSide, _image);
    } else {
      pickedImageBackSide.value = _image.path;
      docsModel.backDocPhoto = await ImageUtils.resizeImage(_image);
      encodePhoto(isFrontSide, _image);
    }
  }

  Future getImage(
      {required bool isFrontSide,
      required TakePhotoTipsController takePhotoTipsController}) async {
    if (blockClick.value) {
      SnackBarUtils.showSnackBar(
        desc: "Aguarde a imagem ser carregada.",
        title: "Atenção",
        icon: Icon(
          Icons.error_outline,
          color: Colors.white,
        ),
      );
    } else {
      if (docType == "CNH") {
        if (isFrontSide) {
          Get.to(DocumentCameraView(this, CameraScreenType.cnh_frente, "CNH"));
        } else {
          Get.to(DocumentCameraView(this, CameraScreenType.cnh_verso, "CNH"));
        }
      } else {
        if (isFrontSide) {
          Get.to(DocumentCameraView(this, CameraScreenType.rg_frente, "RG"));
        } else {
          Get.to(DocumentCameraView(this, CameraScreenType.rg_verso, "RG"));
        }
      }
    }
  }

  void verifyPhotoQuality(File image, bool isFrontSide) async {
    Get.back();
    Get.back();
    isLoading.value = false;
    if (image != null) {
      Get.to(() => PhotoQualityView(this), arguments: {
        "isFrontSide": isFrontSide ? 'isFrontSide' : 'isBackSide'
      });

      await pickImage(isFrontSide, image);
    } else {
      isLoading.value = false;
      SnackBarUtils.showSnackBar(
        desc: "Nenhuma imagem selecionada",
        title: "Atenção",
        icon: Icon(
          Icons.error_outline,
          color: Colors.white,
        ),
      );
    }
  }

  encodePhoto(bool isFrontSide, File _image) async {
    if (isFrontSide) {
      List<int> imageBytes = _image.readAsBytesSync();
      docsModel.photoDocFrontBase64 =
          SecurityUtils.encodeTo64(imageBytes.toString());
    } else {
      List<int> imageBytes = _image.readAsBytesSync();
      docsModel.photoDocVersoBase64 =
          SecurityUtils.encodeTo64(imageBytes.toString());
    }
  }

  verifyToChangePage() {
    if (_validateFiles()) {
      if (blockClick.value) {
        SnackBarUtils.showSnackBar(
          desc: "Aguarde a imagem ser carregada.",
          title: "Atenção",
          icon: Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
        );
      } else {
        docsModel.documentType = docType;
        Get.toNamed(Routes.VALIDATE_DOCS_SELFIE_TIPS,
            arguments: {'doc_model': docsModel});
      }
    } else {
      SnackBarUtils.showSnackBar(
        desc: "Tire as fotos do seu documento antes de prosseguir",
        title: "Atenção",
        icon: Icon(
          Icons.error_outline,
          color: Colors.white,
        ),
      );
    }
  }

  bool _validateFiles() {
    if (pickedImageFrontSide.value != null && pickedImageBackSide.value != null)
      return true;
    else
      return false;
  }

  showExampleModal(
      {required bool isFrontSide,
      required TakePhotoTipsController takePhotoTipsController}) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: Get.context!,
        builder: (context) => Container(
              height: style.screenHeigthSize * 0.42,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: style.secondaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Siga as instruções abaixo para tirar a foto",
                    textAlign: TextAlign.center,
                    style: style.textStyle.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: Image.asset(
                        isFrontSide
                            ? 'assets/images/complete_data_icons/Frente.png'
                            : 'assets/images/complete_data_icons/Verso.png',
                        fit: BoxFit.contain,
                        height: style.screenHeigthSize * 0.2,
                      )),
                  Divider(
                    color: Colors.transparent,
                  ),
                  SizedBox(
                    width: style.screenWidthhSize * 0.6,
                    child: GenericButton(
                        text: 'Abrir câmera',
                        color: style.primaryColor,
                        txtColor: Colors.white,
                        onPressedFunction: () async {
                          if (await _requestPermission()) {
                            if (isFrontSide) {
                              getImage(
                                  isFrontSide: true,
                                  takePhotoTipsController:
                                      takePhotoTipsController);
                            } else {
                              getImage(
                                  isFrontSide: false,
                                  takePhotoTipsController:
                                      takePhotoTipsController);
                            }
                          } else {
                            SnackBarUtils.showSnackBar(
                                desc:
                                    "Para continuar, é necessário oferecer a permissão para acessar a câmera!",
                                title: "Atenção");
                          }
                        }),
                  ),
                  SizedBox(
                    height: 8,
                  )
                ],
              ),
            ));
  }

  Future<bool> _requestPermission() async {
    PermissionStatus permission = await Permission.camera.request();
    if (permission.isGranted) {
      return true;
    }
    return false;
  }
}
