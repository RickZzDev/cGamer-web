class NewsModel {
  List<NewsFeed>? news;

  NewsModel({this.news});

  NewsModel.fromJson(Map<String, dynamic> json) {
    if (json['item'] != null) {
      news = <NewsFeed>[];
      json['item'].forEach((v) {
        news?.add(new NewsFeed.fromJson(v));
      });
    }
  }
}

class NewsFeed {
  String? title;
  String? image;
  String? url;
  dynamic category;
  dynamic content;

  NewsFeed({this.title, this.image, this.url});

  NewsFeed.fromJson(Map<String, dynamic> json) {
    title = json['title']['\$t'];
    url = json['link']['\$t'];
    category = "";
    if (json['category'] != null) {
      if (json['category'] is List) {
        json['category'].forEach((v) {
          category = category + v['__cdata'] + ";";
        });
      } else {
        category = json['category']['__cdata'];
      }
    }
    //category = json['category'][0]['__cdata'];
    content = json['content\$encoded']['__cdata'];
  }
}
