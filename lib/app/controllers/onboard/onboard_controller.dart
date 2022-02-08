import 'package:cGamer/app/data/models/onboard_model.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnBoardController extends GetxController {
  RxBool _isTextVisible = true.obs;

  List<OnBoardModel> onboardList = [
    OnBoardModel(
        "01.png",
        "Bem vindo ao Jogga!",
        "Faça parte de nossa comunidade e aproveite todos os benefícios para o Gamer.",
        "png"),
    OnBoardModel(
        "02.png",
        "Conta digital com gamificação",
        "Suba para o próximo nível, complete missões para ganhar Rubis e conquistar benefícios exclusivos!",
        "png"),
    OnBoardModel(
        "03.png",
        "Upgrade no seu shopping",
        "Eu ouvi desconto? \nSIMMM, isso mesmo! Na nossa Gamer Store você irá encontrar produtos incríveis com descontos exclusivos.",
        "png"),
    OnBoardModel(
        "04.png",
        "Crédito de jogos",
        "Usando o seu saldo da conta e nossa moeda é possível comprar jogos e créditos para o seu jogo favorito em um único lugar.",
        "png")
  ];

  get isTextVisible => this._isTextVisible.value;

  RxString _buttonText = 'Próximo'.obs;

  get buttonText => this._buttonText.value;

  void verifyIndex(value) {
    if (value > 0) {
      removeText();
    } else {
      enableText();
    }
    verifyText(value);
  }

  void removeText() {
    _isTextVisible.value = false;
  }

  void enableText() {
    _isTextVisible.value = true;
  }

  void verifyText(_value) {
    _value != (onboardList.length - 1)
        ? _buttonText.value = "Próximo"
        : _buttonText.value = "Start";
  }

  void setCacheValue(GetStorage _box) {
    _box.write('splash_route', Routes.LOGIN);
  }
}
