import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:cGamer/app/controllers/login/login_controller.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/generic_button.dart';
import 'package:cGamer/app/ui/components/generic_components/inputs/textfield_component.dart';

class ModalBottomSheetLogin extends StatefulWidget {
  final LoginController loginController;
  final String action;
  final bool loading;
  ModalBottomSheetLogin(
      {required this.loginController,
      this.action = "login_password",
      this.loading = false});
  @override
  _ModalBottomSheetLoginState createState() => _ModalBottomSheetLoginState();
}

class _ModalBottomSheetLoginState extends State<ModalBottomSheetLogin>
    with TickerProviderStateMixin {
  AnimationController? rotationController;
  Animation<double>? _animation;

  @override
  void initState() {
    widget.loginController.buildContext = context;
    rotationController = AnimationController(
        duration: const Duration(milliseconds: 250),
        vsync: this,
        value: 0.75,
        lowerBound: 0.75,
        upperBound: 1.0);
    _animation =
        CurvedAnimation(parent: rotationController!, curve: Curves.linear);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setModalState) {
        void changeIconDirection() {
          widget.loginController.index.value == 0
              ? rotationController?.reverse()
              : rotationController?.forward();
        }

        return ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Scaffold(
              backgroundColor: secondaryColor,
              resizeToAvoidBottomInset: false,
              body: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: ModalProgressHUD(
                  inAsyncCall: widget.loading,
                  progressIndicator: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(24),
                    height: MediaQuery.of(context).size.height * 0.6,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                        color: Theme.of(context).accentColor),
                    child: Obx(
                      () {
                        if (widget.action == "only_password") {
                        } else {
                          widget.loginController.index.value > 0
                              ? changeIconDirection()
                              : DoNothingAction();
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RotationTransition(
                              turns: _animation!,
                              child: IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                iconSize: 20,
                                color: Colors.white,
                                onPressed: () {
                                  if (widget.loginController.index.value == 0 ||
                                      widget.action == "only_password") {
                                    widget.loginController.cpfController
                                        .clear();
                                    widget.loginController.passwordController
                                        .clear();
                                    Navigator.pop(context);
                                  } else {
                                    widget.loginController.goBackModal(
                                        widget.loginController.index.value - 1);
                                    changeIconDirection();
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 0),
                              child: Form(
                                key: widget.loginController.formKey,
                                child: AnimatedSwitcher(
                                  duration: Duration(milliseconds: 450),
                                  transitionBuilder: (Widget child,
                                      Animation<double> animation) {
                                    return ScaleTransition(
                                      scale: animation,
                                      child: child,
                                    );
                                  },
                                  child: widget.loginController.index.value ==
                                              0 &&
                                          widget.action != "only_password"
                                      ? CustomTextField(
                                          controller: widget
                                              .loginController.cpfController,
                                          loginController:
                                              widget.loginController,
                                          labelText: "Digite seu CPF",
                                          validateMode: AutovalidateMode
                                              .onUserInteraction,
                                          isLoginCpfField: true,
                                          validation: Validations().validateCpf,
                                          type: TextInputType.number,
                                          key: ValueKey(1),
                                          autoFocus: true,
                                        )
                                      : widget.action == "only_password" ||
                                              widget.loginController.index
                                                      .value >
                                                  0
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              key: ValueKey(2),
                                              children: [
                                                CustomTextField(
                                                  autoFocus: true,
                                                  controller: widget
                                                      .loginController
                                                      .passwordController,
                                                  validation: widget
                                                      .loginController
                                                      .validatePassword,
                                                  labelText: "Digite sua senha",
                                                  onFieldSubmitted: (_) =>
                                                      widget.loginController
                                                          .auth(),
                                                  loginController:
                                                      widget.loginController,
                                                  key: ValueKey(3),
                                                  onChange: widget
                                                      .loginController
                                                      .clearErrorAfterTexting,
                                                  validateMode: AutovalidateMode
                                                      .onUserInteraction,
                                                  obscureText: true,
                                                ),
                                                GestureDetector(
                                                  onTap: () => Get.toNamed(
                                                      Routes.RETRIVE_PASSWORD),
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8),
                                                    margin: EdgeInsets.only(
                                                        top: 12, bottom: 20),
                                                    child: Text(
                                                      "Esqueceu sua senha?",
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                    ),
                                                  ),
                                                ),
                                                GenericButton(
                                                  text: "Entrar",
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  txtColor: Colors.white,
                                                  icon: Icons.check,

                                                  // haveToReturnContext: true,
                                                  onPressedFunction: () => widget
                                                              .loginController
                                                              .formKey
                                                              .currentState
                                                              ?.validate() ??
                                                          false
                                                      ? widget.loginController
                                                          .auth()
                                                      : {},
                                                )
                                              ],
                                            )
                                          : SizedBox(),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
