import 'package:cGamer/app/controllers/marketplace/terms_use_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class TermsUseView extends StatelessWidget {
  TermsUseController _controller = Get.find<TermsUseController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
            appBarTxt: _controller.title != null
                ? _controller.title ?? ""
                : _controller.howToRedeem != null
                    ? "Como resgatar seu PIN"
                    : "Termos de condições e uso"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _controller.termsUse ?? _controller.howToRedeem ?? "",
                style: textStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
