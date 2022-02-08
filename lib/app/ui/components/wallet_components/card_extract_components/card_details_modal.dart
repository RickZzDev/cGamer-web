import 'package:cGamer/app/data/models/wallet_models/virtual_card_transactions.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';

class CardDetaisModal extends StatelessWidget {
  final VirtualCardTransaction transaction;

  CardDetaisModal({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeigthSize * 0.85,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          color: primaryColor),
    );
  }
}
