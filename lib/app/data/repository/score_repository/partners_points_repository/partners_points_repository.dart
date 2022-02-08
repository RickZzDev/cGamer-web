import 'package:cGamer/app/data/models/score_models/partners_points_model/partners_points_model.dart';
import 'package:cGamer/app/data/provider/score_providers/partners_points_providers/partners_points_provider.dart';
import 'dart:convert';
import 'package:meta/meta.dart';

class PartnersPointsRepository {
  final PartnerPointsApiClient apiClient;

  PartnersPointsRepository({required this.apiClient});

  Future getPartners() async {
    try {
      var response = await apiClient.getPartners();

      var model = PartnerPointsModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
      return model;
    } catch (e) {
      return throw e;
    }
  }
}
