import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Validations {
  dynamic validateCpf(String _txt) {
    if (_txt.isEmpty) {
      return "Digite corretamente o número do seu CPF";
    }
    if (!GetUtils.isCpf(_txt)) {
      return "Digite corretamente o número do seu CPF";
    }
    return null;
  }

  dynamic validateCpfOrCpnj(String _txt) {
    if (_txt.isEmpty) {
      return "Digite corretamente o número do seu CPF ou CNPJ";
    }

    if (!GetUtils.isCpf(_txt)) {
      if (GetUtils.isCnpj(_txt)) {
        return null;
      }
      return "CPF ou CNPJ incorreto";
    }
    return null;
  }

  dynamic validateAge(int _minAge, String _date) {
    var day = _date.split('/')[0];
    var month = _date.split("/")[1];
    var year = _date.split("/")[2];
    var dateInputed = DateTime.parse("$year-$month-$day");
    var minDate = DateTime.now().subtract(Duration(days: 365 * _minAge + 3));
    if (int.parse(day) > 31) {
      return "Dia inválido, por favor digite novamente.";
    }
    if (int.parse(month) > 12 || int.parse(month) == 0) {
      return "Mês inválido, por favor digite novamente.";
    }

    if (dateInputed.compareTo(minDate) > 0) {
      return "Que pena, é necessário ter mais de 16 anos :(";
    } else {
      return null;
    }
  }

  dynamic validateEmail(String _txt) {
    if (_txt.isEmpty) {
      // isEmailValid.value = false;
      return "Favor preencher campo de email";
    }
    if (!GetUtils.isEmail(_txt)) {
      // isEmailValid.value = false;
      return "Digite um endereço de e-mail válido.";
    }
    // isEmailValid.value = true;
    return null;
  }

  dynamic isNotEmpty(String _txt) {
    if (_txt.isEmpty) {
      return "Por favor preencha o campo.";
    }
    return null;
  }

  dynamic passwordBigger(String _txt) {
    if (_txt.isEmpty) {
      return "Por favor preencha o campo.";
    }
    if (_txt.length < 8) {
      return "Sua senha deve ter no mínino 8 caracteres";
    }
    return null;
  }

  dynamic validateName(
      {required String txt, bool selfName = false, bool momName = false}) {
    if (txt.isEmpty) {
      return "Preencha com o nome completo";
    }
    if (txt.split(" ").length <= 2) {
      if (txt.split(" ").length == 2) {
        if (txt.split(" ")[0].length < 3) {
          return momName
              ? "O primeiro nome está curto de mais"
              : selfName
                  ? "Seu primeiro nome está curto de mais"
                  : "Este primeiro nome esta curto de mais";
        } else if (txt.split(" ")[1].length < 3) {
          return momName
              ? "Por favor, digite o nome completo da sua mãe:)\nExemplo: Maria da Silva"
              : selfName
                  ? "Por favor, digite seu nome completo :)\nExemplo: João da Silva"
                  : "Por favor, digite o nome completo :)\nExemplo: João da Silva";
        }
      }
      if (txt.split(" ").length == 1) {
        return momName
            ? "Por favor, digite o nome completo da sua mãe:)\nExemplo: Maria da Silva"
            : selfName
                ? "Por favor, digite seu nome completo :)\nExemplo: João da Silva"
                : "Por favor, digite o nome completo :)\nExemplo: João da Silva";
      }
    }
  }

  dynamic validateBalance({required String txt, bool selfBalance = true}) {
    if (txt.isEmpty) {
      return "Saldo igual a zero";
    }
  }
}
