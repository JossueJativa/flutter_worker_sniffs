// ignore_for_file: file_names, library_private_types_in_public_api, use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_worker_sniffs/models/appbar_bottonbar.dart';
import 'package:flutter_worker_sniffs/models/tablesClass.dart';

class TecnicScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const TecnicScreen({ Key? key, required this.data }) : super(key: key);

  @override
  _TecnicScreenState createState() => _TecnicScreenState();
}

class _TecnicScreenState extends State<TecnicScreen> {
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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Lista de clientes",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                    decorationThickness: 2,
                  ),
                ),
                const SizedBox(height: 10),
                Tables5(id: widget.data['id'])
              ],
            ),
          ),
        ),
      ),
    );
  }
}