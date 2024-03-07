// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';
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

Future<bool> createClient(String url, Map<String, dynamic> data, File image) async {
  // Construir el cuerpo de la solicitud en formato multipart
  var request = http.MultipartRequest('POST', Uri.parse('$_allurl/$url'));
  
  // Agregar los campos de datos al formulario multipart
  request.fields['username'] = data['username'];
  request.fields['phone'] = data['phone'];
  request.fields['identity'] = data['identity'];
  request.fields['date_instalation'] = data['date_instalation'];
  request.fields['part_of_day'] = data['part_of_day'];
  request.fields['total_price'] = data['total_price'];
  request.fields['options_to_give_instalation'] = data['options_to_give_instalation'];
  request.fields['products_bought'] = json.encode(data['products_bought']);

  // Agregar la imagen al formulario multipart
  var photoMultipartFile = await http.MultipartFile.fromPath('photo_reciept', image.path);
  request.files.add(photoMultipartFile);

  // Enviar la solicitud
  var response = await request.send();

  if (response.statusCode == 201) {
    return true;
  }
  return false;
}
