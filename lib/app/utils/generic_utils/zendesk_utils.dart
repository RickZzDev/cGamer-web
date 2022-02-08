//import 'package:zendesk/zendesk.dart';
//import 'package:zendesk2/zendesk2.dart';

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';

class FreshdeskUtils {
//  static Zendesk zendesk = Zendesk();

  Future setupFirebase(
      Future<void> Function(RemoteMessage) backgroundMessageHandler) async {
    Freshchat.init("1fd54966-4ceb-41ac-84ad-ccaca3c172ca",
        "152d78e9-cc0f-4bea-97ca-260fa2601328", "msdk.freshchat.com",
        themeName: "CustomTheme.plist",
        stringsBundle: "FCLocalization",
        teamMemberInfoVisible: true,
        responseExpectationEnabled: true,
        userEventsTrackingEnabled: true);

    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    registerFcmToken();
  }

  void initFreshdesk() async {
    Freshchat.init("1fd54966-4ceb-41ac-84ad-ccaca3c172ca",
        "152d78e9-cc0f-4bea-97ca-260fa2601328", "msdk.freshchat.com",
        themeName: "CustomTheme.plist",
        stringsBundle: "FCLocalization",
        teamMemberInfoVisible: true,
        responseExpectationEnabled: true,
        userEventsTrackingEnabled: true);

    registerFcmToken();
  }

  void registerFcmToken() async {
    if (Platform.isAndroid) {
      String? token = await FirebaseMessaging.instance.getToken();
      print("FCM Token is generated $token");
      Freshchat.setPushRegistrationToken(token!);

      FirebaseMessaging.instance.onTokenRefresh
          .listen(Freshchat.setPushRegistrationToken);
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        var data = message.data;
        handleFreshchatNotification(data);
        print("Notification Content: $data");
      });
      //FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    }
  }

  void handleFreshchatNotification(Map<String, dynamic> message) async {
    if (await Freshchat.isFreshchatNotification(message)) {
      print("is Freshchat notification");
      Freshchat.handlePushNotification(message);
    }
  }

  Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
    print("Inside background handler");
    await Firebase.initializeApp();
    handleFreshchatNotification(message.data);
  }
}
