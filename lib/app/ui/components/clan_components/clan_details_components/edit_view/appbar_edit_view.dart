import 'package:cGamer/app/controllers/clan_controllers/clan_details_controller.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';

class AppBarEditView extends StatelessWidget {
  final TextEditingController appBarTextController;
  final controller;
  AppBarEditView(this.appBarTextController, this.controller);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: TextFormField(
        textAlign: TextAlign.center,
        style: textStyle.copyWith(fontSize: 20),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
        controller: this.appBarTextController,
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(10),
        child: IntrinsicHeight(
          child: Divider(
            color: Colors.white,
            height: 10,
          ),
        ),
      ),
      actions: [
        IconButton(
            icon: Icon(
              Icons.close_outlined,
              color: Colors.white70,
              size: 24,
            ),
            onPressed: () {
              controller.isEditing.value = false;
              controller.resetEditFields();
            }),
        IconButton(
            icon: Icon(
              Icons.check,
              size: 24,
              color: primaryColor,
            ),
            onPressed: () {
              controller.updateCla(this.appBarTextController.text,
                  controller.descriptionTextController?.text, null);
              controller.isEditing.value = !controller.isEditing.value;
              controller.resetEditFields();
            }),
      ],
    );
  }
}
