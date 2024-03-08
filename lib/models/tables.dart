// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_worker_sniffs/controller/tablesInfo_url.dart';
import 'package:flutter_worker_sniffs/models/tablesClass.dart';

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
    if (widget.currentData == 1) {
      _tableInfoFuture = getTableClientsInfo(widget.apiUrl, context);
    } else if (widget.currentData == 2) {
      _tableInfoFuture = getTableInfo(widget.apiUrl, context);
    } else {
      _tableInfoFuture = getTableEditClientsInfo(widget.apiUrl, context);
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
                height: 400,
                width: 800,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
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
              ),
            ],
          );
        }
      },
    );
  }
}

class TablesCheckbox extends StatefulWidget {
  final String apiUrl;
  final String labelName;
  final List<TableInfoCheckbox> list;

  const TablesCheckbox({
    super.key,
    required this.apiUrl,
    required this.labelName,
    required this.list,
  });

  @override
  _TablesCheckboxState createState() => _TablesCheckboxState();
}

class _TablesCheckboxState extends State<TablesCheckbox> {
  late Future<List<TableInfoCheckbox>> _tableInfoFuture;

  @override
  void initState() {
    super.initState();
    _tableInfoFuture = getProducts(widget.apiUrl, context);
  }

  void resetSelection() {
    setState(() {
      for (var item in widget.list) {
        item.isChecked = false;
      }
      widget.list.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TableInfoCheckbox>>(
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
                height: 630,
                width: 800,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    showCheckboxColumn: false,
                    columns: const [
                      DataColumn(
                        label: Text('Producto', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
                      ),
                      DataColumn(
                        label: Text('Precio', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
                      ),
                      DataColumn(
                        label: Text('Agregar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
                      ),
                    ],
                    rows: snapshot.data!
                        .map(
                          (info) => DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  info.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  info.price,
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
                                  child: info.isChecked
                                      ? const Icon(Icons.check, color: Colors.green)
                                      : ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              info.isChecked = !info.isChecked;
                                              if (info.isChecked) {
                                                widget.list.add(info);
                                              }
                                            });
                                          },
                                          child: const Text('Agregar'),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: resetSelection,
                  icon: const Icon(Icons.refresh),
                  color: Colors.white,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}