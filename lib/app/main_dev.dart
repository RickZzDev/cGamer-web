// @dart=2.9
import 'package:cGamer/app/data/models/user_account_models/register_model.dart';
import 'package:cGamer/app/utils/generic_utils/flavor_config.dart';
import 'package:cGamer/app/utils/generic_utils/zendesk_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/ui/themes/app_themes.dart';
import 'package:cGamer/app/utils/generic_utils/precache_images.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  print("Inside background handler");
  await Firebase.initializeApp();
  handleFreshchatNotification(message.data);
}

void handleFreshchatNotification(Map<String, dynamic> message) async {
  if (await Freshchat.isFreshchatNotification(message)) {
    print("is Freshchat notification");
    Freshchat.handlePushNotification(message);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FreshdeskUtils manager = FreshdeskUtils();
  getIt.registerSingleton<FreshdeskUtils>(manager);
  await manager.setupFirebase(myBackgroundMessageHandler);

  if (defaultTargetPlatform == TargetPlatform.android) {
    InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
  }

  FirebaseChatCoreConfig config = FirebaseChatCoreConfig("rooms", "users");
  FirebaseChatCore.instance.setConfig(config);

  GetStorage box = await CacheUtils.initGetStorage();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  FlavorConfigUtils.createDevConfig();
  PreCacheImages.loadImages();
  runApp(
    AppWidget(
      box: box,
      storage: FlutterSecureStorage(),
      statusRegisterModel: StatusRegisterModel(),
    ),
  );
}

class AppWidget extends StatelessWidget {
  AppWidget({
    Key key,
    @required this.box,
    @required this.storage,
    @required this.statusRegisterModel,
  }) : super(key: key);

  final GetStorage box;
  final FlutterSecureStorage storage;
  final StatusRegisterModel statusRegisterModel;

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      color: Colors.blue,
      location: BannerLocation.topStart,
      child: MultiProvider(
        providers: [
          Provider<GetStorage>(
            create: (_) => box,
          ),
          Provider<FlutterSecureStorage>(
            create: (_) => storage,
          ),
          Provider<StatusRegisterModel>(
            create: (_) => statusRegisterModel,
          )
        ],
        child: GetMaterialApp(
          getPages: AppPages.routes,
          defaultTransition: Transition.cupertino,
          theme: appThemeData,
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.SPLASHSCREEEN,
        ),
      ),
    );
  }
}
