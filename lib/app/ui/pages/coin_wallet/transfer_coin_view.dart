import 'package:cGamer/app/controllers/coin_wallet/coin_walelt_controller.dart';
import 'package:cGamer/app/controllers/coin_wallet/transfer_coin_controller.dart';
import 'package:cGamer/app/data/provider/coin_wallet_provider/coin_wallet_provider.dart';
import 'package:cGamer/app/data/provider/play_together_providers/connections_provider.dart';
import 'package:cGamer/app/data/repository/coin_wallet_repositories/coin_wallet_repository.dart';
import 'package:cGamer/app/data/repository/play_together_repositories/connections_repository.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/home_components/pro_banner_slim.dart';
import 'package:cGamer/app/ui/components/play_together_components/connections_components/subpages/gamers_list.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class TransferCoinPage extends StatefulWidget {
  TransferCoinPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TransferCoinPage> createState() => _TransferCoinPageState();
}

class _TransferCoinPageState extends State<TransferCoinPage> {
  late TransferCoinController _controller;
  late double mafaAmmount;

  @override
  void initState() {
    mafaAmmount = Get.arguments['mafaAmmount'];
    _controller = Get.find<TransferCoinController>();
    _controller.ammountAvailable = mafaAmmount.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ModalProgressHUD(
          inAsyncCall: _controller.loading.value,
          child: Scaffold(
            backgroundColor: secondaryColor,
            appBar: CustomAppBar(
              appBarTxt: 'Transferir \$MAFA',
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              child: GenericButton(
                text: _controller.gamersListModel.value.users != null &&
                        _controller.gamersListModel.value.users!.length == 1
                    ? 'Próximo'
                    : 'Buscar',
                enabled: !_controller.shouldShowError.value,
                txtColor: Colors.white,
                color: primaryColor,
                onPressedFunction:
                    _controller.gamersListModel.value.users == null ||
                            _controller.gamersListModel.value.users!.length != 1
                        ? () => _controller
                            .searchUser(_controller.userNameController.text)
                        : () => _controller.transferCoin(),
              ),
            ),
            body: ListView(shrinkWrap: true, children: [
              // Obx(() => _controller.isPrime.value
              //     ? Container()
              //     : ProBannerSlim(
              //         title:
              //             "Prime: Zere a taxa de serviço na transferência.")),
              Padding(
                padding: const EdgeInsets.all(24),
                child: ListView(
                  shrinkWrap: true,
                  // crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'Exo',
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Quantos ",
                          ),
                          TextSpan(
                            text: "\$",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF9900CC),
                            ),
                          ),
                          TextSpan(text: 'MAFA você deseja transferir?'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text(
                          'Saldo disponível: ',
                          style: textStyle,
                        ),
                        SizedBox(
                          height: 15,
                          width: 15,
                          child: Image.asset(
                            'assets/images/gamification_icons/mafa_coin.png',
                          ),
                        ),
                        Text(
                          ' $mafaAmmount '.replaceAll('.', ','),
                          style: textStyle,
                        ),
                        Text(
                          '\$',
                          style: textStyle.copyWith(
                            color: Color(0xFF9900CC),
                          ),
                        ),
                        Text(
                          'MAFA',
                          style: textStyle,
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 24),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border.all(color: primaryColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 36,
                                    width: 36,
                                    child: Image.asset(
                                      'assets/images/gamification_icons/mafa_coin.png',
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    ' \$',
                                    style: textStyle.copyWith(
                                      color: Color(0xFF9900CC),
                                    ),
                                  ),
                                  Text(
                                    'MAFA ',
                                    style: textStyle.copyWith(),
                                  ),
                                ],
                              ),
                              Container(
                                height: 50,
                                width: 200,
                                child: TextField(
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  autofocus: true,
                                  minLines: 1,
                                  style: textStyle.copyWith(fontSize: 22),
                                  textAlign: TextAlign.right,
                                  controller:
                                      _controller.mafaQuantityController,
                                  onChanged: (_) =>
                                      _controller.verifyIfHavaAmmount(
                                    inputedAmmount: _controller
                                            .mafaQuantityController.text.isEmpty
                                        ? 0
                                        : double.parse(_controller
                                            .mafaQuantityController.text
                                            .replaceAll('.', '')
                                            .replaceAll(',', '.')),
                                    availableAmmount: mafaAmmount,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "0",
                                    hintStyle: textStyle.copyWith(
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Text(
                                  '+ Taxa de serviço: ${_controller.taxValue.value == "" ? "---" : "${_controller.taxValue.value}"}',
                                  style: textStyle.copyWith(fontSize: 14)),
                              Text(' \$',
                                  style: textStyle.copyWith(
                                      fontSize: 14, color: Color(0xFF9900CC))),
                              Text('MAFA',
                                  style: textStyle.copyWith(fontSize: 14))
                            ]),
                            SizedBox(
                              child: Text(
                                _controller.shouldShowError.value
                                    ? 'Saldo insuficiente'
                                    : '',
                                style: textStyle.copyWith(
                                    color: Colors.red, fontSize: 16),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Digite abaixo o nome do usuário para fazer a transferência ',
                      style: textStyle,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                        labelText: 'nome de usuário',
                        prefixIcon: Icon(
                          Icons.alternate_email_outlined,
                          color: primaryColor,
                        ),
                        onFieldSubmitted: (value) {
                          _controller
                              .searchUser(_controller.userNameController.text);
                        },
                        onChange: (value) {
                          _controller.userNameController.text = value;
                          if (value.toString().isEmpty) {
                            _controller.resetUserModel();
                          }
                        }),
                    _controller.gamersListModel.value.users == null
                        ? SizedBox()
                        : Obx(
                            () => Container(
                              margin: EdgeInsets.only(top: 12, bottom: 12),
                              child: GamersListToTransfer(
                                _controller.gamersListModel.value,
                              ),
                            ),
                          ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
