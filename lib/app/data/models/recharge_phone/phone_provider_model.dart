class PhoneProvidersModel {
  List<PhoneProvider>? providers;

  PhoneProvidersModel({this.providers});

  PhoneProvidersModel.fromJson(Map<String, dynamic> json) {
    if (json['providers'] != null) {
      providers = <PhoneProvider>[];
      json['providers'].forEach((v) {
        providers?.add(new PhoneProvider.fromJson(v));
      });
    }
  }
}

class PhoneProvider {
  String? name;
  String? iconUrl;

  PhoneProvider({this.name, this.iconUrl});

  PhoneProvider.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    iconUrl = json['iconUrl'];
  }
}
