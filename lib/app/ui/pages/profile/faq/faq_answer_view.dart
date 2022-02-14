import 'package:cGamer/app/controllers/profile/faq/faq_answer_controller.dart';
import 'package:cGamer/app/ui/components/coin_wallet_components/youtube_container.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/ui/pages/coin_wallet/coin_wallet.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FAQAnswerView extends StatefulWidget {
  final FAQAnswerController _controller = Get.find<FAQAnswerController>();
  @override
  _FAQAnswerViewState createState() => _FAQAnswerViewState();
}

class _FAQAnswerViewState extends State<FAQAnswerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Obx(() => CustomAppBar(
              appBarTxt: "${widget._controller.categoryTitle}",
            )),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() => Text(
                      '${widget._controller.faqQuestionModel.value.question}',
                      textAlign: TextAlign.center,
                      style: textStyle.copyWith(fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 16,
                ),
                Obx(
                  () => Text(
                    '${widget._controller.faqQuestionModel.value.answer}',
                    textAlign: TextAlign.left,
                    style: textStyle.copyWith(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Obx(
                  () =>
                      widget._controller.faqQuestionModel.value.videoId != null
                          ? YoutubeContainer(
                              videoId: widget
                                  ._controller.faqQuestionModel.value.videoId!,
                            )
                          : SizedBox(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
