// Definir los valores de la lista de la tabla
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_worker_sniffs/controller/async_ulr.dart';
import 'package:flutter_worker_sniffs/controller/async_url_workers.dart';
import 'package:flutter_worker_sniffs/models/tablesClass.dart';

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

Future<List<TableInfo>> getTableEditClientsInfo(String url,
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
              '/editclient',
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

Future<List<TableInfoCheckbox>> getProducts(String url, [BuildContext? context]) async {
  List<TableInfoCheckbox> tableInfoList = [];
  final productsData = await get_products(url);
  if (productsData['status'] == true) {
    List<dynamic> products = jsonDecode(productsData['data']);
    print(products);
    for (var product in products) {
      int id = product['id'];
      String name = product['name'];
      String price = product['price'].toString();
      TableInfoCheckbox info = TableInfoCheckbox(
        id: id,
        name: name,
        price: price,
        isChecked: false,
      );
      tableInfoList.add(info);
    }
  }
  return tableInfoList;
}
