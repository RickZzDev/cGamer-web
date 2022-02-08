import 'package:cGamer/app/controllers/extract/extract_controller.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';

import '../../components.dart';

class HorizontalSwitch extends StatefulWidget {
  final ExtractController _controller;

  HorizontalSwitch(this._controller);
  @override
  _HorizontalSwitchState createState() => _HorizontalSwitchState(_controller);
}

class _HorizontalSwitchState extends State<HorizontalSwitch> {
  final ExtractController _controller;

  _HorizontalSwitchState(this._controller);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      height: 30,
      decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HorizontalSwitchItem('Todos', 0, _controller, () {
            _controller.filterExtract(
                model: _controller.extractResult.value, type: 0);
          }),
          HorizontalSwitchItem('Entrada', 1, _controller, () {
            _controller.filterExtract(
                model: _controller.extractResult.value, type: 1);
          }),
          HorizontalSwitchItem('Saída', 2, _controller, () {
            _controller.filterExtract(
                model: _controller.extractResult.value, type: 2);
          }),
        ],
      ),
    ));
  }
}
