import 'package:cGamer/app/controllers/coin_wallet/coin_walelt_controller.dart';
import 'package:cGamer/app/data/models/coin_wallet/transfer_review_model.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferCoinPasswordView extends StatefulWidget {
  final TransferReviewModel mafaReviewModel;

  TransferCoinPasswordView({
    Key? key,
  })  : mafaReviewModel = Get.arguments['transferReviewModel'],
        super(key: key);

  @override
  State<TransferCoinPasswordView> createState() =>
      _TransferCoinPasswordViewState();
}

class _TransferCoinPasswordViewState extends State<TransferCoinPasswordView> {
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
            onPressedFunction: () {}),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'Confira abaixo o resumo da tranferência',
              style: textStyle,
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
                        '@ ${widget.mafaReviewModel.userDestination}',
                        style: textStyle.copyWith(fontSize: 16),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quantidade',
                        style: textStyle.copyWith(fontSize: 16),
                      ),
                      Text(
                        '${widget.mafaReviewModel.quantity}',
                        style: textStyle.copyWith(fontSize: 16),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
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
                  Text(
                    'Saldo em \$MAFA',
                    style: textStyle.copyWith(fontSize: 16),
                  ),
                  Text(
                    '\$MAFA ${widget.mafaReviewModel.availableAmmount}',
                    style: textStyle.copyWith(fontSize: 16),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
