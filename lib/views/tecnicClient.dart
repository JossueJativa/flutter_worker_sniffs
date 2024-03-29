// ignore_for_file: library_private_types_in_public_api, file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_worker_sniffs/controller/async_url_workers.dart';
import 'package:flutter_worker_sniffs/models/appbar_bottonbar.dart';
import 'package:flutter_worker_sniffs/models/buttons.dart';
import 'package:flutter_worker_sniffs/models/inputs.dart';
import 'package:flutter_worker_sniffs/models/tablesClass.dart';

class TecnicClient extends StatefulWidget {
  final Map<String, dynamic> clientData;
  const TecnicClient({ super.key, required this.clientData });

  @override
  _TecnicClientState createState() => _TecnicClientState();
}

class _TecnicClientState extends State<TecnicClient> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _identityController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _partOfDayController = TextEditingController();
  final TextEditingController _statusInstalationController = TextEditingController();
  final TextEditingController _isAcceptedController = TextEditingController();
  final TextEditingController _optionsToInstallController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.clientData['username'];
    _identityController.text = widget.clientData['identity'];
    _phoneController.text = widget.clientData['phone'];
    _priceController.text = widget.clientData['total_price'].toString();
    _dateController.text = widget.clientData['date_instalation'];
    _partOfDayController.text =
        utf8.decode(widget.clientData['part_of_day'].runes.toList());
    _statusInstalationController.text =
        widget.clientData['status_instalation'] ?? 'Pendiente';
    _isAcceptedController.text =
        utf8.decode(widget.clientData['is_accepted_by_manager'].runes.toList());
    _optionsToInstallController.text =
        widget.clientData['options_to_give_instalation'];
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppbarMenu(
          name: widget.clientData['username'],
          email: '',
        ),
      ),
      body: Container(
        color: const Color(0xff040d26),
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            ShowInfo(
              controller: _usernameController,
              name: 'Nombre de usuario',
              labelText: widget.clientData['username'],
              hintText: 'Ingrese nuevo nombre de usuario',
              icon: Icons.person,
              isPassword: false,
              isDigit: false,
              isDate: false,
              readOnly: true,
            ),
            ShowInfo(
              controller: _identityController,
              name: 'Cedula/RUC/Pasaporte',
              labelText: widget.clientData['identity'],
              hintText: 'Ingrese nueva cedula/RUC/pasaporte',
              icon: Icons.credit_card,
              isPassword: false,
              isDigit: false,
              isDate: false,
              readOnly: true,
            ),
            ShowInfo(
              controller: _phoneController,
              name: 'Telefono',
              labelText: widget.clientData['phone'],
              hintText: 'Ingrese nuevo telefono',
              icon: Icons.phone,
              isPassword: false,
              isDigit: true,
              isDate: false,
              readOnly: true,
            ),
            ShowInfo(
              controller: _dateController,
              name: 'Fecha de instalacion',
              labelText: widget.clientData['date_instalation'],
              hintText: 'Ingrese nueva fecha de instalacion',
              icon: Icons.date_range,
              isPassword: false,
              isDigit: false,
              isDate: true,
              readOnly: true,
            ),
            ShowInfo(
              controller: _partOfDayController,
              name: 'Turno',
              labelText: widget.clientData['part_of_day'],
              hintText: 'Ingrese nuevo turno',
              icon: Icons.access_time,
              isPassword: false,
              isDigit: false,
              isDate: false,
              readOnly: true,
            ),
            ShowInfo(
              controller: _statusInstalationController,
              name: 'Estado de instalacion',
              labelText: widget.clientData['status_instalation'] ?? 'Pendiente',
              hintText: 'Ingrese nuevo estado de instalacion',
              icon: Icons.check_circle,
              isPassword: false,
              isDigit: false,
              isDate: false,
              readOnly: true,
            ),
            ShowInfo(
              controller: _optionsToInstallController,
              name: 'Opciones de instalacion',
              labelText: widget.clientData['options_to_give_instalation'],
              hintText: 'Ingrese nuevas opciones de instalacion',
              icon: Icons.delivery_dining,
              isPassword: false,
              isDigit: false,
              isDate: false,
              readOnly: true,
            ),
            const SizedBox(height: 10),
            TableProductsClient(id: widget.clientData['id']),
            const SizedBox(height: 10),
            normalButton(
              text: 'Cambiar estatus a Retrasado',
              onPressed: () async {
                await changeStatusProduct(
                  'api/client/', 'Retrasado', widget.clientData['id'].toString(), context, widget.clientData
                );
              },
              color: Colors.red,
              textColor: Colors.white,
            ),
            const SizedBox(height: 10),
            normalButton(
              text: 'Cambiar estatus a Viajando',
              onPressed: () async {
                await changeStatusProduct(
                  'api/client/', 'Viajando', widget.clientData['id'].toString(), context, widget.clientData
                );
              },
              color: Colors.yellow,
              textColor: Colors.white,
            ),
            const SizedBox(height: 10),
            normalButton(
              text: 'Cambiar estatus a Terminado',
              onPressed: () async {
                await changeStatusProduct(
                  'api/client/', 'Terminado', widget.clientData['id'].toString(), context, widget.clientData
                );
              },
              color: Colors.green,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}