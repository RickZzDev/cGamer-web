import 'package:cGamer/app/controllers/profile/profile_controller.dart';
import 'package:cGamer/app/data/models/models_export.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/generic_utils/generic_utils.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/generic_utils/double_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:get/get.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader(
      {Key? key,
      required ProfileController controller,
      required ProfileModel profileStats})
      : _controller = controller,
        _profileStats = profileStats,
        super(key: key);

  final ProfileController _controller;
  final ProfileModel _profileStats;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: Image.asset(
              'assets/images/gamification_icons/background_levels.png',
              fit: BoxFit.cover,
              height: 155,
              cacheHeight:
                  (200 * MediaQuery.of(context).devicePixelRatio).round(),
              cacheWidth: (MediaQuery.of(context).size.width *
                      MediaQuery.of(context).devicePixelRatio)
                  .round(),
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 24, left: 24, top: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      child: CircleAvatar(
                        backgroundColor: secondaryColor,
                        child: _profileStats.customerAvatar == null ||
                                _profileStats.customerAvatar == ""
                            ? Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: SvgPicture.asset(
                                  'assets/images/tab_bar_icons/Perfil.svg',
                                  fit: BoxFit.contain,
                                  color: primaryColor,
                                  height: 24,
                                  width: 24,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(95.0),
                                child: CachedNetworkImage(
                                  imageUrl: _profileStats.customerAvatar ?? "",
                                  fit: BoxFit.cover,
                                  height: 80,
                                  width: 80,
                                ),
                              ),
                      ),
                    ),
                    Container(
                      height: 120,
                      width: 120,
                      child: CachedNetworkImage(
                          imageUrl: _profileStats.level?.newFrameUrl ?? "",
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          height: 50,
                          width: 50,
                          cacheKey: _profileStats.level?.newFrameUrl ?? "",
                          useOldImageOnUrlChange: true,
                          fit: BoxFit.cover),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      child: GestureDetector(
                        onTap: () => _controller.pickImage(),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 24,
                ),
                Container(
                  // color: Colors.red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Text(
                          _profileStats.customerNick ?? "",
                          style: textStyle.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          _profileStats.userName != null
                              ? '@${_profileStats.userName}'
                              : '${_profileStats.customerEmail}',
                          style: textStyle.copyWith(
                              color: _profileStats.userName != null
                                  ? _profileStats.nickColor != null
                                      ? GenericUtils.getColorWithHex(
                                          _profileStats.nickColor ?? "")
                                      : Colors.white70
                                  : Colors.white70,
                              fontSize: 15),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              // Get.toNamed(Routes.MY_PROGRESS);
                            },
                            child: Container(
                              width: 48,
                              height: 48,
                              transform:
                                  Matrix4.translationValues(-8.0, 0.0, 0.0),
                              child: CachedNetworkImage(
                                  imageUrl:
                                      _profileStats.level?.iconLevelUrl ?? "",
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(
                                        strokeWidth: 1,
                                      ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  height: 48,
                                  width: 48,
                                  cacheKey:
                                      _profileStats.level?.iconLevelUrl ?? "",
                                  useOldImageOnUrlChange: true,
                                  fit: BoxFit.cover),
                            ),
                          ),
                          _profileStats.badge != null
                              ? InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.MY_BADGES);
                                  },
                                  child: Container(
                                      width: 48,
                                      height: 48,
                                      transform: Matrix4.translationValues(
                                          -12.0, 0.0, 0.0),
                                      child: CachedNetworkImage(
                                          imageUrl: _profileStats.badge!.image!,
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(
                                                strokeWidth: 1,
                                              ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                          height: 48,
                                          width: 48,
                                          cacheKey: _profileStats.badge!.image,
                                          useOldImageOnUrlChange: true,
                                          fit: BoxFit.cover)))
                              : Container(),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
