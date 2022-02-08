import 'package:cGamer/app/controllers/profile/profile_controller.dart';
import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectedBadgesArea extends StatelessWidget {
  final ProfileController _controller;
  SelectedBadgesArea(this._controller);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Seus badges",
                  style: textStyle,
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.MY_BADGES),
                  child: Text(
                    "Editar badges",
                    style: textStyle.copyWith(
                        fontSize: 16,
                        color: primaryColor,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
          ),
          SelectedBadges(_controller)
        ],
      ),
    );
  }
}

class SelectedBadges extends StatelessWidget {
  final ProfileController _controller;

  SelectedBadges(ProfileController controller) : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeigthSize * 0.1,
      child: Obx(() => _controller.hasCompletedBedgesRequest.value
          ? ListView.builder(
              itemCount: _controller.badgesModel.badges?.length ?? 0,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                height: 50,
                width: 50,
                margin: EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        _controller.badgesModel.badges?[index].isActive ?? false
                            ? Border.all(width: 3, color: primaryColor)
                            : null,
                    color: Colors.white),
                child: Image.network(
                    _controller.badgesModel.badges?[index].image ?? ""),
              ),
            )
          : ListView.builder(
              itemCount: 4,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                height: 50,
                width: 50,
                margin: EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor,
                ),
              ),
            )),
    );
  }
}
