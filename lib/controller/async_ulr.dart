// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String _allurl = 'http://10.0.2.2:8000';

String encryptPassword(String password) {
  List<int> passwordBytes = utf8.encode(password);
  Digest sha256Result = sha256.convert(passwordBytes);
  String base64Hash = base64.encode(sha256Result.bytes);

  return base64Hash;
}

Future<Map<String, dynamic>> login_api(String? email, String? password, {required String url}) async {
  final url0 = Uri.parse('$_allurl/$url');

  if (email == null || password == null) {
    return {
      'status': false,
      'data': 'email or password is null',
    };
  }

  String encodedPassword = encryptPassword(password);
  final response = await http.post(url0, body: {
    'email': email,
    'password': encodedPassword,
  });

  switch (response.statusCode) {
    case 200:
      final userResponse = jsonDecode(response.body);
      final id = userResponse['id'];
      var urlsearch = Uri.parse('$_allurl/api/manager/search-by-user/$id/');

      final responseSearch = await http.get(urlsearch);

      if (responseSearch.statusCode == 200) {
        return {
          'status': true,
          'data': jsonDecode(response.body),
          'type': 'manager'
        };
      }

      urlsearch = Uri.parse('$_allurl/api/callcenter/search-by-user/$id/');
      final responseSearchCallCenter = await http.get(urlsearch);

      if (responseSearchCallCenter.statusCode == 200) {
        return {
          'status': true,
          'data': jsonDecode(response.body),
          'type': 'callcenter'
        };
      }

      urlsearch = Uri.parse('$_allurl/api/tecnic/search-by-user/$id/');
      final responseSearchTechnic = await http.get(urlsearch);

      if (responseSearchTechnic.statusCode == 200) {
        return {
          'status': true,
          'data': jsonDecode(response.body),
          'type': 'tecnic'
        };
      }

      return {
        'status': false,
        'data': 'user not found',
      };
      
    default:
      return {
        'status': false,
        'data': jsonDecode(response.body),
      };
  }
}

Future<Map<String, dynamic>> create_user_api({
  required String url,
  required String firstName,
  required String lastName,
  required String email,
  required String phone,
  required String password,
  required String id,
  }) async {
  final url0 = Uri.parse('$_allurl/$url');
  Map<String, dynamic> data = {
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'phone': phone,
    'password': encryptPassword(password),
    'identity': id,
    'username': '${firstName}_$lastName',
  };
  final response = await http.post(url0, body: data);

  if (response.statusCode == 201) {
    return {
      'status': true,
      'data': jsonDecode(response.body),
    };
  }

  return {
    'status': false,
  };
}

Future<bool> createCallCenter(File image, String user, String url) async {
  final url0 = Uri.parse('$_allurl/$url');

  try {
    var request = http.MultipartRequest('POST', url0);
    request.files.add(await http.MultipartFile.fromPath('photo', image.path));
    request.fields['user'] = user;
    var response = await request.send();
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

Future<Map<String, dynamic>> get_workers(String url) async {
  final url0 = Uri.parse('$_allurl/$url');
  final response = await http.get(url0);
  List<dynamic> workers = [];

  if (response.statusCode == 200) {
    for (var i in jsonDecode(response.body)) {
      final urlUser = Uri.parse('$_allurl/api/user/${i['user']}/');
      final responseUser = await http.get(urlUser);
      i['user'] = jsonDecode(responseUser.body);
      workers.add(i);
    }
    return {
      'status': true,
      'data': workers,
    };
  }

  return {
    'status': false,
  };
}

Future<void> update_worker(String url, String id, Map<String, dynamic> data, BuildContext context, File? image) async {
  final url0 = Uri.parse('$_allurl/$url$id/');
  final response = await http.patch(url0, body: data);
  if (response.statusCode != 200) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text('Error ${response.body}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    return;
  }

  final urlUser = Uri.parse('$_allurl/api/user/$id/');
  await http.patch(urlUser, body: data);
  if (image != null){
    var urlsearch = Uri.parse('$_allurl/api/callcenter/search-by-user/$id/');
    final responseSearchCallCenter = await http.get(urlsearch);

    if (responseSearchCallCenter.statusCode == 200) {
      final callCenter = jsonDecode(responseSearchCallCenter.body);
      final int id = callCenter['id'] as int;
      final url0 = Uri.parse('$_allurl/api/callcenter/$id/');
      var request = http.MultipartRequest('PATCH', url0);
      request.files.add(await http.MultipartFile.fromPath('photo', image.path));
      var response = await request.send();
      if (response.statusCode == 200) {
        Navigator.pop(context);
      }
    }

    urlsearch = Uri.parse('$_allurl/api/tecnic/search-by-user/$id/');
    final responseSearchTechnic = await http.get(urlsearch);
    if (responseSearchTechnic.statusCode == 200) {
      final tecnic = jsonDecode(responseSearchTechnic.body);
      final url0 = Uri.parse('$_allurl/api/tecnic/${tecnic['id']}/');
      var request = http.MultipartRequest('PATCH', url0);
      request.files.add(await http.MultipartFile.fromPath('photo', image.path));
      var response = await request.send();
      if (response.statusCode == 200) {
        Navigator.pop(context);
      }
    }
  }
  Navigator.pop(context);
}