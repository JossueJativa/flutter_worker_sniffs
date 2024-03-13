import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

Future<void> showNotificationAsync() async {
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

  if (prefs.getString('type') == 'manager'){
    await flutterLocalNotificationsPlugin.show(
      0,
      'Querido Manager',
      'Hay nuevas solicitudes de clientes por revisar',
      platformChannelSpecifics,
    );
  } else if (prefs.getString('type') == 'tecnic'){
    await flutterLocalNotificationsPlugin.show(
      0,
      'Querido Cliente',
      'Tu solicitud ha sido aceptada',
      platformChannelSpecifics,
    );
  }
}