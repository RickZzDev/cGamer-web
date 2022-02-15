import 'package:cGamer/app/data/models/bill_payment/bill_payment_model.dart';
import 'package:cGamer/app/data/provider/bill_payment_providers/bill_payment_provider.dart';
import 'package:meta/meta.dart';

class BillPaymentRepository {
  final BillPaymentApiClient apiClient;

  BillPaymentRepository({required this.apiClient});

  confirm(BillPaymentConfirmModel model) async {
    return await apiClient.confirm(model);
  }

  validate(BillPaymentValidateModel model) async {
    return await apiClient.validate(model);
  }
}
