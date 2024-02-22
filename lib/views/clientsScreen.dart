// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_worker_sniffs/models/appbar_bottonbar.dart';
import 'package:flutter_worker_sniffs/models/inputs.dart';
import 'package:flutter_worker_sniffs/models/tables.dart';

class ClientsScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const ClientsScreen({super.key, required this.data});

  @override
  _ClientsScreenState createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  final TextEditingController _identityController = TextEditingController();
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
        child: ListView(
          children: [
            SearchInput(
              labelText: 'Filtrar por Cédula/RUC/Pasaporte',
              hintText: 'Buscar cliente',
              controller: _identityController,
              icon: Icons.search,
              isDigit: true,
            ),
            const SizedBox(height: 10),
            const Tables3(),
          ],
        ),
      ),
      bottomNavigationBar: BottonbarMenu(
        data: widget.data,
        currentPage: 2,
      ),
    );
  }
}
