import 'package:cGamer/app/data/provider/score_providers/customization_providers/customization_provider.dart';
import 'package:meta/meta.dart';

class CustomizationRepository {
  CustomizationRepository({required this.provider});
  final CustomizationProvider provider;

Future getColors() async {
  var response = await provider.getColors();
  return response;
}

}
