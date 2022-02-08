import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:geolocator/geolocator.dart';

class LocationUtils {
  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      SnackBarUtils.showSnackBar(
          desc: "Ative a localização do seu celular e tente novamente.",
          title: "Atenção");
      return Future.error('Location disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        SnackBarUtils.showSnackBar(
            desc:
                "Você precisa ativar sua localização, para poder utilizar essa funcionalidade.",
            title: "Atenção");

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      SnackBarUtils.showSnackBar(
          desc: "Você desativou a permissão de localização permanentemente.",
          title: "Atenção");
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
