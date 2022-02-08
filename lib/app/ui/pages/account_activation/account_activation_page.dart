import 'package:cGamer/app/controllers/bank/bank_controller.dart';
import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/data/data_exports.dart';
import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountActivationPage extends StatelessWidget {
  final BankController controller;

  AccountActivationPage({required this.controller});

  @override
  Widget build(BuildContext context) {
    final registerModel = controller.statusRegisterResult.value;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          appBarTxt: 'Ative sua conta',
        ),
      ),
      backgroundColor: secondaryColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 24),
        child: Column(
          children: [
            CustomRichText(
              normalText: 'Para ativar',
              customText: 'sua conta, complete seus dados',
              normalText2: 'e envie',
              customText2: 'seus documentos',
              normalText3: 'assim você poderá utilizar todos os nossos',
              customText3: 'serviços financeiros.',
            ),
            SizedBox(
              height: 24,
            ),
            ItemBoxComponent(
              onTap: verifyUserData(registerModel) == 'UNSENT_DATA'
                  ? () => Get.toNamed(Routes.SINGUP_MOTHER_NAME_STEP)
                  : verifyUserData(registerModel) == 'DATA_RECUSED'
                      ? () => Get.toNamed(Routes.ACCOUNT_DATA_LIST)
                      : () {}, //Get.toNamed(Routes.ACCOUNT_DATA_LIST)
              title: 'Complete seus dados',
              situation: verifyUserData(registerModel) == 'UNSENT_DATA'
                  ? 'Para enviar seus documentos'
                  : verifyUserDocuments(registerModel) == 'UNSENT_PHOTOS'
                      ? 'Agora envie seus documentos'
                      : verifyUserData(registerModel) == 'DATA_RECUSED' ||
                              verifyUserData(registerModel) == 'PHOTO_RECUSED'
                          ? 'Não aprovado'
                          : 'Em análise',
              situationColor: verifyUserData(registerModel) == 'DATA_RECUSED'
                  ? Color(0xffFF9595)
                  : Color(0xffECFCAC),
              imagePath: 'assets/images/account_activation_icons/person.svg',
              hasReason: verifyUserData(registerModel) == 'DATA_RECUSED'
                  ? true
                  : false,
              reason: getMessageReason(registerModel),
              gCoinsQuantity: registerModel.hasCompleteRegistration ? 0 : 25,
            ),
            SizedBox(
              height: 24,
            ),
            ItemBoxComponent(
              onTap: registerModel.hasCompleteRegistration == false
                  ? () {
                      SnackBarUtils.showSnackBar(
                          desc:
                              'Complete seus dados antes de enviar seus documentos.',
                          title: 'Atenção');
                    }
                  : verifyUserDocuments(registerModel) == 'PHOTO_RECUSED' ||
                          verifyUserDocuments(registerModel) ==
                              'UNSENT_PHOTOS' ||
                          verifyUserData(registerModel) == 'DATA_RECUSED'
                      ? () => Get.toNamed(Routes.VALIDATE_DOCS_CHOSSE_TYPE)
                      : () {},
              title: 'Envie seus documentos',
              desactived: registerModel.hasCompleteRegistration == false,
              situation: verifyUserData(registerModel) == 'UNSENT_DATA'
                  ? 'Aguardando completar os dados'
                  : verifyUserData(registerModel) == 'DATA_RECUSED'
                      ? 'Não aprovado'
                      : verifyUserDocuments(registerModel) == 'UNSENT_PHOTOS'
                          ? 'Aguardando envio'
                          : verifyUserDocuments(registerModel) ==
                                  'PHOTO_RECUSED'
                              ? 'Não aprovado'
                              : 'Em análise',
              situationColor:
                  verifyUserDocuments(registerModel) == 'PHOTO_RECUSED' ||
                          verifyUserData(registerModel) == 'DATA_RECUSED'
                      ? Color(0xffFF9595)
                      : Color(0xffECFCAC),
              imagePath: 'assets/images/account_activation_icons/documents.svg',
              hasReason:
                  verifyUserDocuments(registerModel) == 'PHOTO_RECUSED' ||
                          verifyUserData(registerModel) == 'DATA_RECUSED'
                      ? true
                      : false,
              reason: getMessageReason(registerModel),
              gCoinsQuantity: registerModel.hasSendDocumentation ? 0 : 50,
              iconSize: 48,
            )
          ],
        ),
      ),
    );
  }

  String verifyUserData(StatusRegisterModel registerModel) {
    if (registerModel.reason != null &&
        (registerModel.reason == 'DATA_RECUSED' ||
            registerModel.reason == 'DOCUMENT_RECUSED' ||
            registerModel.reason == 'OCR_RECUSED' ||
            registerModel.reason == 'AGE_RECUSED' ||
            registerModel.reason == 'NAME_RECUSED' ||
            registerModel.reason == 'EMAIL_RECUSED' ||
            registerModel.reason == 'FORBIDDEN_WORD' ||
            registerModel.reason == 'STATUS_RECUSED' ||
            registerModel.reason == 'RISKY_BEHAVIOR' ||
            registerModel.reason == 'NOT_FOUND' ||
            registerModel.reason == 'NOT_RETRY')) {
      return 'DATA_RECUSED';
    }
    if (registerModel.reason != null &&
        (registerModel.reason == 'PHOTO_RECUSED' ||
            registerModel.reason == 'SELFIE_RECUSED')) {
      return 'PHOTO_RECUSED';
    }
    if (registerModel.hasCompleteRegistration == false ||
        registerModel.hasCompleteRegistration == null) {
      return 'UNSENT_DATA';
    } else {
      return 'DATA_SENT';
    }
  }

  String verifyUserDocuments(StatusRegisterModel registerModel) {
    if (registerModel.reason != null &&
        (registerModel.reason == 'PHOTO_RECUSED' ||
            registerModel.reason == 'SELFIE_RECUSED')) {
      return 'PHOTO_RECUSED';
    }

    if (registerModel.reason != null &&
        (registerModel.reason == 'DATA_RECUSED' ||
            registerModel.reason == 'DOCUMENT_RECUSED' ||
            registerModel.reason == 'OCR_RECUSED' ||
            registerModel.reason == 'AGE_RECUSED' ||
            registerModel.reason == 'NAME_RECUSED' ||
            registerModel.reason == 'EMAIL_RECUSED' ||
            registerModel.reason == 'FORBIDDEN_WORD' ||
            registerModel.reason == 'STATUS_RECUSED' ||
            registerModel.reason == 'RISKY_BEHAVIOR' ||
            registerModel.reason == 'NOT_FOUND' ||
            registerModel.reason == 'NOT_RETRY')) {
      return 'DATA_RECUSED';
    }

    if (registerModel.hasSendDocumentation == false ||
        registerModel.hasSendDocumentation == null) {
      return 'UNSENT_PHOTOS';
    } else {
      return 'PHOTOS_SENT';
    }
  }

  String getMessageReason(StatusRegisterModel registerModel) {
    if (registerModel.reason != null) {
      switch (registerModel.reason) {
        case 'DATA_RECUSED':
          return 'Verifique se seus dados estão corretos e reenvie seus documentos';
          break;
        case 'DOCUMENT_RECUSED':
          return 'Não conseguimos validar sua selfie com a foto do documento, tente novamente.';
          break;
        case 'OCR_RECUSED':
          return 'Falha na leitura e comparação dos dados do seu documento com o informado no cadastro.';
          break;
        case 'AGE_RECUSED':
          return 'Divergência encontrada em sua data de nascimento informada.';
          break;
        case 'NAME_RECUSED':
          return 'Seu nome ou nome de sua mãe precisam estar idênticos ao documento.';
          break;
        case 'EMAIL_RECUSED':
          return 'Desculpe, no momento não iremos conseguir seguir com o cadastro.';
          break;
        case 'FORBIDDEN_WORD':
          return 'Palavras não apropriadas em seus dados, atualize-os e tente novamente.';
          break;
        case 'STATUS_RECUSED':
          return 'Desculpe, no momento não iremos conseguir seguir com o cadastro.';
          break;
        case 'RISKY_BEHAVIOR':
          return 'Desculpe, no momento não iremos conseguir seguir com o cadastro.';
          break;
        case 'NOT_FOUND':
          return 'Não encontramos algumas informações, entre em contato com nosso suporte.';
          break;
        case 'NOT_RETRY':
          return 'Desculpe, no momento não iremos conseguir seguir com o cadastro.';
          break;
        case 'SELFIE_RECUSED':
          return 'A sua selfie não está de acordo com nossas instruções, reenvie.';
          break;
        case 'PHOTO_RECUSED':
          return 'A sua selfie não está de acordo com nossas instruções, reenvie.';
          break;
        default:
          return 'Por favor entre em contato com nosso atendimento.';
          break;
      }
    }

    return "Por favor entre em contato com nosso atendimento.";
  }
}
