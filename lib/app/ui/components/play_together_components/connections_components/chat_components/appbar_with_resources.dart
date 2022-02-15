import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';

class AppBarWithResources extends StatelessWidget {
  const AppBarWithResources({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(10),
        child: IntrinsicHeight(
          child: Divider(
            color: Colors.white,
            height: 10,
          ),
        ),
      ),
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Fulano",
          style: textStyle,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ))
      ],
    );
  }
}
