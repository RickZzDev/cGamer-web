import 'dart:io';
import 'package:cGamer/app/ui/pages/signup/validate_docs/selfie_step/selfie_quality_view.dart';
import 'package:cGamer/app/ui/pages/signup/validate_docs/selfie_step/selfie_view_v2.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as style;
import 'package:cGamer/app/data/models/photo_docs_model/photo_docs_model.dart';
import 'package:cGamer/app/data/repository/sign_up_repositories/selfie_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/image_utils.dart';
import 'package:cGamer/app/utils/generic_utils/security_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../ui/components/components.dart';
import '../../../utils/generic_utils/snackbar.dart';

class SelfieController extends GetxController {
  final SelfieRepository repository;

  SelfieController({required this.repository});

  Rx<File?> file = Rx<File?>(null);
  final loading = false.obs;

  setLoading() => loading.value = !loading.value;
  PhotoDocsModel docsModel = PhotoDocsModel();

  var photoIsLoading = false.obs;
  var blockClick = false.obs;
  final picker = ImagePicker();
  @override
  void onInit() {
    docsModel = Get.arguments['doc_model'];
    super.onInit();
  }

  void sendDocs() async {
    loading.value = true;
    blockClick.value = true;

    try {
      var response = await repository.sendDocuments(docsModel);
      if (ExceptionUtils.verifyIfIsException(response)) {
        blockClick.value == true ? blockClick.value = false : DoNothingAction();
        throw response;
      } else {
        await create();
        blockClick.value == true ? blockClick.value = false : DoNothingAction();
      }
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(title: "Atenção", desc: e.toString());
      blockClick.value == true ? blockClick.value = false : DoNothingAction();
    }
  }

  pickimage(File _image) async {
    file.value = _image;
    docsModel.selfiePhoto = await ImageUtils.resizeImage(file.value!);
    docsModel.photoSelfieBase64 = _photoEnconded(_image);
  }

  getImage() {
    // final pickedImage = await picker.getImage(
    //     source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
    Get.to(FaceDetectorView(this));
  }

  void goToSelfieQuality(File file) async {
    //loading.value = true;
    Get.back();
    Get.back();
    if (file != null) {
      Get.to(() => SelfieQualityView(this));
      await pickimage(file);

      List<File> _fileList = [
        docsModel.backDocPhoto!,
        docsModel.frontDocPhoto!,
        docsModel.selfiePhoto!
      ];

      await verifyPhotoSizeException(_fileList);
      loading.value = false;
    } else {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: 'Nenhuma imagem selecionada.', title: 'Atenção');
    }
  }

  verifyPhotoSizeException(List<File> fileList) async {
    for (int index = 0; index < fileList.length; index++) {
      if (fileList[index].lengthSync() > 1000000) {
        var compressedImage =
            await ImageUtils.compressImage(fileList[index], 80);

        if (index == 0) {
          docsModel.backDocPhoto = compressedImage;
        }

        if (index == 1) {
          docsModel.frontDocPhoto = compressedImage;
        }

        if (index == 2) {
          docsModel.selfiePhoto = compressedImage;

          file.refresh();
        }
      }
    }
  }

  String _photoEnconded(File _image) {
    List<int> imageBytes = _image.readAsBytesSync();
    return SecurityUtils.encodeTo64(imageBytes.toString());
  }

  verifyIfIsException(dynamic responseHttp) {
    loading.value = false;
    if (ExceptionUtils.verifyIfIsException(responseHttp)) {
      SnackBarUtils.showSnackBar(
          title: "Atenção", desc: responseHttp.message.toString());
      blockClick.value == true ? blockClick.value = false : DoNothingAction();
      return false;
    } else {
      Get.offAllNamed(Routes.VALIDATE_DOCS_SENDED, arguments: {});
    }
  }

  create() async {
    var response = await repository.create();
    verifyIfIsException(response);
  }

  verifyToChangePage() {
    _validateFiles()
        ? sendDocs()
        : SnackBarUtils.showSnackBar(
            desc: "Tire uma foto sua antes de prosseguir",
            title: "Atenção",
            icon: Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
          );
  }

  bool _validateFiles() {
    if (file.value != null)
      return true;
    else
      return false;
  }

  showExampleModal(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
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
                        'assets/images/complete_data_icons/Selfie.png',
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
                        onPressedFunction: () {
                          getImage();
                          //Get.back();
                        }),
                  ),
                  SizedBox(
                    height: 8,
                  )
                ],
              ),
            ));
  }
}
