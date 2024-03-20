// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_worker_sniffs/models/tablesClass.dart';
import 'package:http/http.dart' as http;

const String _allurl = 'http://10.0.2.2:8000';

const Map<String, String> _headers = {
  'Authorization': "Token 7cfd1bef5b9f3cf44a070a0dbf47287c8ae159e2",
};

Future<void> updateClient(String url, String id, Map<String, dynamic> data,
    BuildContext context) async {
  final url0 = Uri.parse('$_allurl/$url$id/');
  final response = await http.patch(url0, headers: _headers, body: data);

  if (response.statusCode == 200) {
    Navigator.pop(context);
  }
}

Future<void> deleteClient(String url, String id, BuildContext context) async {
  final url0 = Uri.parse('$_allurl/$url$id/');
  final response = await http.delete(url0, headers: _headers);

  if (response.statusCode == 204) {
    Navigator.pop(context);
  }
}

Future<Map<String, dynamic>> get_products(String url) async {
  final url0 = Uri.parse('$_allurl/$url');
  final response = await http.get(url0, headers: _headers);

  if (response.statusCode == 200) {
    return {
      'status': true,
      'data': response.body,
    };
  }
  return {
    'status': false,
  };
}

Future<bool> createClient(String url, Map<String, dynamic> dataJson, File photo_reciept) async {
  final url0 = Uri.parse('$_allurl/$url');
  final request = http.MultipartRequest('POST', url0);
  request.fields.addAll(dataJson.map((key, value) => MapEntry(key, value.toString())));
  request.files.add(await http.MultipartFile.fromPath('photo_reciept', photo_reciept.path));
  request.headers.addAll(_headers);
  final response = await request.send();

  if (response.statusCode == 201) {
    return true;
  }
  return false;
}

Future<List<TableInfo>> getClientsTecnic(String url, BuildContext context) async {
  List<TableInfo> clientsList = [];
  // Obtener base de datos de los clientes del tecnico
  final url0 = Uri.parse('$_allurl/$url');
  final response = await http.get(url0, headers: _headers);

  if (response.statusCode == 200) {
    final tecnic = jsonDecode(response.body);
    final clients = tecnic[0]['clients'];
    for (var i in clients) {
      final urlClient = Uri.parse('$_allurl/api/client/$i/');
      final responseClient = await http.get(urlClient, headers: _headers);
      if (responseClient.statusCode == 200) {
        final client = jsonDecode(responseClient.body);
        clientsList.add(TableInfo(
          username: client['username'],
          id: client['identity'].toString(),
          button: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/tecnicclient', arguments: client);
            },
            child: const Text('Ver'),
          ),
        ));
      }
    }
  }
  return clientsList;
}

Future<List<TableProducts>> getProductsClient(String url, BuildContext context) async {
  List<TableProducts> productList = [];
  // Obtener base de datos de los clientes del tecnico
  final url0 = Uri.parse('$_allurl/$url');
  final response = await http.get(url0, headers: _headers);

  if (response.statusCode == 200) {
    final clientProduct = jsonDecode(response.body);
    final products = clientProduct['products_bought'];
    for (var i in products) {
      final urlProduct = Uri.parse('$_allurl/api/product/$i/');
      final responseProduct = await http.get(urlProduct, headers: _headers);
      if (responseProduct.statusCode == 200) {
        final productrsp = jsonDecode(responseProduct.body);
        productList.add(TableProducts(
          name: productrsp['name'],
        ));
      }
    }
  }
  return productList;
}

Future<void> changeStatusProduct(String url, String status, String id, BuildContext context, Map<String, dynamic> data) async {
  final url0 = Uri.parse('$_allurl/$url$id/');
  final response = await http.patch(url0, headers: _headers, body: {'status_instalation': status});

  if (response.statusCode == 200) {
    await Future.delayed(const Duration(seconds: 1));
    Navigator.popAndPushNamed(context, '/tecnicclient', arguments: data);
  }
}

Future<void> createTicket(String url, Map<String, dynamic> data, File foto, BuildContext context) async {
  final url0 = Uri.parse('$_allurl/$url');
  final request = http.MultipartRequest('POST', url0);
  request.fields.addAll(data.map((key, value) => MapEntry(key, value.toString())));
  request.files.add(await http.MultipartFile.fromPath('photo', foto.path));
  request.headers.addAll(_headers);
  final response = await request.send();

  if (response.statusCode == 201) {
    Navigator.pop(context);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error al crear ticket'),
      ),
    );
  }
}