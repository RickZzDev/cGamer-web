import 'package:cGamer/app/data/models/play_together_models/search_player_model.dart';

class MatchInvitesModel {
  MatchInvitesModel();
  List<MatchInvite>? invites;
  MatchInvitesModel.fromJson(Map<String, dynamic> json) {
    if (json['invites'] != null) {
      this.invites = [];
      json['invites'].forEach((invite) {
        this.invites?.add(MatchInvite.fromMap(invite));
      });
    }
  }
}

class MatchInvite {
  MatchPlayer? player;
  List<CommonGame>? commonsGames;
  int? platformId;
  int? gameId;
  String? gameName;

  MatchInvite({this.player, this.commonsGames});
  MatchInvite.fromMap(Map<String, dynamic> map) {
    if (map['player'] != null) {
      player = MatchPlayer.fromMap(map['player']);
    }
    if (map['platformId'] != null) {
      platformId = map['platformId'];
    }
    if (map['gameId'] != null) {
      gameId = map['gameId'];
    }
    if (map['gameName'] != null) {
      gameName = map['gameName'];
    }
    if (map['commonGames'] != null) {
      this.commonsGames = [];
      map['commonGames'].forEach((game) {
        this.commonsGames?.add(CommonGame.fromJson(game));
      });
    }
  }
}

class FriendInvitesModel {
  FriendInvitesModel();
  List<FriendInvite>? invites;
  FriendInvitesModel.fromJson(List<dynamic> json) {
    this.invites = [];
    json.forEach((invite) {
      this.invites?.add(FriendInvite.fromMap(invite));
    });
  }
}

class GamersListModel {
  GamersListModel();
  List<FriendInvite>? users;
  GamersListModel.fromJson(List<dynamic> json) {
    this.users = [];
    json.forEach((invite) {
      this.users?.add(FriendInvite.fromMap(invite));
    });
  }
}

class FriendInvite {
  String? nickName;
  int? customerId;
  String? userName;
  String? firebaseId;
  String? avatar;
  bool isPrime = false;
  bool isEmbaixador = false;
  List<CommonGame>? commonsGames;

  FriendInvite({this.nickName, this.userName, this.avatar, this.commonsGames});
  FriendInvite.fromMap(Map<String, dynamic> map) {
    isPrime = map['isPrime'];
    isEmbaixador = map['isEmbaixador'] ?? false;
    nickName = map["nickName"];
    customerId = map["customerId"];
    firebaseId = map["firebaseId"];
    userName = map["userName"];
    var split = nickName?.trim().split(' ');
    if (split != null && split.length >= 3) {
      nickName = split[0] + " " + split[split.length - 1];
    }

    avatar = map["avatar"];
    if (map['games'] != null) {
      this.commonsGames = [];
      map['games'].forEach((game) {
        this.commonsGames?.add(CommonGame.fromJson(game));
      });
    }
  }
}
