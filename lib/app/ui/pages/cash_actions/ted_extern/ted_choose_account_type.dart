import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:cGamer/app/data/models/cash_models/ted_info_model.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/ted_components/account_type_row.dart';

class TedChooseAccountType extends StatefulWidget {
  @override
  _TedChooseAccountTypeState createState() => _TedChooseAccountTypeState();
}

class _TedChooseAccountTypeState extends State<TedChooseAccountType> {
  TedInfoModel tedInfo = TedInfoModel();

  @override
  void initState() {
    tedInfo = Get.arguments["ted_info"];
    super.initState();
  }

  changePage({required String type}) {
    tedInfo.accounType = type;
    Get.toNamed(Routes.TRANSFER_TED_ACCOUNT_INFO,
        arguments: {"ted_info": tedInfo});
  }

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
              customText: "tipo de conta?",
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 32,
            ),
            GestureDetector(
              onTap: () => changePage(
                type: "CHECKING",
              ),
              child: AccountTypeRow(
                txt: "Conta corrente",
              ),
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () => changePage(
                type: "SAVINGS",
              ),
              child: AccountTypeRow(
                txt: "Conta poupança",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
