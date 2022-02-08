import 'package:cGamer/app/ui/components/wallet_components/card_action_button.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardInfoAndActions extends StatelessWidget {
  const CardInfoAndActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.black,
      elevation: 8,
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: primaryColor,
          ),
        ),
        // height: screenHeigthSize * 0.4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Numero do cartão",
                        style: textStyle.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "0123 4567 8910 0123",
                        style: textStyle,
                      ),
                    ],
                  ),
                  CardButton(
                    txt: "Copiar",
                    icon: Icon(
                      Icons.copy,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Validade",
                        style: textStyle.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "16/07/2000",
                        style: textStyle,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CVV",
                        style: textStyle.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "344",
                        style: textStyle,
                      ),
                    ],
                  ),
                  CardButton(
                    txt: "Bloquear",
                    icon: Icon(
                      Icons.lock_outline_rounded,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Carlos Henrique Simões Novais",
                style: textStyle,
              )
            ],
          ),
        ),
        // width: screenWidthhSize * 0.4,
      ),
    );
  }
}
