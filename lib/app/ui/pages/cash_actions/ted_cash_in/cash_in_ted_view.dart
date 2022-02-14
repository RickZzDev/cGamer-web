import 'package:cGamer/app/controllers/cash_actions_controllers/cash_ted/ted_cash_in_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/generic_utils/verify_future_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CashInTedView extends StatelessWidget {
  final CashInTedController _controller = Get.find<CashInTedController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          appBarTxt: "Depósito",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomRichText(
                  textAlign: TextAlign.start,
                  normalText: "Para realizar uma TED, utilize",
                  customText: "os dados de sua conta abaixo",
                ),
                Obx(() {
                  return Container(
                    padding: EdgeInsets.only(top: 40, bottom: 0),
                    child: FutureBuilder(
                      future: Future.wait([
                        _controller.hasCompletedBankAccountRequest.value,
                      ]),
                      builder:
                          (context, AsyncSnapshot<List<dynamic>> snapshot) {
                        if (_controller.allComplete.value == true) {
                          return CashInTedDataHeader(
                            controller: _controller,
                            profileStats:
                                _controller.statusBankAccountResult.value,
                          );
                        } else if (FutureUtils.verifyFutureState(
                            snapshot, _controller.allComplete)) {
                          return CashInTedDataHeader(
                            controller: _controller,
                            profileStats:
                                _controller.statusBankAccountResult.value,
                          );
                        }
                        return CashInTedDataShimmer();
                      },
                    ),
                  );
                })
              ]),
        ),
      ),
    );
  }
}
