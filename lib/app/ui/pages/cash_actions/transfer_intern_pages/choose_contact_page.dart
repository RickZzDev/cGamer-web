import 'package:cGamer/app/controllers/cash_actions_controllers/transfer_intern_controllers/choose_contact_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ChooseContactTransfer extends StatelessWidget {
  final ChooseContactController _controller =
      Get.find<ChooseContactController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: _controller.inAssyncCall.value,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: utils.primaryColor,
        ),
        child: Scaffold(
          backgroundColor: utils.secondaryColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: CustomAppBar(
              appBarTxt: "Transferir",
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 24,
                top: 24,
                bottom: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: CustomRichText(
                      normalText: "Como deseja fazer a",
                      customText: "transferência?",
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Escolha a forma que deseja utilizar",
                    style: utils.textStyle.copyWith(fontSize: 14),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: Container(
                        // color: Colors.red,
                        height: 80,
                        child: _controller.defineOptionsWidget()),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Contatos frequentes",
                    style: utils.textStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FutureBuilder(
                    future: _controller.htppResponse,
                    builder: (context, snapshot) {
                      return _controller.defineWidgetToDisplay(snapshot);
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: CustomTextField(
                      controller: _controller.searchText,
                      onChange: _controller.filterContacts,
                      labelText: "Pesquisar contato",
                      autoFocus: false,
                      sufixIcon: Icon(Icons.search_outlined),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  FutureBuilder(
                    future: _controller.htppResponse,
                    builder: (context, snapshot) {
                      return _controller.defineWidgetContactList(snapshot);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
