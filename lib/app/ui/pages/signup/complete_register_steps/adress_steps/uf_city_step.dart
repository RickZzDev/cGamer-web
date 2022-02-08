import 'package:cGamer/app/data/models/complete_register/complete_register_payload.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/controllers/signup/complete_register/uf_city_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/generic_components/inputs/dropdown_component.dart';

class UfCityStepPage extends StatefulWidget {
  @override
  _UfCityStepPageState createState() => _UfCityStepPageState();
}

class _UfCityStepPageState extends State<UfCityStepPage> {
  final UfCityController _controller = Get.find<UfCityController>();

  @override
  Widget build(BuildContext context) {
    CompleteRegisterPayload _payload = Get.arguments["payload"];
    return ModalProgressHUD(
      inAsyncCall: _controller.validatingCep.value,
      progressIndicator: CircularProgressIndicator(
        backgroundColor: Theme.of(context).primaryColor,
      ), // color: ,
      color: Colors.black,

      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: CustomAppBar(
            appBarTxt: "Endereço",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(
                      fontSize: 18.0, color: Colors.white, fontFamily: 'Exo'),
                  children: <TextSpan>[
                    TextSpan(text: "Qual "),
                    TextSpan(
                      text: "estado ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: "e "),
                    TextSpan(
                      text: "cidade",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: " você mora?"),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: DropdownComponent(
                        value: null,
                        onChangeFunction: () {},
                        items: [],
                        hasPreviousValue: true,
                        txt: _payload.address?.uf),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: DropdownComponent(
                        value: null,
                        onChangeFunction: () {},
                        items: [],
                        hasPreviousValue: true,
                        txt: _payload.address?.city),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GenericButton(
                        text: "Avançar",
                        haveToReturnContext: false,
                        onPressedFunction: () => Get.toNamed(
                            Routes.SINGUP_PHONE_STEP,
                            arguments: {"payload": _payload}),
                        txtColor: Colors.white),
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
