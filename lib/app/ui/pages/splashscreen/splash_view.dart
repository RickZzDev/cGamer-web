import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/utils_export.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  double animValue = 0;
  GetStorage? box;
  String splashroute = "";

  void functionAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    animationController?.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          animationController?.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animationController?.forward();
          mounted ? animationController?.forward() : DoNothingAction();
        }
      },
    );

    animationController?.addListener(
      () {
        setState(
          () {
            animValue = animationController!.value;
          },
        );
      },
    );

    animationController?.forward();
  }

  Future? isVerifyRoute;

  Future<String> verifyRoute() async {
    splashroute = Routes.LOGIN;
    box = Provider.of<GetStorage>(context, listen: false);
    if (box?.read('splash_route') == null) {
      splashroute = Routes.ONBOARD;
    } else if (box?.read('splash_route') == Routes.LOGIN) {
      // CacheUtils.removeCache(key: 'x-token');
      // CacheUtils.addToCach('x-token', value)
      var key = await CacheUtils.readValue(key: 'x-token');
      if (key == null) {
        splashroute = Routes.LOGIN;
      } else {
        bool useFaceId = await SecurityUtils.isActivatedFaceId();
        if (useFaceId) {
          bool authenticated = await SecurityUtils.authenticate();
          if (authenticated) {
            splashroute = Routes.MAIN_PAGES_HOLDER;
          } else {
            CacheUtils.removeCache(key: 'x-token');
            splashroute = Routes.LOGIN;
          }
        } else {
          splashroute = Routes.MAIN_PAGES_HOLDER;
        }
      }
    }

    return splashroute;
  }

  @override
  void initState() {
    isVerifyRoute = verifyRoute();
    super.initState();
    functionAnimation();
  }

  @override
  void dispose() {
    if (animationController?.status == AnimationStatus.forward ||
        animationController?.status == AnimationStatus.dismissed) {
      animationController?.notifyStatusListeners(AnimationStatus.dismissed);
    }
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SplashScreen(
            backgroundColor: Theme.of(context).primaryColor,
            seconds: 4,
            //navigateAfterSeconds: splashroute,
            navigateAfterFuture: isVerifyRoute,
            routeName: "/splash",
            loaderColor: Colors.transparent,
          ),
          Center(
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 700),
              opacity: animValue,
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Image.asset("assets/images/logo/logo_gray1.png"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
