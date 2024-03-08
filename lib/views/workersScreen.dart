// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_worker_sniffs/controller/async_ulr.dart';
import 'package:flutter_worker_sniffs/models/appbar_bottonbar.dart';
import 'package:flutter_worker_sniffs/models/inputs.dart';
import 'package:flutter_worker_sniffs/models/tablesClass.dart';
import 'package:flutter_worker_sniffs/views/workerScreen.dart';

class WorkersScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const WorkersScreen({super.key, required this.data});

  @override
  _WorkersScreenState createState() => _WorkersScreenState();
}

class _WorkersScreenState extends State<WorkersScreen> {
  final TextEditingController _identityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppbarMenu(
          name: widget.data['username'],
        ),
      ),
      body: Container(
        color: const Color(0xff040d26),
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SearchInput(
              labelText: 'Filtrar por Cédula/RUC/Pasaporte',
              hintText: 'Buscar trabajador',
              controller: _identityController,
              icon: Icons.search,
              isDigit: true,
              callback: () async {
                Map<String, dynamic> data = await getWorkerByIdentity(
                  "api/user/search-by-identity/",
                  _identityController.text,
                );

                if (data['status']) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkerScreen(
                        workerData: data['data'],
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No se encontró el trabajador'),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            const Tables1(),
            const SizedBox(height: 10),
            const Tables2(),
          ],
        ),
      ),
      bottomNavigationBar: BottonbarMenu(
        data: widget.data,
        currentPage: 1,
      ),
    );
  }
}
