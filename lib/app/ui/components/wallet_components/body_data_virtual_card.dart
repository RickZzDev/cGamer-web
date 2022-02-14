import 'package:cGamer/app/controllers/wallet_controllers/wallet_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/wallet_components/card_action_button.dart';
import 'package:cGamer/app/ui/components/wallet_components/virtual_card_transaction.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodyDataVirtualCard extends StatelessWidget {
  const BodyDataVirtualCard({Key? key, required WalletController controller})
      : _controller = controller,
        super(key: key);

  final WalletController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(24),
        child: Column(children: [
          PhysicalModel(
              color: Colors.black,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              elevation: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  border: Border.all(
                    color: primaryColor,
                  ),
                ),
                // height: screenHeigthSize * 0.4,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Numero do cartão",
                                    style: textStyle.copyWith(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  _controller.virtualCardModel.value == null &&
                                          _controller.virtualCardModel.value
                                                  .cardLastFourDigits ==
                                              null
                                      ? IconButton(
                                          icon: Icon(
                                            Icons.refresh_outlined,
                                            color: primaryColor,
                                            size: 28,
                                          ),
                                          onPressed: () =>
                                              _controller.refreshPage(),
                                        )
                                      : SizedBox()
                                ],
                              ),
                              Text(
                                _controller.virtualCardIsVisible.value
                                    ? _controller.pciModel.value.cardNumber ??
                                        "**** **** **** ${_controller.virtualCardModel.value.cardLastFourDigits}"
                                    : _controller.virtualCardModel.value !=
                                                null &&
                                            _controller.virtualCardModel.value
                                                    .cardLastFourDigits !=
                                                null
                                        ? "**** **** **** ${_controller.virtualCardModel.value.cardLastFourDigits}"
                                        : "Em processamento...",
                                style: textStyle,
                              ),
                            ],
                          ),
                          !_controller.virtualCardIsVisible.value
                              ? CardButton(
                                  onTap: () {
                                    Get.toNamed(
                                        Routes
                                            .WALLET_ADD_VIRTUAL_CARD_ACCOUNT_PASSWORD_STEP,
                                        arguments: {'origin': "wallet_header"});
                                  },
                                  txt: "Visualizar",
                                  icon: Icon(
                                    Icons.visibility,
                                    color: Colors.white,
                                  ),
                                )
                              : CardButton(
                                  onTap: () {
                                    _controller.copyCardNumber();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Número do cartão copiado com sucesso.")));
                                  },
                                  txt: "Copiar",
                                  icon: Icon(
                                    Icons.copy,
                                    color: Colors.white,
                                  ),
                                )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Validade",
                                style: textStyle.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                _controller.virtualCardIsVisible.value
                                    ? _controller.pciModel.value
                                            .cardExpirationDate ??
                                        "** / **"
                                    : "** / **",
                                style: textStyle,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "CVV",
                                style: textStyle.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                _controller.virtualCardIsVisible.value
                                    ? _controller.pciModel.value.cardCvv ??
                                        "***"
                                    : "***",
                                style: textStyle,
                              ),
                            ],
                          ),
                          CardButton(
                              onTap: () {
                                Get.toNamed(
                                    Routes
                                        .WALLET_BLOCK_VIRTUAL_CARD_PASSWORD_STEP,
                                    arguments: {
                                      'action': _controller.virtualCardModel
                                                  .value.cardStatus ==
                                              "TemporarilyUserLocked"
                                          ? "unlock"
                                          : "lock"
                                    });
                              },
                              txt: _controller
                                          .virtualCardModel.value.cardStatus ==
                                      "TemporarilyUserLocked"
                                  ? "Desbloquear"
                                  : "Bloquear",
                              icon: Icon(
                                _controller.virtualCardModel.value.cardStatus ==
                                        "TemporarilyUserLocked"
                                    ? Icons.lock_open_rounded
                                    : Icons.lock_outline_rounded,
                                color: Colors.white,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        _controller.virtualCardModel.value.cardName ?? "",
                        style: textStyle,
                      )
                    ],
                  ),
                ),
              )),
          SizedBox(
            height: 16,
          ),
          PhysicalModel(
            color: Colors.black,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            elevation: 8,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(color: primaryColor),
              ),
              child: MaterialButton(
                onPressed: () => Get.toNamed(Routes.WALLET_SETTINGS_OPTIONS,
                    arguments: {
                      "card_model": _controller.virtualCardModel.value
                    }),
                padding: EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Configurações",
                      style: textStyle.copyWith(),
                    ),
                    Icon(
                      Icons.settings,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Divider(
            color: Colors.white,
          ),
          SizedBox(
            height: 8,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Movimentações",
                  style: textStyle.copyWith(fontSize: 20),
                  textAlign: TextAlign.left,
                )),
            Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "últimos 7 dias",
                  style: textStyle.copyWith(fontSize: 14),
                  textAlign: TextAlign.left,
                ))
          ]),
          SizedBox(
            height: 20,
          ),
          _controller.virtualCardTransactions.value.transactions != null &&
                  (_controller.virtualCardTransactions.value.transactions
                              ?.length ??
                          0) >=
                      3
              ? Column(children: [
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) =>
                        VirtualCardTransactionComponent(
                      date: _controller.virtualCardTransactions.value
                          .transactions?[index].date,
                      title: _controller.virtualCardTransactions.value
                          .transactions?[index].title,
                      value: _controller.virtualCardTransactions.value
                          .transactions?[index].amount,
                    ),
                    itemCount: _controller.virtualCardTransactions.value
                            .transactions?.length ??
                        0,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: _controller.openWalletExtractPage,
                      child: Text(
                        "Ver mais",
                        style: textStyle.copyWith(color: primaryColor),
                      ),
                    ),
                  )
                ])
              : Text("Nenhuma transação encontrada nesse período",
                  style: textStyle.copyWith(fontSize: 16))
        ]));
  }
}
