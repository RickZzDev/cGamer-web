class FAQCategoryModel {
  List<FAQCategory>? categories;

  FAQCategoryModel({this.categories});

  FAQCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <FAQCategory>[];
      json['categories'].forEach((v) {
        categories?.add(new FAQCategory.fromJson(v));
      });
    }
  }
}

class FAQCategory {
  String? title;
  int? id;

  FAQCategory({this.id, this.title});

  FAQCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }
}
