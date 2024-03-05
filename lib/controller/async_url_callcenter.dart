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