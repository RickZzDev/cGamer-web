import 'package:cGamer/app/data/repository/coin_wallet_repositories/mafa_last_moviments_model.dart';
import 'package:cGamer/app/ui/components/home_components/last_moviments_component.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MafaExtractPage extends StatelessWidget {
  final LastMafaMovimentsModel lastMafaMovimentsModel;
  MafaExtractPage({
    Key? key,
  })  : lastMafaMovimentsModel = Get.arguments['lastMafaMoviments'],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: secondaryColor,
        appBar: CustomAppBar(
          appBarTxt: 'Extrato \$MAFA',
        ),
        body: ListView.builder(
          padding: EdgeInsets.only(top: 24),
          itemBuilder: (context, index) => LastMovimentsComponent(
            imgSrc: lastMafaMovimentsModel.transactions![index].image,
            title: lastMafaMovimentsModel.transactions![index].title,
            toName: lastMafaMovimentsModel.transactions![index].description,
            date: lastMafaMovimentsModel.transactions![index].date,
            amount: lastMafaMovimentsModel.transactions![index].walletId,
          ),
          itemCount: lastMafaMovimentsModel.transactions!.length,
          shrinkWrap: true,
        ));
  }
}
