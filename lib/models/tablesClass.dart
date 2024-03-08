// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_worker_sniffs/models/tables.dart';

class TableInfoCheckbox {
  final int id;
  final String name;
  final String price;
  bool isChecked; // Nuevo estado para el checkbox

  TableInfoCheckbox({
    required this.id,
    required this.name,
    required this.price,
    required this.isChecked, // Inicialmente no está seleccionado
  });
}


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

class Tables4 extends StatelessWidget {
  const Tables4({super.key});

  @override
  Widget build(BuildContext context) {
    return const TableWidget(
        apiUrl: 'api/client/', labelName: 'Lista de Managers', currentData: 3);
  }
}

class TableCheck extends StatelessWidget {
  final List<TableInfoCheckbox> list;

  const TableCheck({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return TablesCheckbox(
      apiUrl: 'api/product/',
      labelName: 'Lista de productos',
      list: list,
    );
  }
}