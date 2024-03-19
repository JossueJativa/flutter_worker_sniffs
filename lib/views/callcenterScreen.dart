// ignore_for_file: use_super_parameters, library_private_types_in_public_api, file_names, must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_worker_sniffs/controller/async_ulr.dart';
import 'package:flutter_worker_sniffs/models/appbar_bottonbar.dart';
import 'package:flutter_worker_sniffs/models/inputs.dart';
import 'package:flutter_worker_sniffs/models/tablesClass.dart';

class CallcenterScreen extends StatefulWidget {
  Map<String, dynamic> data;
  CallcenterScreen({ Key? key, required this.data }) : super(key: key);

  @override
  _CallcenterScreenState createState() => _CallcenterScreenState();
}

class _CallcenterScreenState extends State<CallcenterScreen> {
  final TextEditingController _identityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppbarMenu(
          name: widget.data['username'],
          email: widget.data['email'],
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
              callback: () async {
                Map<String, dynamic> data = await getClientByIdentity(
                  "api/client/search-by-identity/",
                  _identityController.text,
                );

                if (data['status']) {
                  Navigator.pushNamed(
                    context,
                    '/editclient',
                    arguments: data['data'],
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No se encontró el cliente'),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            const Tables4(),
          ],
        ),
      ),
      bottomNavigationBar: BottonbarMenuCallcenter(
        data: widget.data,
        currentPage: 0,
      ),
    );
  }
}