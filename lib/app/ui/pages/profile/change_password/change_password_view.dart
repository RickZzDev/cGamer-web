import 'package:cGamer/app/controllers/profile/change_password/old_password_controller.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/generic_button.dart';
import 'package:cGamer/app/ui/components/generic_components/inputs/textfield_component.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final OldPasswordController _controller = Get.find<OldPasswordController>();
  var formKey;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          appBarTxt: "Alterar Senha",
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontSize: 16.0, color: Colors.white, fontFamily: 'Exo'),
                    children: <TextSpan>[
                      TextSpan(text: 'Digite sua'),
                      TextSpan(
                          text: ' senha atual',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16, bottom: 16),
                  child: Form(
                    key: formKey,
                    child: CustomTextField(
                      controller: _controller.oldPasswordController,
                      validation: _controller.validateOldPassword,
                      validateMode: AutovalidateMode.onUserInteraction,
                      labelText: "Senha",
                      type: TextInputType.visiblePassword,
                      obscureText: true,
                      autoFocus: true,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: GenericButton(
                          text: "Avançar",
                          haveToReturnContext: false,
                          onPressedFunction: () => _controller
                                  .validateAllForm(formKey)
                              ? _controller.changePage()
                              : SnackBarUtils.showSnackBar(
                                  title: "Atenção",
                                  desc:
                                      "Por favor preencha corretamente sua senha."),
                          txtColor: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
