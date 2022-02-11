import 'package:cGamer/app/data/models/bankslip_models/ticket_list_model.dart';
import 'package:cGamer/app/data/repository/bankslip_repositories/bankslip_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TicketListController extends GetxController
    with SingleGetTickerProviderMixin {
  final BankSliptRepository repository;

  TicketListController({required this.repository});

  Rx<Future<bool>> call = Future.value(false).obs;
  TicketListModel tickets = TicketListModel();

  @override
  void onReady() async {
    call.value = getAllTickets();
    super.onReady();
  }

  Future<bool> getAllTickets() async {
    var response = await repository.getAllTickets();
    response is Exception ? DoNothingAction() : tickets = response;
    return true;
  }
}
