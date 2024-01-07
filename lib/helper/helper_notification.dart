
import 'dart:convert';

import 'package:e_commercee_app/routes/route_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async{
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class HelperNotification{
  final FirebaseMessaging firebaseMessaging;

  HelperNotification({required this.firebaseMessaging});
  late final String? _fCMToken;
  String? get fCMToken => _fCMToken;


  final _androidChannel = const AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
    description: "This channel is used for important notification",
    importance: Importance.defaultImportance
  );
  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message){
    if(message == null) return;
    if (kDebugMode) {

    }
    Get.toNamed(RouteHelper.getCartPage());
  }
  Future initLocalNotifications() async{
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings("@drawable/ic_launcher");
    const settings = InitializationSettings(android: android, iOS: iOS);
    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (notificationResponse){
        final message = RemoteMessage.fromMap(jsonDecode(notificationResponse.payload!));
        handleMessage(message);
      },
    );
    final platform = _localNotifications.resolvePlatformSpecificImplementation
      <AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotifications() async{
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
    );

    firebaseMessaging.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if(notification == null) return;

      _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
            _androidChannel.name,
              channelDescription: _androidChannel.description,

              icon: "@drawable/ic_launcher"
            )
          ),
          payload: jsonEncode(message.toMap()),
        );
    });
  }

  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission(announcement: true, );
    _fCMToken = await firebaseMessaging.getToken();
    print("Token: $_fCMToken");
    initPushNotifications();
    initLocalNotifications();

  }




}