import 'package:cGamer/app/controllers/marketplace/marketplace_controller.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class SpecialGridAreaComponent extends StatelessWidget {
  SpecialGridAreaComponent(
      {Key? key, required MarketplaceController marketplaceController})
      : _controller = marketplaceController,
        super(key: key);

  MarketplaceController _controller;

  final List<String> categoryName = [
    'Eletrônicos',
    "Periféricos",
    "Roupas",
    "Seu quarto",
    "Cursos",
    "Viagem"
  ];

  final List<String> imagesList = [
    'assets/images/marketplace/Eletronicos.svg',
    "assets/images/marketplace/Perifericos.svg",
    "assets/images/marketplace/Roupas.svg",
    "assets/images/marketplace/Quarto.svg",
    "assets/images/marketplace/Cursos.svg",
    "assets/images/marketplace/Viagem.svg"
  ];

  final List<String> keysCategory = [
    'ELETRONICS',
    "PERIPHERALS",
    "CLOTHES",
    "ROOM",
    "COURSES",
    "TRAVEL"
  ];

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
          onTap: () => _controller.getStoreCollectionsWithCategory(
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
    // return Container(
    //     padding: EdgeInsets.only(left: 24, right: 24),
    //     decoration: BoxDecoration(
    //       color: Theme.of(context).accentColor,
    //     ),
    //     child: Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Row(
    //             children: [
    //               Column(children: [
    //                 InkWell(
    //                   onTap: () {},
    //                   child: Container(
    //                       width: (MediaQuery.of(context).size.width / 3) - 27,
    //                       decoration: BoxDecoration(
    //                           boxShadow: [
    //                             BoxShadow(
    //                               color: Colors.black.withOpacity(0.5),
    //                               offset: Offset(2, 3.0), //(x,y)
    //                               blurRadius: 3.0,
    //                             ),
    //                           ],
    //                           color: secondaryColor,
    //                           border:
    //                               Border.all(width: 1.0, color: secondaryColor),
    //                           borderRadius:
    //                               BorderRadius.all(Radius.circular(8))),
    //                       height: 80,
    //                       child: Center(
    //                           child: Container(
    //                               height: 44,
    //                               width: 44,
    //                               child: SvgPicture.asset(
    //                                 'assets/images/marketplace/Eletronicos.svg',
    //                                 color: secondaryColor,
    //                                 fit: BoxFit.scaleDown,
    //                                 height: 40,
    //                                 width: 40,
    //                               )))),
    //                 ),
    //                 SizedBox(
    //                   height: 4,
    //                 ),
    //                 Text(
    //                   'Eletrônicos',
    //                   style:
    //                       textStyle.copyWith(color: Colors.white, fontSize: 14),
    //                 )
    //               ]),
    //               SizedBox(
    //                 width: 16,
    //               ),
    //               Column(children: [
    //                 InkWell(
    //                   onTap: () {},
    //                   child: Container(
    //                       width: (MediaQuery.of(context).size.width / 3) - 26,
    //                       decoration: BoxDecoration(
    //                           boxShadow: [
    //                             BoxShadow(
    //                               color: Colors.black.withOpacity(0.5),
    //                               offset: Offset(2, 3.0), //(x,y)
    //                               blurRadius: 3.0,
    //                             ),
    //                           ],
    //                           color: primaryColor,
    //                           border:
    //                               Border.all(width: 1.0, color: primaryColor),
    //                           borderRadius:
    //                               BorderRadius.all(Radius.circular(8))),
    //                       height: 80,
    //                       child: Center(
    //                           child: Container(
    //                               height: 44,
    //                               width: 44,
    //                               child: SvgPicture.asset(
    //                                 'assets/images/marketplace/Perifericos.svg',
    //                                 fit: BoxFit.scaleDown,
    //                                 color: secondaryColor,
    //                                 height: 40,
    //                                 width: 40,
    //                               )))),
    //                 ),
    //                 SizedBox(
    //                   height: 4,
    //                 ),
    //                 Text(
    //                   'Periféricos',
    //                   style:
    //                       textStyle.copyWith(color: Colors.white, fontSize: 14),
    //                 )
    //               ]),
    //               SizedBox(
    //                 width: 16,
    //               ),
    //               Column(children: [
    //                 InkWell(
    //                   onTap: () {},
    //                   child: Container(
    //                       width: (MediaQuery.of(context).size.width / 3) - 27,
    //                       decoration: BoxDecoration(
    //                           boxShadow: [
    //                             BoxShadow(
    //                               color: Colors.black.withOpacity(0.5),
    //                               offset: Offset(2, 3.0), //(x,y)
    //                               blurRadius: 3.0,
    //                             ),
    //                           ],
    //                           color: primaryColor,
    //                           border:
    //                               Border.all(width: 1.0, color: primaryColor),
    //                           borderRadius:
    //                               BorderRadius.all(Radius.circular(8))),
    //                       height: 80,
    //                       child: Center(
    //                           child: Container(
    //                               height: 44,
    //                               width: 44,
    //                               child: SvgPicture.asset(
    //                                 'assets/images/marketplace/Roupas.svg',
    //                                 fit: BoxFit.scaleDown,
    //                                 color: secondaryColor,
    //                                 height: 40,
    //                                 width: 40,
    //                               )))),
    //                 ),
    //                 SizedBox(
    //                   height: 4,
    //                 ),
    //                 Text(
    //                   'Roupas',
    //                   style:
    //                       textStyle.copyWith(color: Colors.white, fontSize: 14),
    //                 )
    //               ]),
    //             ],
    //           ),
    //           SizedBox(
    //             height: 20,
    //           ),
    //           Row(
    //             children: [
    //               Column(children: [
    //                 InkWell(
    //                   onTap: () {},
    //                   child: Container(
    //                       width: (MediaQuery.of(context).size.width / 3) - 27,
    //                       decoration: BoxDecoration(
    //                           boxShadow: [
    //                             BoxShadow(
    //                               color: Colors.black.withOpacity(0.5),
    //                               offset: Offset(2, 3.0), //(x,y)
    //                               blurRadius: 3.0,
    //                             ),
    //                           ],
    //                           color: primaryColor,
    //                           border:
    //                               Border.all(width: 1.0, color: primaryColor),
    //                           borderRadius:
    //                               BorderRadius.all(Radius.circular(8))),
    //                       height: 80,
    //                       child: Center(
    //                           child: Container(
    //                               height: 44,
    //                               width: 44,
    //                               child: SvgPicture.asset(
    //                                 'assets/images/marketplace/Cadeiras.svg',
    //                                 fit: BoxFit.scaleDown,
    //                                 color: secondaryColor,
    //                                 height: 40,
    //                                 width: 40,
    //                               )))),
    //                 ),
    //                 SizedBox(
    //                   height: 4,
    //                 ),
    //                 Text(
    //                   'Cadeiras',
    //                   style:
    //                       textStyle.copyWith(color: Colors.white, fontSize: 14),
    //                 )
    //               ]),
    //               SizedBox(
    //                 width: 16,
    //               ),
    //               Column(children: [
    //                 InkWell(
    //                   onTap: () {},
    //                   child: Container(
    //                       width: (MediaQuery.of(context).size.width / 3) - 26,
    //                       decoration: BoxDecoration(
    //                           boxShadow: [
    //                             BoxShadow(
    //                               color: Colors.black.withOpacity(0.5),
    //                               offset: Offset(2, 3.0), //(x,y)
    //                               blurRadius: 3.0,
    //                             ),
    //                           ],
    //                           color: primaryColor,
    //                           border:
    //                               Border.all(width: 1.0, color: primaryColor),
    //                           borderRadius:
    //                               BorderRadius.all(Radius.circular(8))),
    //                       height: 80,
    //                       child: Center(
    //                           child: Container(
    //                               height: 44,
    //                               width: 44,
    //                               child: SvgPicture.asset(
    //                                 'assets/images/marketplace/Gamer.svg',
    //                                 fit: BoxFit.scaleDown,
    //                                 color: secondaryColor,
    //                                 height: 40,
    //                                 width: 40,
    //                               )))),
    //                 ),
    //                 SizedBox(
    //                   height: 4,
    //                 ),
    //                 Text(
    //                   'Seu quarto',
    //                   style:
    //                       textStyle.copyWith(color: Colors.white, fontSize: 14),
    //                 )
    //               ]),
    //               SizedBox(
    //                 width: 16,
    //               ),
    //               Column(children: [
    //                 InkWell(
    //                   onTap: () {},
    //                   child: Container(
    //                       width: (MediaQuery.of(context).size.width / 3) - 27,
    //                       decoration: BoxDecoration(
    //                           boxShadow: [
    //                             BoxShadow(
    //                               color: Colors.black.withOpacity(0.5),
    //                               offset: Offset(2, 3.0), //(x,y)
    //                               blurRadius: 3.0,
    //                             ),
    //                           ],
    //                           color: primaryColor,
    //                           border:
    //                               Border.all(width: 1.0, color: primaryColor),
    //                           borderRadius:
    //                               BorderRadius.all(Radius.circular(8))),
    //                       height: 80,
    //                       child: Center(
    //                           child: Container(
    //                               height: 44,
    //                               width: 44,
    //                               child: SvgPicture.asset(
    //                                 'assets/images/marketplace/Gamer.svg',
    //                                 fit: BoxFit.scaleDown,
    //                                 color: secondaryColor,
    //                                 height: 40,
    //                                 width: 40,
    //                               )))),
    //                 ),
    //                 SizedBox(
    //                   height: 4,
    //                 ),
    //                 Text(
    //                   'Viagem',
    //                   style:
    //                       textStyle.copyWith(color: Colors.white, fontSize: 14),
    //                 )
    //               ]),
    //             ],
    //           ),
    //           SizedBox(
    //             height: 24,
    //           )
    //         ]));
    // child:
  }
}
