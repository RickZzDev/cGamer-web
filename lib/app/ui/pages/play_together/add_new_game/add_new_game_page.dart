import 'package:cGamer/app/controllers/play_together_controllers/add_game_controller/add_game_controller.dart';
import 'package:cGamer/app/data/models/play_together_models/add_game_confirmations_model.dart';
import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AddNewGamePage extends StatelessWidget {
  AddNewGamePage({Key? key}) : super(key: key);
  final AddGameController controller = Get.find<AddGameController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
        inAsyncCall: controller.loading.value,
        child: Scaffold(
            backgroundColor: secondaryColor,
            appBar: PreferredSize(
                child: CustomAppBar(
                  appBarTxt: "Adicionar jogo",
                ),
                preferredSize: Size.fromHeight(60)),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
                child: Column(
                  children: [
                    CustomTextField(
                      onChange: controller.filter,
                      controller: controller.searchController,
                      labelText: "Procurar um jogo",
                      autoFocus: false,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(() => GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.filteredItems.length,

                          // controller.filteredItems.value.length != 0
                          //     ? controller.filteredItems.value.length
                          //     : controller.model.value.games?.length ?? 0,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, mainAxisSpacing: 20),

                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.ADD_NEW_GAME_CONFIRMATION,
                                    arguments: new AddGameConfirmationModel(
                                        addGameModel:
                                            controller.filteredItems[index],
                                        isGameCadaster: true));
                              },
                              child: Stack(children: [
                                Container(
                                    height: (screenWidthhSize / 4) + 24,
                                    child: Column(children: [
                                      Container(
                                        height: (screenWidthhSize / 4) - 9,
                                        width: screenWidthhSize / 4,
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10),
                                        decoration: BoxDecoration(
                                            color: secondaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: primaryColor)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            controller.filteredItems
                                                    .value[index].image ??
                                                "",
                                            // controller.filteredItems.value.length != 0
                                            //     ? controller.filteredItems.value[index]
                                            //             .image ??
                                            //         ""
                                            //     : controller.model.value.games?[index]
                                            //             .image ??
                                            //         "",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Container(
                                          width: screenWidthhSize / 4,
                                          child: Text(
                                            controller.filteredItems
                                                    .value[index].title ??
                                                "",
                                            textAlign: TextAlign.center,
                                            style: textStyle.copyWith(
                                                fontSize: 12),
                                          )),
                                    ])),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    height: 32,
                                    width: 32,
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Icon(
                                      Icons.add,
                                      color: secondaryColor,
                                      size: 24,
                                    ),
                                  ),
                                )
                              ]),
                            );
                          },
                        )),
                  ],
                ),
              ),
            ))));
  }
}
