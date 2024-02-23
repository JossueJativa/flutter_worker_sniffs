// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_worker_sniffs/controller/async_ulr.dart';

class TableWidget extends StatefulWidget {
  final String apiUrl;
  final String labelName;
  final int currentData;
  const TableWidget(
      {super.key,
      required this.apiUrl,
      required this.labelName,
      required this.currentData});

  @override
  _TableWidgetState createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  late Future<List<TableInfo>> _tableInfoFuture;

  @override
  void initState() {
    super.initState();
    if (widget.currentData == 2) {
      _tableInfoFuture = getTableInfo(widget.apiUrl, context);
    } else {
      _tableInfoFuture = getTableClientsInfo(widget.apiUrl, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TableInfo>>(
      future: _tableInfoFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.labelName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 300,
                width: 800,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    showCheckboxColumn: false,
                    columns: const [
                      DataColumn(
                          label: Text('Usuario',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white))),
                      DataColumn(
                          label: Text('Cédula',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white))),
                      DataColumn(
                          label: Text('Ver más',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white))),
                    ],
                    rows: snapshot.data!
                        .map(
                          (info) => DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  info.username,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  info.id,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              DataCell(
                                SizedBox(
                                  width: double.infinity,
                                  child: info.button,
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class Tables1 extends StatelessWidget {
  const Tables1({super.key});

  @override
  Widget build(BuildContext context) {
    return const TableWidget(
        apiUrl: 'api/callcenter/',
        labelName: 'Lista de Callcenter',
        currentData: 2);
  }
}

class Tables2 extends StatelessWidget {
  const Tables2({super.key});

  @override
  Widget build(BuildContext context) {
    return const TableWidget(
        apiUrl: 'api/tecnic/', labelName: 'Lista de Técnicos', currentData: 2);
  }
}

class Tables3 extends StatelessWidget {
  const Tables3({super.key});

  @override
  Widget build(BuildContext context) {
    return const TableWidget(
        apiUrl: 'api/client/', labelName: 'Lista de Clientes', currentData: 1);
  }
}

// Definir la clase de cada elemento de la tabla
class TableInfo {
  final String username;
  final String id;
  final ElevatedButton button;

  TableInfo({
    required this.username,
    required this.id,
    required this.button,
  });
}

// Definir los valores de la lista

Future<List<TableInfo>> getTableInfo(String url,
    [BuildContext? context]) async {
  List<TableInfo> tableInfoList = [];
  final workersData = await get_workers(url);
  if (workersData['status'] == true) {
    List<dynamic> workers = workersData['data'];
    for (var worker in workers) {
      String username = worker['user']['username'];
      String id = worker['user']['identity'];
      ElevatedButton button = ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(
            context!,
            '/worker',
            arguments: worker,
          );
        },
        child: const Text('Ver más'),
      );
      TableInfo info = TableInfo(
        username: username,
        id: id,
        button: button,
      );
      tableInfoList.add(info);
    }
  }
  return tableInfoList;
}

Future<List<TableInfo>> getTableClientsInfo(String url,
    [BuildContext? context]) async {
  List<TableInfo> tableInfoList = [];
  final clientsData = await get_workers(url);
  if (clientsData['status'] == true) {
    List<dynamic> clients = clientsData['data'];
    for (var client in clients) {
      if (utf8.decode(client['is_accepted_by_manager'].runes.toList()) ==
          'Esperando Aprobación') {
        String username = client['username'];
        String id = client['identity'];
        ElevatedButton button = ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context!,
              '/client',
              arguments: client,
            );
          },
          child: const Text('Ver más'),
        );
        TableInfo info = TableInfo(
          username: username,
          id: id,
          button: button,
        );
        tableInfoList.add(info);
      }
    }
  }
  return tableInfoList;
}
