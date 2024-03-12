import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

Future<void> showNotificationAsync(String title, String message, String typeWorker) async {
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