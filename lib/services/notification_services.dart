import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
  final SharedPreferences prefs = await SharedPreferences.getInstance();

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

    String? token = await _firebaseMessaging.getToken();
    print("+======= TOKEN =========+");
    print('Token: $token');

    // Message when the app is in the background
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('+=============== On Message app background ===============+');
      handleFirebaseMessage(message);
      showNotificationAsync(
        message.notification?.title ?? 'Title',
        message.notification?.body ?? 'Body',
      );
    });

    // Message when the app is in the foreground
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('+=============== On Message app foreground ===============+');
      handleFirebaseMessage(message);
    });

    // Message when the app is closed
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      print('+=============== On Message app closed ===============+');
      handleFirebaseMessage(initialMessage);
    }
  }

  void handleFirebaseMessage(RemoteMessage message) {
    print('Received message: ${message.notification?.title}');
    print('Notification body: ${message.notification?.body}');
  }
}