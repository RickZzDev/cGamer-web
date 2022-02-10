import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/controllers/profile/profile_controller.dart';
import 'package:cGamer/app/data/provider/home_provider/home_provider.dart';
import 'package:cGamer/app/data/provider/profile_provider/profile_provider.dart';
import 'package:cGamer/app/data/repository/home_repository.dart';
import 'package:cGamer/app/data/repository/profile_repositories/profile_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(primaryColor);
    Requester client = Requester();

    ProfileApiClient _apiClient = ProfileApiClient(httpClient: client);
    final ProfileController _controller = Get.put(
      ProfileController(
        repository: ProfileRepository(apiClient: _apiClient),
      ),
    );

    HomeApiClient _homeApiClient = HomeApiClient(httpClient: client);
    final HomeController _homeController = Get.put(
      HomeController(
        repository: HomeRepository(apiClient: _homeApiClient),
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Theme.of(context).primaryColor,
        systemNavigationBarColor: Theme.of(context).accentColor,
      ),
      child: Obx(
        () => ModalProgressHUD(
          inAsyncCall: _controller.loading.value,
          child: Scaffold(
            backgroundColor: Theme.of(context).accentColor,
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () => _controller.refreshPage(),
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(children: [
                                  Container(
                                    padding:
                                        EdgeInsets.only(top: 16, bottom: 48),
                                    color: Theme.of(context).primaryColor,
                                    width: MediaQuery.of(context).size.width,
                                    height: 110,
                                    child: Container(
                                      height: 36,
                                      width: 36,
                                      child: Image.asset(
                                        'assets/images/logo/logo_gray.png',
                                        color: Theme.of(context).accentColor,
                                        height: 36,
                                        width: 36,
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => _controller
                                            .hasCompletedProfileRequest.value
                                        ? Container(
                                            margin: EdgeInsets.only(
                                                top: 80, bottom: 0),
                                            child: ProfileHeader(
                                              controller: _controller,
                                              profileStats: _controller
                                                  .statusProfileResult.value,
                                            ),
                                          )
                                        : Container(
                                            margin: EdgeInsets.only(
                                                top: 80, bottom: 0),
                                            child: ProfileHeaderShimer(),
                                          ),
                                  ),
                                  Container(
                                      width: screenWidthhSize,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(right: 12),
                                              child: IconButton(
                                                  iconSize: 70,
                                                  tooltip: "Conexões",
                                                  onPressed: () => Get.toNamed(
                                                          Routes.CONNECTIONS,
                                                          arguments: {
                                                            'fromHome': true
                                                          }),
                                                  icon: SvgPicture.asset(
                                                      'assets/images/play_together/icon_conexoes.svg',
                                                      color: secondaryColor)))
                                        ],
                                      )),
                                ]),
                                ProfileOptionsComponent(
                                    profileController: _controller)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
