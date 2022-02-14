import 'package:cGamer/app/controllers/coin_wallet/coin_walelt_controller.dart';
import 'package:cGamer/app/data/models/coin_wallet/transfer_review_model.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferCoinReview extends StatefulWidget {
  final TransferReviewModel mafaReviewModel;

  TransferCoinReview({
    Key? key,
  })  : mafaReviewModel = Get.arguments['transferReviewModel'],
        super(key: key);

  @override
  State<TransferCoinReview> createState() => _TransferCoinReviewState();
}

class _TransferCoinReviewState extends State<TransferCoinReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: CustomAppBar(
        appBarTxt: 'Transferir \$MAFA',
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: GenericButton(
          text: 'Confirmar',
          txtColor: Colors.white,
          color: primaryColor,
          onPressedFunction: () => Get.toNamed(
            Routes.WALLET_COIN_PASSWORD,
            arguments: {
              'transferReviewModel': widget.mafaReviewModel,
              'isWithdraw': false
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'Confira abaixo o resumo da tranferência',
              style: textStyle,
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Column(
                children: [
                  Text(
                    'Resumo da transferência',
                    style: textStyle.copyWith(fontSize: 18),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Para',
                        style: textStyle.copyWith(fontSize: 16),
                      ),
                      Text(
                        '@${widget.mafaReviewModel.userDestination}',
                        style: textStyle.copyWith(
                            fontSize: 16, color: Color(0xFFA381BA)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quantidade',
                        style: textStyle.copyWith(fontSize: 16),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: textStyle,
                          children: <TextSpan>[
                            TextSpan(
                                style: textStyle.copyWith(
                                    fontWeight: FontWeight.bold),
                                text: '${widget.mafaReviewModel.quantity}'
                                    .replaceAll('.', ',')),
                            TextSpan(
                              text: " \$",
                              style: textStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF9900CC).withOpacity(0.8),
                              ),
                            ),
                            TextSpan(
                                text: "MAFA",
                                style: textStyle.copyWith(
                                    color: Colors.white.withOpacity(0.8))),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Taxa de serviço',
                        style: textStyle.copyWith(fontSize: 16),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: textStyle,
                          children: <TextSpan>[
                            TextSpan(
                                style: textStyle.copyWith(
                                    fontWeight: FontWeight.bold),
                                text:
                                    '${widget.mafaReviewModel.taxAmount.toPrecision(2)}'
                                        .replaceAll('.', ',')),
                            TextSpan(
                              text: " \$",
                              style: textStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF9900CC).withOpacity(0.8),
                              ),
                            ),
                            TextSpan(
                                text: "MAFA",
                                style: textStyle.copyWith(
                                    color: Colors.white.withOpacity(0.8))),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Text(
                          'Saldo em ',
                          style: textStyle.copyWith(fontSize: 16),
                        ),
                        Text(
                          '\$',
                          style: textStyle.copyWith(
                            fontSize: 16,
                            color: Color(0xFF9900CC),
                          ),
                        ),
                        Text(
                          'MAFA',
                          style: textStyle.copyWith(fontSize: 16),
                        ),
                        SizedBox(width: 4),
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Image.asset(
                            'assets/images/gamification_icons/mafa_coin.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text(
                          ' ${widget.mafaReviewModel.availableAmmount}'
                              .replaceAll('.', ','),
                          style: textStyle.copyWith(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          " \$",
                          style: textStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9900CC).withOpacity(0.8),
                          ),
                        ),
                        Text("MAFA",
                            style: textStyle.copyWith(
                                color: Colors.white.withOpacity(0.8))),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
