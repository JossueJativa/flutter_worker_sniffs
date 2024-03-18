import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// Local Notifications
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> showNotification() async {
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> showNotificationAsync(String title, String message) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    priority: Priority.high,
    importance: Importance.max,
  );
  const DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails();

  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    message,
    platformChannelSpecifics,
  );
}

// Firebase Cloud Messaging
class PushNotificationProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initnotification() async {
    await _firebaseMessaging.requestPermission();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = await _firebaseMessaging.getToken();
    prefs.setString('token', token!);

    // Message when the app is in the background
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotificationAsync(
        message.notification?.title ?? 'Title',
        message.notification?.body ?? 'Body',
      );
    });

    // Message when the app is in the foreground
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      showNotificationAsync(
        message.notification?.title ?? 'Title',
        message.notification?.body ?? 'Body',
      );
    });

    // Message when the app is closed
    await FirebaseMessaging.instance.getInitialMessage();
  }
}

Future<void> sendNotification(String typePerson, String title, String body) async {
  String url = 'http://10.0.2.2:8000/api/notifications/';

  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  Map<String, dynamic> data = {
    'type_user': typePerson,
    'title': title,
    'body': body,
  };

  await http.post(
    Uri.parse(url),
    headers: headers,
    body: json.encode(data),
  );
}