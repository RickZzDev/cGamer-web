import 'package:cGamer/app/data/models/score_models/buy_badges/my_badges_model.dart';
import 'package:cGamer/app/data/provider/profile_provider/profile_provider.dart';
import 'dart:convert';
import 'package:meta/meta.dart';

class ProfileRepository {
  final ProfileApiClient apiClient;

  ProfileRepository({required this.apiClient});

  getProfile() async {
    return await apiClient.getProfile();
  }

  Future getBadges() async {
    try {
      var response = await apiClient.getBedges();

      var model =
          MyBadgesModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      return model;
    } catch (e) {
      return throw e;
    }
  }
}
