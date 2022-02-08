import 'package:cGamer/app/controllers/extract/extract_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:get/get.dart';

class ChooseMenu extends StatefulWidget {
  final ExtractController _controller;

  ChooseMenu(this._controller);

  @override
  _ChooseMenuState createState() => _ChooseMenuState(_controller);
}

class _ChooseMenuState extends State<ChooseMenu> {
  final ExtractController _controller;

  _ChooseMenuState(this._controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 16),
      width: screenWidthhSize,
      child: Row(
        children: [
          HorizontalSwitch(_controller),
          IconButton(
              icon: Icon(
                Icons.filter_list,
                color: primaryColor,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return CustomDialogFilter(
                        extractController: _controller,
                      );
                    });
              })
        ],
      ),
    );
  }
}
