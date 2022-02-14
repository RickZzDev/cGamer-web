import 'package:cGamer/app/controllers/profile/invite_friend/invite_friend_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class InviteFriendView extends StatefulWidget {
  @override
  _InviteFriendViewState createState() => _InviteFriendViewState();
}

class _InviteFriendViewState extends State<InviteFriendView> {
  final InviteFriendController _controller = Get.find<InviteFriendController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          appBarTxt: "Indique um amigo",
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Container(
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CustomRichText(
                    normalText: 'Compartilhe',
                    customText: "seu código de indicação",
                    fontSize: 18,
                  ),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CustomRichText(
                    normalText: "e após seu amigo",
                    customText: "ativar a conta",
                    fontSize: 18,
                  ),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "ganhe",
                    style: textStyle.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Image.asset(
                    'assets/images/gamification_icons/cristal.png',
                    height: 18,
                    width: 18,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "50 Rubis",
                    style: textStyle.copyWith(
                        fontSize: 18,
                        color: primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Obx(() => _controller.isPrime.value
                      ? Container(
                          margin: EdgeInsets.only(left: 4),
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Color(0xFF131313),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          child: Text('X2',
                              style: textStyle.copyWith(fontSize: 12)))
                      : Container())
                ]),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: SvgPicture.asset(
                      'assets/images/profile_images/Invite_Friend_Image.svg'),
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Código de indicação',
                  style: textStyle.copyWith(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12,
                ),
                Obx(
                  () => FutureBuilder(
                    future: _controller.hasCompletedRequest.value,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done)
                        return Text('${_controller.indicationCode.value}',
                            style: textStyle.copyWith(
                                fontSize: 30, color: primaryColor));
                      else
                        return Shimmer.fromColors(
                          child: Container(
                            height: 25,
                            width: 75,
                            color: Colors.white,
                          ),
                          baseColor: secondaryColor,
                          highlightColor: Colors.white,
                        );
                    },
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
