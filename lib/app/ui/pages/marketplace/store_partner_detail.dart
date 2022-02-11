import 'package:cGamer/app/controllers/marketplace/store_partner_detail_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/generic_utils.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:get/get.dart';

class StorePartnerDetail extends StatelessWidget {
  final StorePartnerDetailController _controller =
      Get.find<StorePartnerDetailController>();

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(secondaryColor);
    return Scaffold(
      backgroundColor: secondaryColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            // title: Text("SLIVER"),
            expandedHeight: 180,
            flexibleSpace: Padding(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: SizedBox(
                    width: screenWidthhSize,
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        child: CachedNetworkImage(
                            imageUrl: _controller.storeCollection?.image ?? "",
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(
                                  Icons.error,
                                  color: primaryColor,
                                ),
                            width: screenWidthhSize,
                            cacheKey: _controller.storeCollection?.image ?? "",
                            useOldImageOnUrlChange: true,
                            fit: BoxFit.cover)))),
            floating: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Compre através do nosso parceiro ${_controller.storeCollection?.name} para concorrer a vários prêmios.",
                        style: textStyle.copyWith(
                          fontSize: 16,
                        )),
                    SizedBox(
                      height: 16,
                    ),
                    Divider(
                      height: 1,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text("Como funciona?",
                        style: textStyle.copyWith(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: Center(
                              child: Text("1",
                                  textAlign: TextAlign.center,
                                  style: textStyle.copyWith(
                                      color: secondaryColor,
                                      fontWeight: FontWeight.bold))),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Flexible(
                            child: Text(
                                "Clique no botão abaixo para ir para a loja do nosso parceiro.",
                                style: textStyle.copyWith(fontSize: 15))),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: Center(
                              child: Text("2",
                                  textAlign: TextAlign.center,
                                  style: textStyle.copyWith(
                                      color: secondaryColor,
                                      fontWeight: FontWeight.bold))),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Flexible(
                            child: Text(
                                "Faça suas compras pela tela que abrirá pelo app para manter válido sua participação nos sorteios.",
                                style: textStyle.copyWith(fontSize: 15))),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: Center(
                              child: Text("3",
                                  textAlign: TextAlign.center,
                                  style: textStyle.copyWith(
                                      color: secondaryColor,
                                      fontWeight: FontWeight.bold))),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Flexible(
                            child: Text(
                                "Após o parceiro confirmar a compra para nós, você automaticamente estará participando dos nossos sorteios.",
                                style: textStyle.copyWith(fontSize: 15))),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: Center(
                              child: Text("4",
                                  textAlign: TextAlign.center,
                                  style: textStyle.copyWith(
                                      color: secondaryColor,
                                      fontWeight: FontWeight.bold))),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Flexible(
                            child: Text(
                                "O resultado dos vencedores chegará no seu e-mail, boas compras!",
                                style: textStyle.copyWith(fontSize: 15))),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Divider(
                      height: 1,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Center(
                        child: GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.MARKETPLACE_CONFIRM_TERMS_USE,
                                  arguments: {
                                    "terms_use":
                                        "Todos os detalhes da compra, como entrega e devolução, devem ser tratados diretamente com o parceiro, não nos responsabilizamos por eventuais problemas."
                                  });
                            },
                            child: Text('Termos e condições',
                                style: textStyle.copyWith(
                                    fontSize: 16,
                                    color: Colors.white70,
                                    decoration: TextDecoration.underline)))),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GenericButton(
                            text: "Ativar link e ir para loja",
                            onPressedFunction: () => GenericUtils.openUrl(
                                _controller.storeCollection?.url ?? ""),
                            color: primaryColor,
                            txtColor: Colors.white,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              childCount: 1,
            ),
          )

          // Container(
          //   // height: screenHeigthSize,
          //   padding: EdgeInsets.all(24),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          // Text(
          //   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed malesuada non nulla venenatis hendrerit. Nulla eget vehicula velit, eu tincidunt lacus. Proin rhoncus, quam id euismod rhoncus, libero risus varius velit, et semper augue quam vitae mi. Aliquam a cursus mauris, eget suscipit sem. Ut id pellentesque dui. Quisque rutrum tempus risus, volutpat egestas mi fermentum a. Mauris et ornare ante.",
          //   style: textStyle,
          // ),

          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
