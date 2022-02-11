import 'package:cGamer/app/controllers/signup/validate_docs/choose_doc_type_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/singup_components/docs_validate_components/doc_type_component.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseDocTypeView extends StatelessWidget {
  final ChooseDocTypeController _controller =
      Get.find<ChooseDocTypeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          appBarTxt: "Validação de documentos",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomRichText(
                textAlign: TextAlign.start,
                normalText: "Chegou a hora mandar uma foto do",
                customText: "seu documento",
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "É necessário a validação do seu RG ou CNH para que você possa utilizar mais serviços e garantirmos a sua segurança",
                style: textStyle.copyWith(fontSize: 15, color: Colors.grey),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    Obx(
                      () => GestureDetector(
                        onTap: () => _controller.clickDoc("RG"),
                        child: DocTypeCard(
                          controller: _controller,
                          color: _controller.colorRG.value,
                          docType: 'rg',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "RG",
                      style: textStyle,
                    ),
                  ]),
                  Text(
                    "OU",
                    style: textStyle,
                  ),
                  Column(children: [
                    Obx(
                      () => GestureDetector(
                        onTap: () => _controller.clickDoc("CNH"),
                        child: DocTypeCard(
                          controller: _controller,
                          color: _controller.colorCNH.value,
                          docType: 'cnh',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "CNH",
                      style: textStyle,
                    ),
                  ]),
                ],
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GenericButton(
                          text: "Avançar",
                          haveToReturnContext: false,
                          onPressedFunction: () => _controller.changepage(),
                          txtColor: Colors.white),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
