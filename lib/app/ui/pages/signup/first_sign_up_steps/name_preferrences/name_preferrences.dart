import 'package:cGamer/app/controllers/signup/fisrt_register/signup_name_preferences.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/generic_button.dart';
import 'package:cGamer/app/ui/components/generic_components/inputs/textfield_component.dart';
import 'package:cGamer/app/ui/components/generic_components/rich_text/rich_text.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NamePreferrencesPage extends StatefulWidget {
  @override
  _NamePreferrencesPageState createState() => _NamePreferrencesPageState();
}

class _NamePreferrencesPageState extends State<NamePreferrencesPage> {
  final NamePreferrencesController _controller =
      Get.find<NamePreferrencesController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).accentColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: CustomAppBar(
              appBarTxt: "Dados pessoais",
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomRichText(
                    normalText: "Como", customText: "podemos chamar você?"),
                Container(
                  margin: EdgeInsets.only(top: 8, bottom: 8),
                  child: Text(
                    "Nós do Jogga Bank queremos que você fique à vontade. Utilizaremos essa forma para nos comunicar de forma oficial",
                    style: TextStyle(
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                Theme(
                  data: ThemeData(
                      unselectedWidgetColor: Theme.of(context).primaryColor),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 24, top: 8),
                    child: Row(
                      children: [
                        Obx(
                          () => Container(
                            width: 25,
                            height: 25,
                            child: Radio(
                              onChanged: (value) {
                                _controller.setSelecteValue(
                                    int.parse(value.toString()));
                              },
                              groupValue: _controller.selectedValue.value,
                              value: 1,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              focusColor: Theme.of(context).primaryColor,
                              hoverColor: Theme.of(context).primaryColor,
                              activeColor: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            "Usar nome do documento de identificação ",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Theme(
                  data: ThemeData(
                      unselectedWidgetColor: Theme.of(context).primaryColor),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Obx(
                          () => Container(
                            // color: Colors.red,
                            height: 25,
                            width: 25,
                            child: Radio(
                              onChanged: (value) {
                                _controller.setSelecteValue(
                                    int.parse(value.toString()));
                              },
                              groupValue: _controller.selectedValue.value,
                              value: 2,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              focusColor: Theme.of(context).primaryColor,
                              hoverColor: Theme.of(context).primaryColor,
                              activeColor: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Quero escolher outro nome",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
                Obx(
                  () {
                    double _opacity =
                        _controller.selectedValue.value == 2 ? 1 : 0;
                    return Container(
                      margin: EdgeInsets.only(left: 24, right: 24),
                      child: Visibility(
                        visible: _opacity == 1 ? true : false,
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 500),
                          opacity: _opacity,
                          child: Form(
                            key: _controller.formKey,
                            child: CustomTextField(
                              controller: _controller.nameController,
                              validation: _controller.validateNick,
                              textCapitalization: TextCapitalization.words,
                              labelText: "Como você prefere?",
                              validateMode: AutovalidateMode.onUserInteraction,
                              autoFocus: false,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Expanded(
                  child: Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: GenericButton(
                        text: "Avançar",
                        haveToReturnContext: false,
                        onPressedFunction: () => _controller.validateAllForm()
                            ? _controller.changePage()
                            : null,
                        txtColor: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
