import 'package:cGamer/app/utils/api_utils/endpoints/score_endpoints/customization_endpoints/customization_endpoints.dart';
import 'package:meta/meta.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';

import '../../../../utils/api_utils/api_exports.dart';

class CustomizationProvider {
  CustomizationProvider({required this.requester});
  final Requester requester;

  Future getColors() async {
    try {
      var response = await requester.fetch(
          url: CustomizationEndpoints.colors(),
          header: await Headers().getAuthenticatedHeader());
      return response;
    } catch (e) {
      return throw Exception(e);
    }
  }
}
