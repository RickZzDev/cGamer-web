import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';

class CustomizationButton extends StatelessWidget {
  CustomizationButton({required this.onTap});
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                offset: Offset(2, 4.0), //(x,y)
                blurRadius: 2.0,
              ),
            ],
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(9))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Comprar",
              style: textStyle.copyWith(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 8,
            ),
            Icon(
              Icons.monetization_on,
              color: Colors.orange[300],
            ),
            SizedBox(
              width: 4,
            ),
            Text("20",
                style: textStyle.copyWith(color: Theme.of(context).accentColor))
          ],
        ),
      ),
    );
  }
}
