class SearchFastMatchModel {
  MatchPlayer? player;
  MatchPlayer? playerMatch;
  List<CommonGame>? commonsGames;

  SearchFastMatchModel.fromJson(Map<String, dynamic> json) {
    player = MatchPlayer.fromMap(json['player']);
    playerMatch = MatchPlayer.fromMap(json['playerMatch']);
    if (json['commonsGames'] != null) {
      this.commonsGames = [];
      json['commonsGames'].forEach((game) {
        this.commonsGames?.add(CommonGame.fromJson(game));
      });
    }
  }
}

class MatchPlayer {
  int? customerId;
  String? nickName;
  String? userName;
  String? avatar;
  String? from;
  String? firebaseId;
  bool isPrime = false;
  bool isEmbaixador = false;

  MatchPlayer({this.customerId, this.nickName, this.userName, this.avatar});
  MatchPlayer.fromMap(Map<String, dynamic> map) {
    this.customerId = map['customerId'];
    this.nickName = map['nickName'];
    this.userName = map['userName'];
    this.avatar = map['avatar'];
    this.from = map['from'];
    this.firebaseId = map['firebaseId'];
    this.isPrime = map['isPrime'] ?? false;
    this.isEmbaixador = map['isEmbaixador'] ?? false;
    var split = nickName?.trim().split(' ');
    if (split != null && split.length >= 3) {
      nickName = split[0] + " " + split[split.length - 1];
    }
  }
}

class CommonGame {
  String? name;
  String? image;

  CommonGame();
  CommonGame.fromJson(Map<String, dynamic> json) {
    this.name = json['title'];
    this.image = json['image'];
  }
}

class NearbyPlayersModel {
  List<NearbyPlayer>? players;

  NearbyPlayersModel.fromJson(Map<String, dynamic> json) {
    if (json['players'] != null) {
      this.players = [];
      json['players'].forEach((player) {
        this.players?.add(NearbyPlayer.fromJson(player));
      });
    }
  }
}

class NearbyPlayer {
  int? customerId;
  String? nickName;
  String? distance;
  String? userName;
  String? avatar;
  bool isPrime = false;
  bool isEmbaixador = false;

  NearbyPlayer();
  NearbyPlayer.fromJson(Map<String, dynamic> json) {
    this.isPrime = json['isPrime'] ?? false;
    this.isEmbaixador = json['isEmbaixador'] ?? false;
    this.customerId = json['customerId'];
    this.nickName = json['nickName'];
    var split = nickName?.trim().split(' ');
    if (split != null && split.length >= 3) {
      nickName = split[0] + " " + split[split.length - 1];
    }
    this.distance = json['distance'];
    this.userName = json['userName'];
    this.avatar = json['avatar'];
  }
}
