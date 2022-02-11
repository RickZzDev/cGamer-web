class UfModel {
  String? sigla;

  UfModel({this.sigla});

  UfModel.fromJson(Map<String, dynamic> json) {
    sigla = json['sigla'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sigla'] = this.sigla;
    return data;
  }
}
