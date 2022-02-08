class PlayTogetherModel {
  bool befound = true;
  List<PlayTogetherPlataforms>? platforms;
  PlayTogetherModel.fromJson(Map<String, dynamic> json) {
    befound = json['beFound'] ?? true;
    if (json['platforms'] != null) {
      this.platforms = [];
      json['platforms'].forEach((platform) {
        this.platforms?.add(PlayTogetherPlataforms.fromMap(platform));
      });
    }
  }
}

class PlayTogetherPlataforms {
  int? id;
  String? title;
  List<PlayTogetherGame>? games;

  PlayTogetherPlataforms({this.id, this.games, this.title});
  PlayTogetherPlataforms.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    if (map['games'] != null) {
      this.games = [];
      map['games'].forEach((game) {
        this.games?.add(PlayTogetherGame.fromJson(game));
      });
    }
  }
}

class PlayTogetherGame {
  int? id;
  String? title;
  String? image;
  String? nickName;

  PlayTogetherGame();
  PlayTogetherGame.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.title = json['title'];
    this.image = json['image'];
    this.nickName = json['nickName'];
  }
}
