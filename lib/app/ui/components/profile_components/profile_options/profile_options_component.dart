import 'package:cGamer/app/controllers/profile/profile_controller.dart';
import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/profile_components/big_profile_button.dart';
import 'package:cGamer/app/ui/components/profile_components/profile_button_widget.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileOptionsComponent extends StatelessWidget {
  const ProfileOptionsComponent(
      {Key? key, required ProfileController profileController})
      : _controller = profileController,
        super(key: key);

  final ProfileController _controller;

  _showBottomSheet(BuildContext _context) {
    showModalBottomSheet(
      context: _context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) => Builder(
        builder: (context) =>
            ChooseGameModalBottomSheet(controller: _controller),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
        ),
        child: Column(
          children: [
            SizedBox(
              height: screenHeigthSize * 0.02,
            ),
            // Obx(() => _controller.hasCompletedBedgesRequest.value
            //     ? _controller.badgesAndSelectedGamesHasLoaded()
            //         ? _controller.badgesAreEmpty()
            //             ? SizedBox(
            //                 height: 0,
            //               )
            //             : Column(
            //                 children: [
            //                   SelectedBadgesArea(_controller),
            //                   Divider(
            //                     color: primaryColor,
            //                   )
            //                 ],
            //               )
            //         : SizedBox(
            //             height: 0,
            //           )
            //     : SizedBox()),
            // Obx(() => _controller.hasCompletedBedgesRequest.value
            //     ? _controller.badgesAndSelectedGamesHasLoaded()
            //         ? _controller.badgesAreEmpty()
            //             ? Container(
            //                 margin: EdgeInsets.only(bottom: 12),
            //                 child: BigProfileButton(
            //                   onTap: _controller.goToMyProgress,
            //                   text: "Selecione sua badge",
            //                   size: 30,
            //                   imgSrc:
            //                       "assets/images/gamification_icons/icon_badges.svg",
            //                 ))
            //             : SizedBox()
            //         : SizedBox()
            //     : SizedBox()),
            Padding(
              padding: EdgeInsets.only(left: 24, right: 24, top: 8),
              child: ProfileButton(
                onTap: () => _controller.goToStore(),
                text: "Baixe o App completo na Loja",
                imgSrc: "assets/images/marketplace/Gamer.svg",
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 24, right: 24, top: 8),
              child: ProfileButton(
                onTap: _controller.goAccountDataList,
                text: "Dados da conta",
                imgSrc: "assets/images/profile_images/Dados_do_perfil.svg",
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 24, right: 24, top: 8),
              child: ProfileButton(
                onTap: () => Get.toNamed(Routes.CHANGE_PASSWORD),
                text: "Alterar senha",
                imgSrc: "assets/images/profile_images/Alterar_Senha.svg",
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 24, right: 24, top: 8),
              child: ProfileButton(
                onTap: () => _controller.goToChat(),
                text: "Atendimento",
                imgSrc: "assets/images/profile_images/Ajuda.svg",
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: 24, right: 24, top: 8),
            //   child: ProfileButton(
            //     onTap: () => _controller.goToFAQ(),
            //     text: "Dúvidas frequentes",
            //     imgSrc: "assets/images/profile_images/Duvidas_Frequentes.svg",
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(left: 24, right: 24, top: 8),
              child: ProfileButton(
                onTap: () => _controller.goToLogout(context),
                hasBorder: false,
                text: "Sair",
                imgSrc: "assets/images/profile_images/Sair.svg",
              ),
            ),
            SizedBox(
              height: 12,
            )
          ],
        ),
      ),
      // child:
    );
  }
}
