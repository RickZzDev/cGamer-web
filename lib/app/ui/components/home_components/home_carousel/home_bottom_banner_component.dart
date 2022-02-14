import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeBottomBanner extends StatelessWidget {
  const HomeBottomBanner({
    Key? key,
    required HomeController controller,
  })   : _controller = controller,
        super(key: key);

  final HomeController _controller;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _controller.changeTab!(1),
      child: Container(
        margin: EdgeInsets.only(top: 8, bottom: 8),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 12),
        height: 140,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 135,
              child:
                  //SvgPicture.asset(
                  //     "assets/images/onboard_images/BG_Onboarding_01.svg")
                  Image.asset("assets/images/onboard_images/01c.png"),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Acesse sua\nGamer Store",
                    style: textStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Compre crédito, jogos, produtos gamers e muito mais",
                    style: textStyle.copyWith(
                      fontSize: 12,
                      color: Theme.of(context).accentColor,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
