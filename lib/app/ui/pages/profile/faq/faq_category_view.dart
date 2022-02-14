import 'package:cGamer/app/controllers/profile/faq/faq_category_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/generic_utils/verify_future_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class FAQCategoryView extends StatefulWidget {
  @override
  _FAQCategoryViewState createState() => _FAQCategoryViewState();
}

class _FAQCategoryViewState extends State<FAQCategoryView> {
  final FAQCategoryController _controller = Get.find<FAQCategoryController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
        inAsyncCall: _controller.loading.value,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: primaryColor,
        ),
        child: Scaffold(
          backgroundColor: Theme.of(context).accentColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: CustomAppBar(
              appBarTxt: "Dúvidas frequentes",
            ),
          ),
          body: Obx(() => FutureBuilder(
              future: Future.wait([
                _controller.hasCompletedCategoriesRequest.value,
              ]),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshots) {
                if (FutureUtils.verifyFutureState(
                        snapshots, _controller.allComplete) ||
                    _controller.allComplete.value) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 16,
                        );
                      },
                      scrollDirection: Axis.vertical,
                      itemCount: _controller
                              .categoriesResult.value.categories?.length ??
                          0,
                      padding: EdgeInsets.only(
                          left: 24, right: 24, bottom: 16, top: 16),
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () => _controller.goToQuestions(
                                _controller.categoriesResult.value
                                        .categories?[index].id ??
                                    0,
                                _controller.categoriesResult.value
                                        .categories?[index].title ??
                                    ""),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      offset: Offset(1, 2.0), //(x,y)
                                      blurRadius: 2.0,
                                    ),
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: secondaryColor,
                                  border: Border.all(
                                      width: 1.5, color: primaryColor)),
                              child: Center(
                                  child: Text(
                                '${_controller.categoriesResult.value.categories?[index].title}',
                                style: textStyle.copyWith(color: primaryColor),
                              )),
                            ));
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              })),
          //  );
          //   else
          //     return MyProgressShimer();
          // },
        )));
  }
}
