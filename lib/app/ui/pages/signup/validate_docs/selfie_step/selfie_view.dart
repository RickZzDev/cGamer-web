import 'dart:io';

import 'package:cGamer/app/controllers/signup/validate_docs/selfie_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/singup_components/docs_validate_components/tips_row.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SelfieView extends StatelessWidget {
  final SelfieController _controller = Get.find<SelfieController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
          inAsyncCall: _controller.loading.value,
          child: Scaffold(
            backgroundColor: Theme.of(context).accentColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: CustomAppBar(
                appBarTxt: "Validação de documentos",
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: textStyle,
                          children: <TextSpan>[
                            TextSpan(
                              text: "E para ",
                            ),
                            TextSpan(
                              text: "finalizar,",
                              style: textStyle.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: " vamos para ",
                            ),
                            TextSpan(
                              text: "selfie? ",
                              style: textStyle.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Aqui vai algumas dicas para a sua foto ser aprovada!",
                        style: textStyle.copyWith(
                          color: Colors.white54,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TipRow(
                        text:
                            "Encontre um ambiente com uma boa iluminação para uma melhor visibilidade.",
                        icon: Icons.maximize,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TipRow(
                        text:
                            "Esteja sozinho na foto, de prefêrencia sem objetos ou pessoas no fundo.",
                        icon: Icons.maximize,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TipRow(
                        text:
                            "Não utilize, bonés, óculos ou qualquer outro acessório que não seja possível lhe identificar.",
                        icon: Icons.maximize,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TipRow(
                        text:
                            "Posicionar a câmera na altura dos olhos para tirar a foto e sem o documento nas mãos.",
                        icon: Icons.maximize,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: textStyle.copyWith(
                                color: primaryColor, fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(
                                text: "Preparado para a ",
                              ),
                              TextSpan(
                                text: "selfie?",
                                style: textStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () => _controller.showExampleModal(context),
                          child: Obx(
                            () => Container(
                              width: screenHeigthSize * 0.20,
                              height: screenHeigthSize * 0.20,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: primaryColor,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: _controller.photoIsLoading.value
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: primaryColor,
                                      ),
                                    )
                                  : _controller.file.value == null
                                      ? Icon(
                                          Icons.camera_alt_outlined,
                                          size: 50,
                                          color: primaryColor,
                                        )
                                      : ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          child: Image.file(
                                            File(_controller.file.value?.path ??
                                                ""),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                              text: "Enviar documentos",
                              haveToReturnContext: false,
                              onPressedFunction: () => _controller
                                      .blockClick.value
                                  ? SnackBarUtils.showSnackBar(
                                      desc: "Aguarde a imagem ser carregada.",
                                      title: "Atenção",
                                      icon: Icon(
                                        Icons.error_outline,
                                        color: Colors.white,
                                      ),
                                    )
                                  : _controller.verifyToChangePage(),
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
        ));
  }
}
