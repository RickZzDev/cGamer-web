import 'dart:convert';

import 'package:cGamer/app/data/models/cash_models/contacts_intern_list_model.dart';
import 'package:cGamer/app/data/provider/transfer_providers/transfer_intern_provider.dart';
import 'package:meta/meta.dart';

class TransferInterRepository {
  final TransferInterApiClient apiClient;

  TransferInterRepository({required this.apiClient});

  getContacts() async {
    var _response = await apiClient.getContacts();
    if (_response is Exception)
      return _response;
    else
      return ContactsListModel.fromJson(json.decode(_response.body));
  }

  getExternContacts() async {
    var _response = await apiClient.getContacts();
    if (_response is Exception)
      return _response;
    else
      return ContactsListModel.fromJson(json.decode(_response.body));
  }

  getUserInfo(String _identifier) {
    return apiClient.getUserInfo(_identifier);
  }

  transfer(Map<String, dynamic> json) {
    return apiClient.sendTransfer(json);
  }

  saveContact(String identifier) {
    return apiClient.saveContact(identifier);
  }
}
