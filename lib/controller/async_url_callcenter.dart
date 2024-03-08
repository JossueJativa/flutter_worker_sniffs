// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String _allurl = 'http://10.0.2.2:8000';

Future<void> updateClient(String url, String id, Map<String, dynamic> data,
    BuildContext context) async {
  final url0 = Uri.parse('$_allurl/$url$id/');
  final response = await http.patch(url0, body: data);

  if (response.statusCode == 200) {
    Navigator.pop(context);
  }
}

Future<void> deleteClient(String url, String id, BuildContext context) async {
  final url0 = Uri.parse('$_allurl/$url$id/');
  final response = await http.delete(url0);

  if (response.statusCode == 204) {
    Navigator.pop(context);
  }
}

Future<Map<String, dynamic>> get_products(String url) async {
  final url0 = Uri.parse('$_allurl/$url');
  final response = await http.get(url0);

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
  final response = await request.send();

  if (response.statusCode == 201) {
    return true;
  }
  // Ver el error
  print(await response.stream.bytesToString());
  return false;
}