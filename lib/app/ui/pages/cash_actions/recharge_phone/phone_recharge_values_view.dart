import 'package:cGamer/app/controllers/recharge_phone/phone_recharge_values_controller%20.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PhoneRechargeValuesView extends StatefulWidget {
  @override
  _PhoneRechargeValuesViewState createState() =>
      _PhoneRechargeValuesViewState();
}

class _PhoneRechargeValuesViewState extends State<PhoneRechargeValuesView> {
  final PhoneRechargeValuesController _controller =
      Get.find<PhoneRechargeValuesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: utils.secondaryColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: CustomAppBar(
            appBarTxt: "Recarga de celular",
          ),
        ),
        body: Obx(
          () => ModalProgressHUD(
            progressIndicator: CircularProgressIndicator(
              backgroundColor: utils.primaryColor,
            ),
            inAsyncCall: _controller.loading.value,
            child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: CustomRichText(
                          normalText: "Qual o",
                          customText: "valor da recarga?",
                          textAlign: TextAlign.start,
                        )),
                    Padding(
                        padding: EdgeInsets.only(bottom: 24),
                        child: Obx(
                            () => _controller.hasCompletedBalanceRequest.value
                                ? CustomRichText(
                                    normalText: "Seu saldo",
                                    customText:
                                        "${_controller.balanceModel.balanceAvailable?.available}",
                                    textAlign: TextAlign.start,
                                  )
                                : Container())),
                    Obx(
                      () => _controller.hasCompletedValuesRequest.value
                          ? Expanded(
                              child: Container(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        _controller.setSelecteValue(index);
                                      },
                                      child: Column(children: [
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(children: [
                                                Obx(() => Theme(
                                                    data: Theme.of(context)
                                                        .copyWith(
                                                            unselectedWidgetColor:
                                                                Colors.white70,
                                                            disabledColor:
                                                                Colors.white70),
                                                    child: Transform.scale(
                                                        scale: 1.4,
                                                        child: Radio(
                                                          onChanged: (value) {
                                                            _controller.setSelecteValue(
                                                                int.parse(value
                                                                    .toString()));
                                                          },
                                                          groupValue:
                                                              _controller
                                                                  .selectedValue
                                                                  .value,
                                                          value: index,
                                                          materialTapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          focusColor:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          hoverColor:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          activeColor:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        )))),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Obx(() => Text(
                                                      '${_controller.values.value.values?[index].ammountFormatted}',
                                                      style: utils.textStyle
                                                          .copyWith(
                                                              fontSize: 18),
                                                    ))
                                              ]),
                                            ]),
                                        SizedBox(
                                          height: 12,
                                        ),
                                      ])),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 0),
                                  itemCount:
                                      _controller.values.value.values?.length ??
                                          0,
                                ),
                              ),
                            )
                          : Container(),
                    ),
                    SizedBox(height: utils.screenHeigthSize * 0.05),
                    Container(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: GenericButton(
                          text: "Avançar",
                          haveToReturnContext: false,
                          onPressedFunction: () => _controller
                                  .hasBalanceToRecharge()
                              ? _controller.changePage()
                              : SnackBarUtils.showSnackBar(
                                  desc:
                                      "Você não possui saldo suficiente para fazer essa recarga.",
                                  title: "Atenção"),
                          txtColor: Colors.white,
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ));
  }
}
