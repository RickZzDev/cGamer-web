import 'package:cGamer/app/data/models/home_models/home_model.dart';
import 'package:cGamer/app/data/models/play_together_models/search_player_model.dart';

class ProfileModel {
  int? customerId;
  String? customerNick;
  String? customerEmail;
  String? customerName;
  String? customerCPF;
  String? customerAvatar;
  String? customerPhone;
  String? userName;
  String? customerBirthDate;
  String? indicationCode;
  String? customerMotherName;
  Level? level;
  BankAccount? customerAccount;
  Badge? badge;
  String? nickColor;

  ProfileModel(
      {this.customerNick,
      this.level,
      this.customerAccount,
      this.customerAvatar,
      this.customerMotherName,
      this.customerEmail});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    nickColor = json['customerNickColor'];
    customerAvatar = json['customerAvatar'];
    customerNick = json['customerNick'];
    customerEmail = json['customerEmail'];
    customerPhone = json['customerPhone'];
    customerName = json['customerName'];
    customerCPF = json['customerCPF'];
    customerMotherName = json['customerMotherName'];
    customerBirthDate = json['customerBirth'];
    indicationCode = json['customerInviteCode'];
    userName = json['customerUsername'];
    level = json['customerLevel'] != null
        ? new Level.fromJson(json['customerLevel'])
        : Level();
    customerAccount = json['customerAccount'] != null
        ? new BankAccount.fromJson(json['customerAccount'])
        : null;
    badge = json['customerBadge'] != null
        ? Badge.fromJson(json['customerBadge'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerName'] = this.customerName;
    data['customerNick'] = this.customerNick;
    data['motherName'] = this.customerMotherName;
    if (this.userName != null) {
      data['customerUsername'] = this.userName;
    }

    return data;
  }
}

class Badge {
  String? title;
  String? description;
  String? image;

  Badge({this.title, this.description, this.image});

  Badge.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    image = json['image'];
  }
}

class BankAccount {
  String? bank;
  int? bankNumber;
  String? agency;
  String? account;

  BankAccount({this.bank, this.bankNumber, this.agency, this.account});

  BankAccount.fromJson(Map<String, dynamic> json) {
    bank = json['bank'];
    bankNumber = json['bankCode'];
    agency = json['agency'];
    account = json['account'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank'] = this.bank;
    data['bankNumber'] = this.bankNumber;
    data['agency'] = this.agency;
    data['account'] = this.account;
    return data;
  }
}

class ClaProfileModel {
  int? id;
  String? name;
  String? logo;
  int? qtdTrophy;

  ClaProfileModel({this.id, this.name, this.logo, this.qtdTrophy});

  ClaProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    qtdTrophy = json['qtdTrophy'];
  }
}

class UserProfileModel {
  int? customerId;
  String? nickName;
  String? userName;
  String? statusInvite;
  String? firebaseId;
  String? avatar;
  bool isPrime = false;
  bool isEmbaixador = false;
  List<Badge>? badges;
  List<CommonGame>? games;
  Level? level;
  ClaProfileModel? cla;

  UserProfileModel(
      {this.nickName,
      this.userName,
      this.avatar,
      this.badges,
      this.games,
      this.statusInvite,
      this.firebaseId,
      this.customerId});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    isPrime = json['isPrime'] ?? false;
    isEmbaixador = json['isEmbaixador'] ?? false;
    userName = json['userName'];
    avatar = json['avatar'];
    nickName = json['nickName'];
    firebaseId = json['firebaseId'];
    statusInvite = json['statusInvite'];
    if (json['games'] != null) {
      games = <CommonGame>[];
      json['games'].forEach((v) {
        games?.add(new CommonGame.fromJson(v));
      });
    }
    if (json['badges'] != null) {
      badges = <Badge>[];
      json['badges'].forEach((v) {
        badges?.add(new Badge.fromJson(v));
      });
    }
    if (json['customerLevel'] != null) {
      level = new Level.fromJson(json['customerLevel']);
    }
    if (json['cla'] != null) {
      cla = new ClaProfileModel.fromJson(json['cla']);
    }
  }
}
