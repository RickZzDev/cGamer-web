import 'dart:convert';

import 'package:cGamer/app/controllers/play_together_controllers/add_game_confirmation_controller/add_game_confirmation_controller.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/play_together_endpoints/play_together_endpoint.dart';

class AddNewGameProvider {
  final Requester requester;
  AddNewGameProvider(this.requester);

  Future<dynamic> getAllGames(String id) async {
    var response = await requester.fetch(
        url: AddNewGameEndpoints.getAllGames(id),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> postNewGame(AddGamePostModel postModel) async {
    var response = await requester.post(
        url: AddNewGameEndpoints.postNewGame,
        header: await Headers().getAuthenticatedHeader(),
        body: postModel.toJson());
    return response;
  }
}
