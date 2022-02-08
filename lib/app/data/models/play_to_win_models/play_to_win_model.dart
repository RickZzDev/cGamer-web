enum PlayToWinGameType { LEAGUE_OF_LEGENDS, VALORANT, NONE }

class PlayToWinModel {
  List<PlayToWinGame>? games;
  PlayToWinModel.fromJson(Map<String, dynamic> json) {
    if (json['games'] != null) {
      this.games = [];
      json['games'].forEach((game) {
        this.games?.add(PlayToWinGame.fromMap(game));
      });
    }
  }
}

class PlayToWinGame {
  int? id;
  String? title;
  String? gameKey;
  PlayToWinGameType? _gameType;
  String? assetImageUrl;

  PlayToWinGame({this.id, this.gameKey, this.title});
  PlayToWinGame.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.gameKey = map['gameKey'];

    if (gameKey == "LEAGUE_OF_LEGENDS") {
      _gameType = PlayToWinGameType.LEAGUE_OF_LEGENDS;
    }

    if (gameKey == "VALORANT") {
      _gameType = PlayToWinGameType.VALORANT;
    }

    assetImageUrl = setGameImage(_gameType);
  }

  PlayToWinGameType? getGameType() {
    return this._gameType;
  }

  String? setGameImage(PlayToWinGameType? gameType) {
    if (gameType == PlayToWinGameType.LEAGUE_OF_LEGENDS) {
      return 'assets/images/play_to_win_games_images/logo-lol.png';
    }

    if (gameType == PlayToWinGameType.VALORANT) {
      return 'assets/images/play_to_win_games_images/logo-valorant-embreve.png';
    }
    return null;
  }
}

class GameInfo {
  bool? connected;
  GameDetails? details;

  GameInfo.fromJson(Map<String, dynamic> json) {
    this.connected = json['connected'];

    if (this.connected ?? false) {
      this.details = GameDetails.fromJson(json['details']);
    }
  }
}

class GameDetails {
  int? gameId;
  String? gameNick;
  String? lastUpdate;
  int? qtdGamesDaily;
  bool? rescueToday;

  GameDetails.fromJson(Map<String, dynamic> json) {
    this.gameId = json['gameId'];
    this.gameNick = json['gameNick'];
    this.lastUpdate = json['lastUpdate'];
    this.qtdGamesDaily = json['qtdGamesDaily'];
    this.rescueToday = json['rescueToday'];
  }
}
