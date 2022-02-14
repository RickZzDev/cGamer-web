import 'package:cGamer/app/controllers/wallet_controllers/card_extract_controllers/card_extract_controller.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';

import '../../../components.dart';

class ChoiceMenu extends StatelessWidget {
  final CardExtractController _controller;
  ChoiceMenu(this._controller);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Row(
        children: [
          Expanded(child: HorizontalChoiceComponent(onTap: (index) {
            _controller.atualIndex.value = index;
          })),
          IconButton(
              icon: Icon(
                Icons.filter_list,
                color: primaryColor,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return CardDialogFilter(
                        _controller,
                      );
                    });
              })
        ],
      ),
    );
  }
}
