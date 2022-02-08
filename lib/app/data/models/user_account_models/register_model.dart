class StatusRegisterModel {
  String? statusBanlky;
  bool hasSendDocumentation = false;
  bool hasCompleteRegistration = false;
  String? reason;

  StatusRegisterModel(
      {this.statusBanlky,
      this.hasSendDocumentation = false,
      this.hasCompleteRegistration = false,
      this.reason});

  StatusRegisterModel.fromJson(Map<String, dynamic> json) {
    statusBanlky = json['statusBankly'];
    hasSendDocumentation = json['hasSendDocumentation'] == null
        ? false
        : json['hasSendDocumentation'];
    hasCompleteRegistration = json['hasCompleteRegistration'] ?? false;
    reason = json['reason'];
  }
}
