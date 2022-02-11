class AddGameModel {
  List<AddGame>? games;
  AddGameModel();
  AddGameModel.fromJson(Map<String, dynamic> json) {
    if (json['games'] != null) {
      this.games = [];
      json['games'].forEach((platform) {
        this.games?.add(AddGame.fromMap(platform));
      });
    }
  }
}

class AddGame {
  int? id;
  String? title;
  String? image;
  String? nameUserDescription;
  List<AddGamePlatform>? platforms;

  AddGame(
      {this.id,
      this.image,
      this.title,
      this.nameUserDescription,
      this.platforms});
  AddGame.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.image = map['image'];
    this.nameUserDescription = map['nameUserDescription'];
    if (map['platforms'] != null) {
      this.platforms = [];
      map['platforms'].forEach((game) {
        this.platforms?.add(AddGamePlatform.fromJson(game));
      });
    }
  }

}

class AddGamePlatform {
  int? id;
  String? title;
  bool isSelected = false;

  AddGamePlatform();
  AddGamePlatform.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.title = json['title'];
  }
}
