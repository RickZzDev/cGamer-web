import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  final String appBarTxt;
  final bool removeIcon;
  final List<Widget>? actions;
  final SystemUiOverlayStyle? statusBar;

  CustomAppBar(
      {this.appBarTxt = "Dados pessoais",
      this.removeIcon = false,
      this.statusBar,
      this.actions});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: statusBar,
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        appBarTxt,
        style: TextStyle(color: Colors.white, fontFamily: "Exo"),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(10),
        child: IntrinsicHeight(
          child: Divider(
            color: Colors.white,
            height: 0,
          ),
        ),
      ),
      actions: actions,
      leading: removeIcon
          ? SizedBox()
          : IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);
}
