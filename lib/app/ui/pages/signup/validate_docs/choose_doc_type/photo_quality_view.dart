import 'package:cGamer/app/controllers/signup/validate_docs/photo_quality_controller.dart';
import 'package:cGamer/app/controllers/signup/validate_docs/take_photo_tips_controller.dart';
import 'package:cGamer/app/ui/components/singup_components/docs_validate_components/photo_quality_components/photo_item.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as style;

import 'package:cGamer/app/ui/components/components.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../components/components.dart';

class PhotoQualityView extends StatefulWidget {
  PhotoQualityView(this.takePhotoTipsController)
      : assert(takePhotoTipsController != null);

  final TakePhotoTipsController takePhotoTipsController;

  @override
  _PhotoQualityViewState createState() => _PhotoQualityViewState();
}

class _PhotoQualityViewState extends State<PhotoQualityView> {
  PhotoQualityController _controller = Get.put(PhotoQualityController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          appBarTxt: "Verifique a foto",
        ),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: style.screenHeigthSize * 0.60,
                width: style.screenWidthhSize,
                child: PhotoQualityItem(
                  isFrontSide: _controller.isFrontSide,
                  takePhotoTipsController: widget.takePhotoTipsController,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        width: style.screenWidthhSize / 2 - 48,
                        child: GenericButton(
                            height: 48,
                            color: style.secondaryColor,
                            icon: Icons.camera_alt_rounded,
                            txtColor: Colors.white,
                            text: 'Tirar outra',
                            onPressedFunction: () {
                              if (_controller.isFrontSide) {
                                widget.takePhotoTipsController.getImage(
                                    isFrontSide: true,
                                    takePhotoTipsController:
                                        widget.takePhotoTipsController);
                              } else {
                                widget.takePhotoTipsController.getImage(
                                    isFrontSide: false,
                                    takePhotoTipsController:
                                        widget.takePhotoTipsController);
                              }
                            })),
                    //_controller
                    //  .takePictureAgain(widget.takePhotoTipsController)),
                    Container(
                        width: style.screenWidthhSize / 2 - 48,
                        child: GenericButton(
                            icon: Icons.check_circle,
                            txtColor: Colors.white,
                            text: 'Ficou boa',
                            onPressedFunction: () {
                              Get.back();
                            })),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
