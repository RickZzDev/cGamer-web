class PrimeBenefits {
  String? description;
  String? title;
  String? image;
  String? bigDescription;
  bool isComingSoon = false;

  PrimeBenefits();
  PrimeBenefits.fromJson(Map<String, dynamic> json) {
    this.description = json['description'];
    this.bigDescription = json['bigDescription'];
    this.title = json['title'];
    this.image = json['image'];
    this.isComingSoon = json['isComingSoon'];
  }
}

class PrimeBenefitsModel {
  List<PrimeBenefits>? benefits;
  PrimeBenefitsModel();
  PrimeBenefitsModel.fromJson(Map<String, dynamic> json) {
    this.benefits = [];
    if (json['benefits'] != null) {
      json['benefits'].forEach((benefit) {
        this.benefits?.add(PrimeBenefits.fromJson(benefit));
      });
    }
  }
}

class PrimeRewards {
  int? id;
  String? title;
  String? image;
  bool enabled = false;

  PrimeRewards();
  PrimeRewards.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.title = json['title'];
    this.image = json['image'];
    this.enabled = json['enabled'];
  }
}

class PrimeInfoModel {
  List<PrimeRewards>? rewards;
  String? expiredAt;
  String? discordId;
  PrimeInfoModel();
  PrimeInfoModel.fromJson(Map<String, dynamic> json) {
    expiredAt = json['expireAt'];
    discordId = json['discordId'];
    this.rewards = [];
    if (json['rewards'] != null) {
      json['rewards'].forEach((benefit) {
        this.rewards?.add(PrimeRewards.fromJson(benefit));
      });
    }
  }
}
