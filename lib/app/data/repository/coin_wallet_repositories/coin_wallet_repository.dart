import 'dart:convert';

import 'package:cGamer/app/data/models/prime_models/prime_model.dart';
import 'package:cGamer/app/data/provider/coin_wallet_provider/coin_wallet_provider.dart';
import 'package:cGamer/app/data/repository/coin_wallet_repositories/mafa_balance_model.dart';
import 'package:cGamer/app/data/repository/coin_wallet_repositories/mafa_last_moviments_model.dart';
import 'package:http/http.dart';

class CoinWalletRepository {
  final CoinWalletProvider provider;
  CoinWalletRepository({required this.provider});

  Future<dynamic> getCurrencyValue() async {
    try {
      Response response = await provider.getBenefits();
      PrimeBenefitsModel model = PrimeBenefitsModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      return model;
    } catch (e) {
      throw e;
    }
  }

  Future<MafaBalanceModel> getMafaBalance() async {
    try {
      dynamic response = await provider.getMafaBalance();

      MafaBalanceModel model = MafaBalanceModel.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));

      return model;
    } catch (e) {
      rethrow;
    }
  }

  Future<PayWithPixModel> payWithPix(PayWithPixRequest request) async {
    try {
      Response response = await provider.payWithPix(request);
      PayWithPixModel model = PayWithPixModel.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));

      return model;
    } catch (e) {
      throw e;
    }
  }

  Future<PayWithPixConfirmModel> confirmPix(String orderId) async {
    try {
      Response response = await provider.confirmPix(orderId);
      PayWithPixConfirmModel model = PayWithPixConfirmModel.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));

      return model;
    } catch (e) {
      throw e;
    }
  }

  Future<LastMafaMovimentsModel> getLastMoviments() async {
    try {
      dynamic response = await provider.getLastMoviments();

      var model = LastMafaMovimentsModel.fromJson(
        json.decode(
          utf8.decode(response.bodyBytes),
        ),
      );

      return model;
    } catch (e) {
      rethrow;
    }
  }
}
