import 'package:flutter/material.dart';
import 'package:flutter_worker_sniffs/services/notification_services.dart';
import 'package:flutter_worker_sniffs/services/request_permissions.dart';
import 'package:flutter_worker_sniffs/views/callcenterScreen.dart';
import 'package:flutter_worker_sniffs/views/clientScreen.dart';
import 'package:flutter_worker_sniffs/views/clientsScreen.dart';
import 'package:flutter_worker_sniffs/views/createClient.dart';
import 'package:flutter_worker_sniffs/views/editclientScreen.dart';
import 'package:flutter_worker_sniffs/views/loginScreen.dart';
import 'package:flutter_worker_sniffs/views/managerScreen.dart';
import 'package:flutter_worker_sniffs/views/tecnicClient.dart';
import 'package:flutter_worker_sniffs/views/tecnicScreen.dart';
import 'package:flutter_worker_sniffs/views/workerScreen.dart';
import 'package:flutter_worker_sniffs/views/workersScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Se asegura que inicie todo antes de ejecutar la app
  await showNotification(); // Muestra notificaciones
  await requestPermissions(); // Solicita permisos
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Inicializa Firebase
  );
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/manager': (context) => ManagerScreen(
              data: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>,
            ),
        '/workers': (context) => WorkersScreen(
              data: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>,
            ),
        '/worker': (context) => WorkerScreen(
              workerData: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>,
            ),
        '/clients': (context) => ClientsScreen(
              data: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>,
            ),
        '/client': (context) => ClientScreen(
              clientData: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>,
            ),
        '/callcenter': (context) => CallcenterScreen(
              data: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>,
            ),
        '/editclient': (context) => EditclientScreen(
              clientData: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>,
            ),
        '/createclient': (context) => CreateClient(
              data: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>,
            ),
        '/tecnic': (context) => TecnicScreen(
              data: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>,
            ),
        '/tecnicclient': (context) => TecnicClient(
              clientData: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>,
            ),
      },
    );
  }
}
