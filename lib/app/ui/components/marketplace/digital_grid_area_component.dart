import 'package:cGamer/app/controllers/marketplace/marketplace_controller.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class DigitalGridAreaComponent extends StatelessWidget {
  DigitalGridAreaComponent(
      {Key? key, required MarketplaceController marketplaceController})
      : _controller = marketplaceController,
        super(key: key);

  final List<String> categoryName = [
    "Games",
    "Alimentação",
    "Mobilidade",
    "Streaming",
    "Assinaturas",
    "Créditos"
  ];

  final List<String> imagesList = [
    'assets/images/marketplace/Gamer.svg',
    "assets/images/marketplace/Alimentacao.svg",
    "assets/images/marketplace/Mobilidade.svg",
    "assets/images/marketplace/Streaming.svg",
    "assets/images/marketplace/Assinatura.svg",
    "assets/images/wallet_images/Sem_Parcelas.svg"
  ];

  final List<String> keysCategory = [
    'GAMES',
    "FOOD",
    "MOBILITY",
    "STREAMING",
    "SIGNATURE",
    "CREDITS"
  ];

  MarketplaceController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 24, right: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 4),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (context, index) => InkWell(
          onTap: () => _controller.getCollectionsWithCategory(
              keysCategory[index], categoryName[index]),
          child: Column(
            children: [
              Container(
                height: 80,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(2, 3.0), //(x,y)
                      blurRadius: 3.0,
                    ),
                  ],
                  color: secondaryColor,
                  border: Border.all(width: 1.0, color: primaryColor),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Center(
                  child: Container(
                    height: 44,
                    width: 44,
                    child: SvgPicture.asset(
                      imagesList[index],
                      color: primaryColor,
                      fit: BoxFit.scaleDown,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                categoryName[index],
                style: textStyle.copyWith(
                    color: Colors.white, fontSize: screenHeigthSize * 0.017),
              )
            ],
          ),
        ),
      ),
    );
    // child:
  }
}
