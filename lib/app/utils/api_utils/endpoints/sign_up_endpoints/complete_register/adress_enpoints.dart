import 'package:cGamer/app/utils/api_utils/api_exports.dart';

class CompleteRegisterEndpoints {
  String sendSms() => "/customer/sms";

  String completeRegistration() => "/customer/complete-registration";

  String sendRegisterComplete() => "/customer/complete-registration";

  String getCepUrl(String _cep) => "/ws/$_cep/json/";

  String getUfUrl() => "/api/v1/localidades/estados?orderBy=nome";

  String getCityByUfUrl(String _uf) =>
      "/api/v1/localidades/estados/$_uf/municipios?orderBy=nome";
}
