import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DepositHint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: Colors.white,
          height: 1,
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Flexible(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                      fontSize: 18, color: Colors.white, fontFamily: 'Exo'),
                  children: <TextSpan>[
                    TextSpan(
                      text: "O ",
                    ),
                    TextSpan(
                      text: "saldo ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "é liberado em até ",
                    ),
                    TextSpan(
                      text: "3 dias úteis ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "após o ",
                    ),
                    TextSpan(
                      text: "pagamento",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Divider(
          color: Colors.white,
          height: 1,
        ),
      ],
    );
  }
}
