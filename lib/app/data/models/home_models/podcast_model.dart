class PodcastModel {
  List<PodcastFeed>? podcasts;

  PodcastModel({this.podcasts});

  PodcastModel.fromJson(Map<String, dynamic> json) {
    if (json['podcasts'] != null) {
      podcasts = <PodcastFeed>[];
      json['podcasts'].forEach((v) {
        podcasts?.add(new PodcastFeed.fromJson(v));
      });
    }
  }
}

class PodcastFeed {
  String? title;
  String? image;
  String? url;
  String? duration;
  String? creator;

  PodcastFeed({this.title, this.image, this.url});

  PodcastFeed.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    image = json['image'];
    duration = json['duration'];
    creator = json['creator'];
  }
}
