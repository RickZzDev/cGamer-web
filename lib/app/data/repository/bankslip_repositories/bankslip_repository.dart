import 'dart:convert';

import 'package:cGamer/app/data/models/bankslip_models/tax_model.dart';
import 'package:cGamer/app/data/models/bankslip_models/ticket_list_model.dart';
import 'package:cGamer/app/data/models/bankslip_models/ticket_response_model.dart';
import 'package:cGamer/app/data/provider/bankslip/bankslip_provider.dart';
import 'package:meta/meta.dart';

class BankSliptRepository {
  final BankSlipApiClient apiClient;

  BankSliptRepository({required this.apiClient});

  getTax() async {
    var _response = await apiClient.getTax();
    TaxModel _taxModel = TaxModel.fromJson(
      json.decode(_response.body),
    );
    return _taxModel;
  }

  generateTicket(double _ammount) async {
    var _response = await apiClient.sendTicket(_ammount);
    if (_response is Exception) {
      return _response;
    }
    TicketResponseModel _ticketRespondeModel = TicketResponseModel.fromJson(
      json.decode(_response.body),
    );
    return _ticketRespondeModel;
  }

  getAllTickets() async {
    var _response = await apiClient.getAllTickets();
    if (_response is Exception) {
      return _response;
    }
    TicketListModel _ticketRespondeModel = TicketListModel.fromJson(
      json.decode(_response.body),
    );
    return _ticketRespondeModel;
  }

  getPDF(String authenticationCode) async {
    var _response = await apiClient.getPDF(authenticationCode);
    return _response;
  }

  getTedTax() async {
    var _response = await apiClient.getTedTax();
    TaxModel _taxModel = TaxModel.fromJson(
      json.decode(_response.body),
    );
    return _taxModel;
  }
}
