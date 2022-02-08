import 'package:cGamer/app/controllers/profile/security/security_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/ui/components/profile_components/security_components/faceid_bio_cell_component.dart';

class SecurityView extends StatefulWidget {
  @override
  _SecurityViewState createState() => _SecurityViewState();
}

class _SecurityViewState extends State<SecurityView> {
  final SecurityController _controller = Get.find<SecurityController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          appBarTxt: "Segurança",
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 12,
              );
            },
            scrollDirection: Axis.vertical,
            itemCount: 1,
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
            itemBuilder: (context, index) {
              return FaceIdCellComponent(
                controller: _controller,
              );
            }),
      ),
    );
  }
}
