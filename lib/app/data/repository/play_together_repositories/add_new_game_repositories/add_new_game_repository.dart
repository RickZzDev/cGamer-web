import 'dart:convert';

import 'package:cGamer/app/controllers/play_together_controllers/add_game_confirmation_controller/add_game_confirmation_controller.dart';
import 'package:cGamer/app/data/models/play_together_models/add_game_model.dart';
import 'package:cGamer/app/data/provider/play_together_providers/add_new_game_providers/add_new_game_provider.dart';

class AddNewGameRepository {
  final AddNewGameProvider api;

  AddNewGameRepository(this.api);

  Future<dynamic> getAllGames(String id) async {
    var response = await api.getAllGames(id);

    return AddGameModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

  Future<dynamic> postNewGame(AddGamePostModel postModel) async {
    var response = await api.postNewGame(postModel);
    return response;
  }
}
