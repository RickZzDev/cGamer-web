class OffersModel {
  List<OfferModel>? offers;

  OffersModel();

  OffersModel.fromJson(Map<String, dynamic> json) {
    offers = <OfferModel>[];
    json['offers'].forEach((v) {
      offers?.add(new OfferModel.fromJson(v));
    });
  }
}

class OfferModel {
  int? id;
  String? name;
  String? image;
  String? linkType;
  String? deepLink;

  OfferModel();

  OfferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    linkType = json['linkType'];
    deepLink = json['deepLink'];
  }
}
