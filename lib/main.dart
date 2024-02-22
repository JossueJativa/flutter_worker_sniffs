import 'package:flutter/material.dart';
import 'package:flutter_worker_sniffs/views/clientScreen.dart';
import 'package:flutter_worker_sniffs/views/clientsScreen.dart';
import 'package:flutter_worker_sniffs/views/loginScreen.dart';
import 'package:flutter_worker_sniffs/views/managerScreen.dart';
import 'package:flutter_worker_sniffs/views/workerScreen.dart';
import 'package:flutter_worker_sniffs/views/workersScreen.dart';

void main() {
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
              data: ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>,
            ),
        '/workers': (context) => WorkersScreen(
              data: ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>,
            ),
        '/worker': (context) => WorkerScreen(
              workerData: ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>,
            ),
        '/clients': (context) => ClientsScreen(
              data: ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>,
            ),
        '/client': (context) => ClientScreen(
              clientData: ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>,
            ),
      },
    );
  }
}
