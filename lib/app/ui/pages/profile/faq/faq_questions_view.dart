import 'package:cGamer/app/controllers/profile/faq/faq_questions_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FAQQuestionsView extends StatefulWidget {
  final FAQQuestionsController _controller = Get.find<FAQQuestionsController>();
  @override
  _FAQQuestionsViewState createState() => _FAQQuestionsViewState();
}

class _FAQQuestionsViewState extends State<FAQQuestionsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Obx(() => CustomAppBar(
                appBarTxt:
                    "${widget._controller.faqQuestionsModel.value.categoryTitle}",
              )),
        ),
        body: Padding(
            padding: EdgeInsets.all(24),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomTextField(
                labelText: "Qual a sua dúvida?",
                autoFocus: false,
                sufixIcon: Icon(Icons.search, color: primaryColor),
                onChange: widget._controller.filter,
              ),
              SizedBox(
                height: 32,
              ),
              Expanded(
                  child: Obx(() => ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 16,
                        );
                      },
                      scrollDirection: Axis.vertical,
                      itemCount: widget._controller.questions.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              widget._controller.goToAnswer(
                                  widget._controller.questions[index],
                                  widget._controller.faqQuestionsModel.value
                                          .categoryTitle ??
                                      "");
                            },
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 4, right: 4, bottom: 8, top: 4),
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                child: Expanded(
                                                    child: Text(
                                              '${widget._controller.questions[index].question}',
                                              textAlign: TextAlign.left,
                                              style: textStyle.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ))),
                                            Icon(
                                              Icons.chevron_right,
                                              color: Colors.white,
                                            ),
                                          ])),
                                  Divider(
                                    color: Colors.white,
                                    height: 1,
                                  ),
                                ]));
                      })))
            ])));
  }
}
