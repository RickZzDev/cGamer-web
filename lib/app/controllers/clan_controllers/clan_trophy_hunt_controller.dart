import 'package:cGamer/app/data/models/clans_models/clan_trophy_hunt_model.dart';
import 'package:cGamer/app/data/repository/clan_repositories/clan_details_repositories/clan_trophy_hunt_repository.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:get/get.dart';

class ClanTrophyHuntController extends GetxController {
  final ClanTrophyHuntRepository repository;

  ClanTrophyHuntController(this.repository) : assert(repository != null);

  late TrophyHuntModel model;

  var btnDuplicateIsEnabled = true.obs;
  var bagIsEquiped = false.obs;
  var modelHasLoaded = false.obs;
  var postBagHasLoaded = true.obs;

  bool get isLoading => !modelHasLoaded.value || !postBagHasLoaded.value;

  @override
  void onInit() async {
    modelHasLoaded.value = await getModel();

    super.onInit();
  }

  Future<bool> getModel() async {
    try {
      var response = await repository.getModel();

      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(desc: response.message, title: "Atenção");
        return false;
      }

      this.model = response;
      bagIsEquiped.value = this.model.hunterTrophy.bag;
      btnDuplicateIsEnabled.value = !this.model.hunterTrophy.hunting;
      return true;
    } catch (e) {
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, atualize a página.",
          title: "Atenção");
      return false;
    }
  }

  postBag() async {
    postBagHasLoaded.value = false;

    TrophyHuntModelRequest request = TrophyHuntModelRequest();
    request.bag = bagIsEquiped.value;

    try {
      var response = await repository.postBag(request);

      if (ExceptionUtils.verifyIfIsException(response)) {
        postBagHasLoaded.value = true;
        SnackBarUtils.showSnackBar(desc: response.message, title: "Atenção");
        return;
      }

      SnackBarUtils.showSnackBar(
          desc:
              'Você esta na caçada, no final da rodada será notificado em seu retorno!',
          title: 'Parabéns!',
          color: primaryColor);
      await getModel();
      postBagHasLoaded.value = true;
    } catch (e) {
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, atualize a página.",
          title: "Atenção");
      postBagHasLoaded.value = true;
    }
  }

  void equipBag() {
    if (bagIsEquiped.value) {
      return;
    }
    btnDuplicateIsEnabled.value = false;
    bagIsEquiped.value = true;
  }

  int getTimestamp() {
    DateTime now = DateTime.now();

    DateTime nextDay = DateTime(now.year, now.month, now.day, now.hour, 59, 59);
    return nextDay.millisecondsSinceEpoch;
  }
}
