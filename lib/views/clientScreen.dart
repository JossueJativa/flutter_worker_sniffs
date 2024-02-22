// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_worker_sniffs/models/appbar_bottonbar.dart';
import 'package:flutter_worker_sniffs/models/inputs.dart';

class ClientScreen extends StatefulWidget {
  final Map<String, dynamic> clientData;
  const ClientScreen({super.key, required this.clientData});

  @override
  _ClientScreenState createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _identityController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _partOfDayController = TextEditingController();
  final TextEditingController _statusInstalationController =
      TextEditingController();
  final TextEditingController _isAcceptedController = TextEditingController();
  final TextEditingController _optionsToInstallController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.clientData['username'];
    _identityController.text = widget.clientData['identity'];
    _phoneController.text = widget.clientData['phone'];
    _priceController.text = widget.clientData['total_price'];
    _dateController.text = widget.clientData['date_instalation'];
    _partOfDayController.text = widget.clientData['part_of_day'];
    _statusInstalationController.text = widget.clientData['status_instalation'];
    _isAcceptedController.text = widget.clientData['is_accepted_by_manager'];
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
            ),
            ShowInfo(
              controller: _identityController,
              name: 'Cedula/RUC/Pasaporte',
              labelText: widget.clientData['identity'],
              hintText: 'Ingrese nueva cedula/RUC/pasaporte',
              icon: Icons.credit_card,
              isPassword: false,
              isDigit: false,
            ),
            ShowInfo(
              controller: _phoneController,
              name: 'Telefono',
              labelText: widget.clientData['phone'],
              hintText: 'Ingrese nuevo telefono',
              icon: Icons.phone,
              isPassword: false,
              isDigit: true,
            ),
            ShowInfo(
              controller: _priceController,
              name: 'Precio a pagar',
              labelText: widget.clientData['total_price'],
              hintText: 'Ingrese nuevo precio a pagar',
              icon: Icons.attach_money,
              isPassword: false,
              isDigit: true,
            ),
            ShowInfo(
              controller: _dateController,
              name: 'Fecha de instalacion',
              labelText: widget.clientData['date_instalation'],
              hintText: 'Ingrese nueva fecha de instalacion',
              icon: Icons.date_range,
              isPassword: false,
              isDigit: true,
            ),
            ShowInfo(
              controller: _partOfDayController,
              name: 'Turno',
              labelText: widget.clientData['part_of_day'],
              hintText: 'Ingrese nuevo turno',
              icon: Icons.access_time,
              isPassword: false,
              isDigit: false,
            ),
            ShowInfo(
              controller: _statusInstalationController,
              name: 'Estado de instalacion',
              labelText: widget.clientData['status_instalation'] ?? 'Pendiente',
              hintText: 'Ingrese nuevo estado de instalacion',
              icon: Icons.check_circle,
              isPassword: false,
              isDigit: false,
            ),
            ShowInfo(
              controller: _isAcceptedController,
              name: 'Aceptado por el manager',
              labelText: widget.clientData['is_accepted_by_manager'],
              hintText: 'Ingrese si fue aceptado por el manager',
              icon: Icons.check_circle,
              isPassword: false,
              isDigit: false,
            ),
            ShowInfo(
              controller: _optionsToInstallController,
              name: 'Opciones de instalacion',
              labelText: widget.clientData['options_to_give_instalation'],
              hintText: 'Ingrese nuevas opciones de instalacion',
              icon: Icons.check_circle,
              isPassword: false,
              isDigit: false,
            ),
            const SizedBox(height: 10),
            const Text(
              'Foto del recibo de pago',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Image.network(
              widget.clientData['photo_reciept'],
              width: 380,
              height: 380,
            ),
          ],
        ),
      ),
    );
  }
}
