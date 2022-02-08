class StoreCollectionsModel {
  List<StorelCollectionModel>? collections;

  StoreCollectionsModel();

  StoreCollectionsModel.fromJson(Map<String, dynamic> json) {
    collections = <StorelCollectionModel>[];
    json['collections'].forEach((v) {
      collections?.add(new StorelCollectionModel.fromJson(v));
    });
  }
}

class StorelCollectionModel {
  String? url;
  String? name;
  String? image;
  String? iconUrl;
  String? category;
  String? offMessage;

  StorelCollectionModel();

  StorelCollectionModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    image = json['image'];
    iconUrl = json['iconUrl'];
    category = json['category'];
    offMessage = json['offMessage'];
  }
}
