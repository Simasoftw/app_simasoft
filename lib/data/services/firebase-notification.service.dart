import 'dart:convert';

import 'package:app_simasoft/domain/usescases/device-user.usecases.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'http_device_user.service.dart';

Future<void> handlerNotificationBackground(RemoteMessage message) async {
  print("Title: ${message.notification?.title}");
  print("Body: ${message.notification?.body}");
  print("Payload: ${message.data}");
}

class FirebaseApiNotification {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.high,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> initPushNotification() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    const androidSettings = AndroidInitializationSettings('@drawable/launcher_icon');
    const initializationSettings = InitializationSettings(android: androidSettings);
    await _localNotifications.initialize(initializationSettings);

    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidChannel);

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification != null) {
        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              importance: Importance.high,
              priority: Priority.high,
              icon: '@drawable/launcher_icon', // Cambia por el nombre de tu ícono personalizado si es necesario
            ),
          ),
        );
      }
    });
  }

  /// Inicializa los permisos y configuraciones para las notificaciones
  Future<void> initNotifications() async {
    try {
      await _firebaseMessaging.requestPermission();
      final fcmToken = await _firebaseMessaging.getToken();

      print("roken ${fcmToken}");
      if (fcmToken != null) {
        await validateTokenDevice(fcmToken);
      }

      FirebaseMessaging.onBackgroundMessage(handlerNotificationBackground);
      await initPushNotification();
    } catch (e) {
      print('Error al inicializar las notificaciones: $e');
    }
  }



  Future<void> validateTokenDevice(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();



    await prefs.setString('tokenDevice', token);
    final deviceUserCaseUse = DeviceUserCaseUse(HttpDeviceUserService());
    await deviceUserCaseUse.saveInfoDeviceUser(token);
  }
}
