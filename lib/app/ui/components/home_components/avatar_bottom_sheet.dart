import 'package:auto_size_text/auto_size_text.dart';
import 'package:cGamer/app/data/models/home_models/avatar_model.dart';
import 'package:cGamer/app/ui/components/home_components/tag_prime.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AvatarModalBottomSheet extends StatefulWidget {
  final AvatarModel avatarModel;
  final String? avatarSelected;
  final Function saveImage;
  final bool isPrime;

  const AvatarModalBottomSheet(
      {Key? key,
      required this.avatarModel,
      required this.saveImage,
      required this.isPrime,
      this.avatarSelected})
      : super(key: key);

  @override
  _AvatarModalBottomSheetState createState() => _AvatarModalBottomSheetState();
}

class _AvatarModalBottomSheetState extends State<AvatarModalBottomSheet> {
  int? selected;

  @override
  void initState() {
    super.initState();
  }

  double _checkSelected(int _index) {
    if (selected == null) {
      if (widget.avatarModel.avatars?[_index].select ?? false) {
        return 1;
      } else
        return 0;
    } else if (selected == _index) {
      return 1;
    } else
      return 0;
  }

  Color checkSelectedOpacity(int _index) {
    if (selected == null) {
      if (widget.avatarModel.avatars?[_index].select ?? false) {
        return Colors.white.withOpacity(0.5);
      } else
        return Colors.white.withOpacity(0);
    } else if (selected == _index) {
      return Colors.white.withOpacity(0.5);
    } else
      return Colors.white.withOpacity(0.0);

    //                               : selected == index
    //                                   ? Colors.white.withOpacity(0.5)
    //                                   :
  }

  _chooseItem(int _index) {
    setState(
      () {
        if (widget.avatarModel.avatars?[_index].select ?? false) {
          widget.avatarModel.avatars?[_index].select = false;
        }
        selected == _index ? selected = null : selected = _index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            const EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 16),
        height: Get.height * 0.85,
        color: secondaryColor,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Escolha seu avatar",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close_outlined,
                      size: 32,
                      color: Colors.white,
                    ),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              Expanded(
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: (widget.avatarModel.avatars?.length ?? 0) + 1,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return GestureDetector(
                            onTap: () {
                              SnackBarUtils.showSnackBar(
                                  desc:
                                      'Estamos finalizando o desenvolvimento dessa funcionalidade ;)',
                                  title: 'Atenção',
                                  color: Colors.orange[400]);
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: (screenWidthhSize / 3) - 36,
                                    height: (screenWidthhSize / 3) - 36,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        border:
                                            Border.all(color: primaryColor)),
                                    child: Center(
                                        child: Icon(
                                      Icons.camera_alt_outlined,
                                      color: primaryColor,
                                      size: 40,
                                    )),
                                  ),
                                  TagPrime(
                                    transform: Matrix4.translationValues(
                                        30.0, -36.0, 0.0),
                                  ),
                                ],
                              ),
                            ));
                      } else {
                        return GestureDetector(
                            onTap: () {
                              _chooseItem(index - 1);
                            },
                            child: Container(
                              height: 95,
                              width: 95,
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                // color: Colors.yellow,
                                shape: BoxShape.circle,
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 95,
                                    height: 95,
                                    child: Center(
                                      child: CachedNetworkImage(
                                        imageUrl: widget.avatarModel
                                                .avatars?[index - 1].image ??
                                            "",
                                        fit: BoxFit.cover,
                                        alignment: Alignment.topCenter,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(
                                          backgroundColor: primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  AnimatedOpacity(
                                    duration: Duration(milliseconds: 100),
                                    opacity: _checkSelected(index - 1),
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 100),
                                      width: 105,
                                      height: 105,
                                      decoration: BoxDecoration(
                                        color: widget
                                                    .avatarModel
                                                    .avatars?[index - 1]
                                                    .select ??
                                                false
                                            ? Colors.white.withOpacity(0.5)
                                            : selected == (index - 1)
                                                ? Colors.white.withOpacity(0.5)
                                                : Colors.white.withOpacity(0),
                                        shape: BoxShape.circle,
                                        border: Border.all(color: primaryColor),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.check_outlined,
                                          color: primaryColor,
                                          size: 32,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      }
                    }),
              ),
              Column(
                children: [
                  Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: primaryColor,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                        child: Container(
                            width: Get.width * 0.15,
                            child: Center(
                                child: AutoSizeText(
                              "Cancelar",
                              minFontSize: 10,
                              maxFontSize: 12,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ))),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          widget.saveImage(
                              selected ?? -1,
                              selected == null
                                  ? ""
                                  : widget.avatarModel.avatars?[selected ?? -1]
                                          .image ??
                                      "");
                          Get.back();
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: primaryColor,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                        child: SizedBox(
                          width: Get.width * 0.55,
                          child: Center(
                            child: Text(
                              "Salvar",
                              style: TextStyle(
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}
