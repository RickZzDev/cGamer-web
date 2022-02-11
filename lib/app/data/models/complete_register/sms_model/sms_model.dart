class SmsResponse {
  String? situacao;

  SmsResponse({this.situacao});

  SmsResponse.fromJson(Map<String, dynamic> json) {
    situacao = json['situacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['situacao'] = this.situacao;
    return data;
  }
}
