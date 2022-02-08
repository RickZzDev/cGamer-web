import 'package:auto_size_text/auto_size_text.dart';
import 'package:cGamer/app/controllers/clan_controllers/clan_roulette_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/screen_utils.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RoulettePage extends StatefulWidget {
  RoulettePage({Key? key}) : super(key: key);

  @override
  State<RoulettePage> createState() => _RoulettePageState();
}

class _RoulettePageState extends State<RoulettePage> {
  final ClanRouletteController controller = Get.find<ClanRouletteController>();

  @override
  void initState() {
    ScreenUtils.changeSystemColors(statusBarColor: secondaryColor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          appBarTxt: 'Rode a roleta',
        ),
      ),
      body: Obx(() => controller.isLoading
          ? ModalProgressHUD(
              inAsyncCall: controller.loading.value,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(top: 24),
                        height: screenHeigthSize * 0.5,
                        child: Stack(
                          children: [
                            Obx(() => FortuneWheel(
                                  indicators: const [
                                    FortuneIndicator(
                                      alignment: Alignment.topCenter,
                                      child: TriangleIndicator(
                                        color: Colors.tealAccent,
                                      ),
                                    )
                                  ],
                                  animateFirst: false,
                                  items: List.generate(
                                      controller.model.value.values.length,
                                      (index) => FortuneItem(
                                          child: Center(
                                              child: Container(
                                                  width: 24,
                                                  transform:
                                                      new Matrix4.identity()
                                                        ..rotateZ(90 *
                                                            3.1415927 /
                                                            180),
                                                  child: Text(
                                                      controller.model.value
                                                          .values[index]
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: textStyle.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20)))))),
                                  onAnimationStart: controller.animationStarted,
                                  onAnimationEnd: controller.animationEnded,
                                  selected: controller.output,
                                )),
                            Center(
                                child: PlayComponent(
                              onTap: controller.spinRoulette,
                            ))
                          ],
                        )),
                    Container(
                        width: screenWidthhSize,
                        height: 120,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        margin: EdgeInsets.all(16),
                        child: Material(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          elevation: 8,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 16,
                              ),
                              SizedBox(
                                  width: 70,
                                  height: 70,
                                  child: Image.asset(
                                      'assets/images/cla_images/fadinha.png')),
                              SizedBox(
                                width: 12,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Fadinha do Jogga:',
                                    style: textStyle.copyWith(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    'Oi Gamer, quer dobrar os troféus?',
                                    style: textStyle.copyWith(
                                        color: secondaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    'Ative abaixo antes de jogar!',
                                    style: textStyle.copyWith(
                                        color: secondaryColor, fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Obx(() => GenericButton(
                                      text: 'Ativar',
                                      color: primaryColor,
                                      height: 40,
                                      enabled: controller
                                          .btnDuplicateIsEnabled.value,
                                      txtColor: Colors.white,
                                      onPressedFunction:
                                          controller.multiplyValue,
                                      rightIcon: Row(
                                        children: [
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Image.asset(
                                            'assets/images/gamification_icons/cristal.png',
                                            height: 18,
                                            width: 18,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            controller
                                                .model.value.pointsForDuplicate
                                                .toString(),
                                            style: textStyle,
                                          )
                                        ],
                                      )))
                                ],
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ))
          : ModalProgressHUD(inAsyncCall: true, child: SizedBox())),
      // bottomNavigationBar: Obx(() => controller.isLoading
      //     ? Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 16),
      //         child: GenericButton(
      //             text: 'Comprar',
      //             color: primaryColor,
      //             onPressedFunction: controller.multiplyValue,
      //             rightIcon: Row(
      //               children: [
      //                 SizedBox(
      //                   width: 12,
      //                 ),
      //                 Image.asset(
      //                   'assets/images/gamification_icons/cristal.png',
      //                   height: 18,
      //                   width: 18,
      //                 ),
      //                 SizedBox(
      //                   width: 4,
      //                 ),
      //                 Text(
      //                   '20',
      //                   style: textStyle,
      //                 )
      //               ],
      //             )),
      //       )
      //     : SizedBox()),
    );
  }
}
