import 'package:cGamer/app/data/models/cash_models/contacts_intern_list_model.dart';
import 'package:cGamer/app/data/provider/recharge_phone_provider/recharge_phone_provider.dart';
import 'package:meta/meta.dart';

class RechargePhoneContactsRepository {
  final RechargePhoneContactsApiClient apiClient;

  RechargePhoneContactsRepository({required this.apiClient});

  getContacts() async {
    return await apiClient.getContacts();
  }

  saveContact(PhoneContact contact) async {
    return await apiClient.saveContact(contact);
  }
}
