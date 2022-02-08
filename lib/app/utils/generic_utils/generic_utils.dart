import 'package:cGamer/app/data/models/models_export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/cache_utils/cache_utils.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class GenericUtils {
  static closeKeyoard(_context) =>
      FocusScope.of(_context).requestFocus(FocusNode());

  static void goPrivacyPolices(String url) async {
    if (await canLaunch(url))
      await launch(url);
    else
      // can't launch url, there is some error
      throw "Could not launch $url";
  }

  static void goTermsUse(String url) async {
    if (await canLaunch(url))
      await launch(url);
    else
      // can't launch url, there is some error
      throw "Could not launch $url";
  }

  static void openUrl(String url) async {
    if (await canLaunch(url))
      await launch(url);
    else
      // can't launch url, there is some error
      throw "Could not launch $url";
  }

  static String getMessageShare(ProfileModel? model) {
    String text = "";
    if (model?.customerAccount != null) {
      BankAccount? bankAccount = model?.customerAccount;
      text = "Meus dados para transferência no Jogga Bank\n" +
          "Banco: ${bankAccount?.bankNumber} - ${bankAccount?.bank} \n" +
          "Agência: ${bankAccount?.agency} \n" +
          "Conta: ${bankAccount?.account} \n" +
          "Tipo: Conta de Pagamentos \n" +
          "CPF: ${model?.customerCPF} \n" +
          "Nome completo: ${model?.customerName}";
    }
    return text;
  }

  static String getIndicationShare(String indicationCode) {
    String text = "";
    if (indicationCode != null) {
      text =
          "Olá Gamer! Estou enviando um código de indicação para que você se cadastre no Jogga Bank pelo celular e avance para o próximo nível comigo!\n" +
              "Baixe o app no link: \n" +
              "https://joggabank.com.br/app \n" +
              "E informe o código de indicação $indicationCode ao se cadastrar.";
    }
    return text;
  }

  static String getInitialsName(String? nickName) {
    if (nickName == null) {
      return "";
    } else {
      nickName = nickName.trim();
      List<String> split = nickName.split(' ');

      if (split.length > 1) {
        String firstName = split[0];
        String secondName =
            split[1].length <= 2 && split.length >= 3 ? split[2] : split[1];

        String firstLetter = firstName.substring(0, 1);
        String secondLetter = secondName.substring(0, 1);

        return "$firstLetter$secondLetter".toUpperCase();
      } else if (split.length == 1) {
        String firstName = split[0];

        String firstLetter = firstName.substring(0, 1);
        String secondLetter = firstName.substring(firstName.length - 1);

        return "$firstLetter$secondLetter".toUpperCase();
      } else {
        return "";
      }
    }
  }

  static String getFirstSecondName(String? nickName) {
    if (nickName == null) {
      return "";
    } else {
      List<String> split = nickName.split(' ');

      if (split.length > 1) {
        String firstName = split[0];
        String secondName = split[1].length <= 2 && split.length >= 3
            ? split[1] + " " + split[2]
            : split[1];

        return "$firstName $secondName";
      } else if (split.length == 1) {
        String firstName = split[0];

        return "$firstName";
      } else {
        return "";
      }
    }
  }

  static Color getColorWithHex(String hex) {
    String color = "0xFF" + hex;
    return Color(int.parse(color));
  }

  static void logoutUser() async {
    CacheUtils.removeCache(key: 'x-token');
    OneSignal.shared.logoutEmail();
    await FirebaseAuth.instance.signOut();
    //OneSignal.shared.removeExternalUserId();
    Get.offAllNamed(Routes.LOGIN);
  }
}
