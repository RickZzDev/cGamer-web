import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/score_endpoints/customization_endpoints/customization_endpoints.dart';
import 'package:cGamer/app/utils/generic_utils/security_utils.dart';
import 'package:flutter/material.dart';

class ConfirmPurchaseProvider {
  ConfirmPurchaseProvider({required this.requester});
  final Requester requester;

  Future confirmPurchase(
      {required String color, required String password}) async {
    String url = CustomizationEndpoints.colors();
    Map<String, dynamic> body = Map<String, dynamic>();
    body['color'] = color;
    body['password'] = SecurityUtils.encodeTo64(password);
    try {
      var response = await requester.post(
          url: url,
          body: body,
          header: await Headers().getAuthenticatedHeader());
      print(response.body);
      return response;
    } catch (e) {
      return throw Exception(e);
    }
  }
}
