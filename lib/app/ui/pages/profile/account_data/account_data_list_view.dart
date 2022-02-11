import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cGamer/app/controllers/profile/account_data/account_data_list_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';

class AccountDataListView extends StatefulWidget {
  @override
  _AccountDataListViewState createState() => _AccountDataListViewState();
}

class _AccountDataListViewState extends State<AccountDataListView> {
  final AccountDataListController _controller =
      Get.find<AccountDataListController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          appBarTxt: "Dados da conta",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomRichText(
                textAlign: TextAlign.start,
                normalText: "Confira abaixo os",
                customText: "dados da sua conta",
              ),
              SizedBox(
                height: 8,
              ),
              CustomRichText(
                normalText: "Mantenha-os sempre atualizados",
                customText: "",
                color: Colors.white70,
                fontSize: 16,
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AccountDataListOption(
                    onTap: () => _controller.goToPersonalData(),
                    controller: _controller,
                    icon: Icons.arrow_forward_ios,
                    title: "Dados pessoais",
                    subtitle: "Nome, e-mail, data de nascimento, CPF, etc",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  AccountDataListOption(
                    onTap: () {
                      Get.toNamed(Routes.ADDRESS_DATA);
                    },
                    controller: _controller,
                    icon: Icons.arrow_forward_ios,
                    title: "Endereço",
                    subtitle: "Local onde reside atualmente",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  AccountDataListOption(
                    onTap: () {
                      Get.toNamed(Routes.PHONE_DATA);
                    },
                    controller: _controller,
                    icon: Icons.arrow_forward_ios,
                    title: "Telefone",
                    subtitle: "Seu número de celular atualizado",
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
