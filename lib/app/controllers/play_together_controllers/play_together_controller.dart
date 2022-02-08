import 'package:cGamer/app/data/models/play_together_models/play_together_model.dart';
import 'package:cGamer/app/data/repository/play_together_repositories/play_together_repository.dart';
import 'package:cGamer/app/utils/generic_utils/location_utils.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class PlayTogetherController extends GetxController {
  final PlayTogetherRepository repository;
  PlayTogetherController({required this.repository});

  RxBool beFound = RxBool(true);
  var loading = false.obs;
  var indexPlatformSelected = 0.obs;
  var hasSelectedGame = false.obs;

  PlayTogetherModel? model;
  RxList<PlayTogetherGame>? gamesPlatform = RxList();
  PlayTogetherGame? gameSelected;

  /*GEO */
  Position? position;
  LocationUtils location = new LocationUtils();
  /* */

  @override
  void onInit() async {
    initSetup();
    super.onInit();
  }

  Future<void> getInfo() async {
    loading.value = true;
    try {
      var response = await repository.getInfo();
      loading.value = false;
      if (!ExceptionUtils.verifyIfIsException(response)) {
        this.model = response;
        beFound.value = this.model?.befound ?? false;
        loading.value = false;
        await getGamesFromPlatform(0);
        return;
      }
      loading.value = false;

      SnackBarUtils.showSnackBar(
          desc: "Não foi possível carregar, tente novamente.",
          title: "Atenção");
      return;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Não foi possível carregar, tente novamente.",
          title: "Atenção");
      return;
    }
  }

  Future<void> changeBeFound(bool beFoundVal) async {
    loading.value = true;
    try {
      var response = await repository.changeBeFound(beFoundVal);
      loading.value = false;
      if (!ExceptionUtils.verifyIfIsException(response)) {
        beFound.value = beFoundVal;
        SnackBarUtils.showSnackBar(
            color: primaryColor,
            desc: beFoundVal
                ? "Agora você poderá ser encontrado por outros jogadores!"
                : "Agora você não será mais encontrado por outros jogadores!",
            title: "Sucesso!");
        loading.value = false;
        return;
      }
      loading.value = false;

      SnackBarUtils.showSnackBar(
          desc: "Não foi possível atualizar o status, tente novamente.",
          title: "Atenção");
      return;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Não foi possível atualizar o status, tente novamente.",
          title: "Atenção");
      return;
    }
  }

  Future<void> getGamesFromPlatform(int index) async {
    List<PlayTogetherGame> games = [];
    indexPlatformSelected.value = index + 1;
    Iterable<PlayTogetherPlataforms>? platforms =
        model?.platforms?.where((platform) => platform.id == index + 1);
    if (platforms != null && platforms.length > 0) {
      games.addAll(platforms.first.games ?? []);
    }

    gamesPlatform?.value = games;
  }

  void initSetup() async {
    await getInfo();
    DartNotificationCenter.subscribe(
        channel: "refreshPlayTogether",
        observer: this,
        onNotification: (value) => getInfo());

    this.position = await location.getCurrentPosition();

    if (this.position != null) {
      await putLocation(this.position!.latitude, this.position!.longitude);
    }
  }

  Future<void>? putLocation(double latitude, double longitude) async {
    try {
      //latitude = latitude.substring(0, latitude.length - 10);
      //longitude = longitude.substring(0, longitude.length - 10);
      var response = await repository.putLocation(latitude, longitude);
      //loading.value = false;

      if (!ExceptionUtils.verifyIfIsException(response)) {
        return;
      }

      SnackBarUtils.showSnackBar(
          desc: "Um erro inesperado aconteceu, tente novamente.",
          title: "Atenção");
      return;
    } catch (e) {
      //loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Um erro inesperado aconteceu, tente novamente.",
          title: "Atenção");
      return;
    }
  }
}
