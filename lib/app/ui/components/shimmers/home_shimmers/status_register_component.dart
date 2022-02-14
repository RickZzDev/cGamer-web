import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/home_components/benefits_card.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class StatusRegisterComponent extends StatelessWidget {
  const StatusRegisterComponent({required HomeController homeController})
      : _controller = homeController;

  final HomeController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Status do seu cadastro ${_controller.textPorcentage()}",
              style: textStyle.copyWith(
                  fontSize: 14,
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  Obx(() {
                    _controller.barWidth();
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      width: MediaQuery.of(context).size.width *
                          _controller.barWidth(),
                      height: 10,
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: CompleteDataCard(
                    onTapFunction:
                        _controller.statusRegisterResult.value.statusBanlky ==
                                "REPROVED"
                            ? () => Get.toNamed(Routes.ACCOUNT_DATA_LIST)
                            : _controller.statusRegisterResult.value
                                    .hasCompleteRegistration
                                ? _controller.statusRegisterResult.value
                                        .hasSendDocumentation
                                    ? () => SnackBarUtils.showSnackBar(
                                          title: "Atenção",
                                          desc:
                                              "Aguarde a conclusão da análise para liberarmos sua conta.",
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(1),
                                        )
                                    : () => SnackBarUtils.showSnackBar(
                                          title: "Atenção",
                                          desc:
                                              "Você já completou seus dados, agora valide seus documentos",
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(1),
                                        )
                                : () => Get.toNamed(Routes.SIGNUP_USERNAME),
                    normalTxt:
                        _controller.statusRegisterResult.value.statusBanlky ==
                                "REPROVED"
                            ? "Verifique os"
                            : "Complete seus",
                    boldedTxt:
                        _controller.statusRegisterResult.value.statusBanlky ==
                                "REPROVED"
                            ? "seus dados"
                            : " dados",
                    waiting: _controller.statusRegisterResult.value
                            .hasCompleteRegistration &&
                        _controller.statusRegisterResult.value.statusBanlky !=
                            "REPROVED",
                    reproved:
                        _controller.statusRegisterResult.value.statusBanlky ==
                            "REPROVED",
                    ptsTxt:
                        _controller.statusRegisterResult.value.statusBanlky ==
                                "REPROVED"
                            ? "Não aprovado"
                            : _controller.statusRegisterResult.value
                                    .hasCompleteRegistration
                                ? "Em análise"
                                : "+50",
                    widget: _controller.statusRegisterResult.value
                                .hasCompleteRegistration &&
                            _controller
                                    .statusRegisterResult.value.statusBanlky !=
                                "REPROVED"
                        ? Icon(
                            Icons.timer,
                            size: 38,
                            color: _controller.statusRegisterResult.value
                                    .hasCompleteRegistration
                                ? Colors.amberAccent
                                : Theme.of(context).primaryColor,
                          )
                        : SvgPicture.asset(
                            'assets/images/home_images/Complete_seus_dados.svg',
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
                CompleteDataCard(
                  onTapFunction: _controller
                          .statusRegisterResult.value.hasCompleteRegistration
                      ? _controller
                              .statusRegisterResult.value.hasSendDocumentation
                          ? () => SnackBarUtils.showSnackBar(
                                title: "Atenção",
                                desc:
                                    "Aguarde a conclusão da análise para liberarmos sua conta.",
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(1),
                              )
                          : () => Get.toNamed(Routes.VALIDATE_DOCS_CHOSSE_TYPE)
                      : _controller.statusRegisterResult.value.statusBanlky ==
                              "REPROVED"
                          ? () => Get.toNamed(Routes.VALIDATE_DOCS_CHOSSE_TYPE)
                          : () => SnackBarUtils.showSnackBar(
                                title: "Atenção",
                                desc:
                                    "Por favor, complete seus dados antes de validar seus documentos",
                                color: Colors.orange[400]!,
                              ),
                  status: _controller
                      .statusRegisterResult.value.hasCompleteRegistration,
                  normalTxt:
                      _controller.statusRegisterResult.value.statusBanlky ==
                              "REPROVED"
                          ? "Reenvie seus"
                          : "Valide seu",
                  boldedTxt:
                      _controller.statusRegisterResult.value.statusBanlky ==
                              "REPROVED"
                          ? "documentos"
                          : " documento",
                  waiting: _controller
                      .statusRegisterResult.value.hasSendDocumentation,
                  reproved:
                      _controller.statusRegisterResult.value.statusBanlky ==
                          "REPROVED",
                  ptsTxt: _controller
                          .statusRegisterResult.value.hasSendDocumentation
                      ? "Em análise"
                      : _controller.statusRegisterResult.value.statusBanlky ==
                              "REPROVED"
                          ? "Não aprovado"
                          : "+150",
                  widget: _controller
                          .statusRegisterResult.value.hasSendDocumentation
                      ? Icon(
                          Icons.timer,
                          size: 38,
                          color: _controller.statusRegisterResult.value
                                  .hasCompleteRegistration
                              ? Colors.amberAccent
                              : Theme.of(context).primaryColor,
                        )
                      : SvgPicture.asset(
                          'assets/images/home_images/Valide_seu_documento.svg',
                          color: _controller.statusRegisterResult.value
                                      .hasCompleteRegistration ||
                                  _controller.statusRegisterResult.value
                                          .statusBanlky ==
                                      "REPROVED"
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).accentColor,
                          fit: BoxFit.contain,
                        ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: RichText(
              text: TextSpan(
                style: textStyle.copyWith(
                    fontSize: 14, color: Theme.of(context).accentColor),
                children: <TextSpan>[
                  TextSpan(text: "Confira os "),
                  TextSpan(
                    text: "benefícios ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: "a serem "),
                  TextSpan(
                    text: "desbloqueados",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BenefitsCard(
                  imgName: 'Ag_e_conta',
                  txt: "Agência\ne conta",
                ),
                BenefitsCard(
                  imgName: 'Servicos_financeiros',
                  txt: "Serviços\nfinanceiros",
                ),
                BenefitsCard(
                  imgName: 'Game_store',
                  txt: "Gamer\nStore",
                ),
                BenefitsCard(
                  imgName: 'Missoes',
                  txt: "Missões\ne níveis",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
