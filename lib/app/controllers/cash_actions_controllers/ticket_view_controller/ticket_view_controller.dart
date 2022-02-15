import 'dart:io';

import 'package:cGamer/app/data/models/bankslip_models/ticket_list_model.dart';
import 'package:cGamer/app/data/models/bankslip_models/ticket_response_model.dart';
import 'package:cGamer/app/data/repository/bankslip_repositories/bankslip_repository.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/state_manager.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class TicketViewController extends GetxController {
  final BankSliptRepository repository;

  TicketViewController({required this.repository});

  MaskedTextController barCodeController = MaskedTextController(
      mask: '00000.00000 00000.000000 00000.000000 0 00000000000000');

  final totalToPay = MoneyMaskedTextController(
    decimalSeparator: ',',
    thousandSeparator: '.',
    precision: 2,
    initialValue: 00.00,
    leftSymbol: "R\$ ",
  );

  bool payd = false;

  TicketResponseModel ticketInfo = TicketResponseModel();

  Bankslips singleTicket = Bankslips();

  String pathPDF = "";

  String status = "";

  final loading = false.obs;

  Future<void> createFileOfPdfUrl() async {
    List<int> bytes;
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/boleto.pdf');
    loading.value = true;
    String? authenticationCode = ticketInfo.authenticationCode != null
        ? ticketInfo.authenticationCode
        : singleTicket.authenticationCode;

    var response = await repository.getPDF(authenticationCode ?? "");
    if (response is Exception) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc:
              'Ocorreu um erro ao carregar seu boleto. Tente copiar o código acima, ou voltar mais tarde.',
          title: "Atenção");
      return;
    } else {
      bytes = response.bodyBytes;
    }

    await file.writeAsBytes(bytes);
    pathPDF = file.path;
    loading.value = false;
    OpenFile.open(pathPDF);
    return;
  }
}
