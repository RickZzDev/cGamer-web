class TicketResponseModel {
  String? barCode;
  String? dueDate;
  String? authenticationCode;

  TicketResponseModel({this.barCode, this.dueDate, this.authenticationCode});

  TicketResponseModel.fromJson(Map<String, dynamic> json) {
    barCode = json['digitable'];
    dueDate = json['limitDate'];
    authenticationCode = json['authenticationCode'];
  }
}
