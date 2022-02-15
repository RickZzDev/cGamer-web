import 'dart:convert';

import 'package:cGamer/app/data/models/cash_models/banks_model.dart';
import 'package:cGamer/app/data/models/cash_models/contacts_intern_list_model.dart';
import 'package:cGamer/app/data/models/cash_models/transfer_response_model.dart';
import 'package:cGamer/app/data/provider/transfer_providers/transfer_extern_provider.dart';
import 'package:meta/meta.dart';

class TransferExternRepository {
  final TransferExternApiClient apiClient;

  TransferExternRepository({required this.apiClient});

  getContacts() async {
    var _response = await apiClient.getContacts();
    if (_response is Exception)
      return _response;
    else
      return ContactsListModel.fromExternJson(json.decode(_response.body));
  }

  saveContact(Map<String, dynamic> jsonValue) {
    return apiClient.saveContact(jsonValue);
  }

  sendTransfer(Map<String, dynamic> transferExternJson) async {
    var _response = await apiClient.sendTransfer(transferExternJson);
    if (_response is Exception)
      return _response;
    else
      return TransferResponseModel.fromJson(json.decode(_response.body));
  }

  getBanks() async {
    var _response = await apiClient.getBanks();
    if (_response is Exception)
      return _response;
    else
      return BanksModel.fromJson(json.decode(_response.body));
  }
}
