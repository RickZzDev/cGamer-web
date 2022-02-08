class PlayTogetherInviteRequest {
  int? customerId;
  String? from;
  int? gameId;
  int? platformId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this.customerId;
    data['from'] = this.from;
    data['gameId'] = this.gameId;
    data['platformId'] = this.platformId;
    return data;
  }
}
