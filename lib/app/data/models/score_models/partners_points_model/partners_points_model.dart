class PartnerPointsModel {
  List<PartnersPoints>? partners;

  PartnerPointsModel({this.partners});

  PartnerPointsModel.fromJson(Map<String, dynamic> json) {
    if (json['partners'] != null) {
      partners = <PartnersPoints>[];
      json['partners'].forEach((v) {
        partners?.add(new PartnersPoints.fromJson(v));
      });
    }
  }
}

class PartnersPoints {
  String? title;
  String? iconUrl;
  String? description;
  int? id;
  int? earnPoints;
  String? platform;
  AdditionalInfoPartnersPoints? additionalInfo;

  PartnersPoints.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    iconUrl = json['iconUrl'];
    id = json['id'];
    earnPoints = json['earnPoints'];
    platform = json['platform'];
    additionalInfo =
        AdditionalInfoPartnersPoints.fromJson(json['additionalInfo']);
  }
}

class AdditionalInfoPartnersPoints {
  String? subTitle;
  String? partner;
  String? backgroundImageUrl;
  String? rules;
  String? benefitsTitle;
  List<dynamic>? benefits;
  String? aboutPartner;
  String? buttonTitle;
  String? url;

  AdditionalInfoPartnersPoints.fromJson(Map<String, dynamic> json) {
    subTitle = json['subTitle'];
    partner = json['partner'];
    backgroundImageUrl = json['backgroundImageUrl'];
    rules = json['rules'];
    benefitsTitle = json['benefitsTitle'];
    benefits = json['benefits'];
    aboutPartner = json['aboutPartner'];
    buttonTitle = json['buttonTitle'];
    url = json['url'];
  }
}
