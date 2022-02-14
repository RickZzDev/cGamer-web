class ClanEmblemModel {
  late List<EmblemGridItemModel> emblems;
  ClanEmblemModel();
  ClanEmblemModel.fromJson(Map<String, dynamic> json) {
    if (json['emblems'] != null) {
      emblems = [];
      json['emblems'].forEach(
          (object) => emblems.add(EmblemGridItemModel.fromJson(object)));
    }
  }
}

class EmblemGridItemModel {
  late int id;
  bool isSelected = false;
  late String urlImage;

  EmblemGridItemModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.urlImage = json['image'];
  }

  EmblemGridItemModel(this.id, this.isSelected, this.urlImage);
}
