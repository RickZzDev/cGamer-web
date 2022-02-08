import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cGamer/app/controllers/cash_actions_controllers/cash_ted/ted_choose_bank_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:shimmer/shimmer.dart';

class ChooseBankView extends StatelessWidget {
  final ChooseBankController _controller = Get.find<ChooseBankController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: utils.secondaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          appBarTxt: "Transferir",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomRichText(
              normalText: "Qual o",
              customText: "banco?",
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 16,
            ),
            CustomTextField(
              labelText: "Pesquisar banco",
              autoFocus: false,
              onChange: _controller.filter,
            ),
            SizedBox(
              height: 32,
            ),
            Expanded(
              child: FutureBuilder(
                future: _controller.httpResponse,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done)
                    return Obx(
                      () => ListView.separated(
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () => _controller.changeSelected(
                              _controller.banks.value.banks?[index].name ?? "",
                              _controller.banks.value.banks?[index].bankCode
                                      .toString() ??
                                  ""),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 100),
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.only(right: 4),
                            decoration: BoxDecoration(
                              color: _controller.defineColor(index),
                              // border: Border.all(),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: Offset(2, 2.0), //(x,y)
                                  blurRadius: 2.0,
                                ),
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    child: Text(
                                  " ${_controller.banks.value.banks?[index].bankCode} - ${_controller.banks.value.banks?[index].name != null ? utf8.decode(_controller.banks.value.banks![index].name!.codeUnits) : ""}",
                                  style: utils.textStyle.copyWith(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                )),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 12,
                        ),
                        itemCount: _controller.banks.value.banks?.length ?? 0,
                      ),
                    );
                  else
                    // return SizedBox();
                    return ListView.separated(
                      itemBuilder: (context, index) => Shimmer.fromColors(
                        baseColor: Theme.of(context).accentColor,
                        highlightColor: Colors.blueGrey[400],
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: utils.secondaryColor,
                            // border: Border.all(),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                offset: Offset(2, 2.0), //(x,y)
                                blurRadius: 2.0,
                              ),
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                " ",
                                style: utils.textStyle.copyWith(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 8,
                      ),
                      itemCount: 8,
                    );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
