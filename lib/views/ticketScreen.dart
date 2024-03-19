// ignore_for_file: file_names, library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_worker_sniffs/controller/async_url_workers.dart';
import 'package:flutter_worker_sniffs/models/appbar_bottonbar.dart';
import 'package:flutter_worker_sniffs/models/buttons.dart';
import 'package:flutter_worker_sniffs/models/inputs.dart';

class TicketScreen extends StatefulWidget {
  final String email;
  const TicketScreen({ super.key, required this.email});

  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  File? _selectedImage;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppbarMenu(
          name: "Creacion de ticket",
          email: widget.email,
        ),
      ),
      body: Container(
        color: const Color(0xff040d26),
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DataInfo(
                labelText: 'Email de la persona que reporta el problema',
                hintText: 'Email',
                isPassword: false,
                controller: _emailController,
                icon: Icons.email,
                isDigit: false,
              ),
              DropdownFuture(
                controller: _typeController,
                text: 'Tipo de problema',
              ),
              DropDownMenuCallcenter(
                text: 'Seleccione el usuario con el problema', 
                controller: _userController, 
                value1: 'Manager', 
                value2: 'Tecnico', 
                valueSelected: 'Callcenter',
              ),
              TextArea(
                labelText: 'Descripcion del problema',
                hintText: 'Descripcion',
                controller: _descriptionController,
              ),
              InputImage(
                hintText: 'Ingrese foto del recibo',
                labelText: 'Foto del recibo',
                onImageSelected: (image) {
                  setState(() {
                    _selectedImage = image;
                  });
                },
                image: _selectedImage,
              ),
              const SizedBox(height: 55),
            ],
          ),
        ),
      ),
      // Boton para enviar el ticket
      bottomNavigationBar: Container(
        color: const Color(0xff040d26),
        padding: const EdgeInsets.all(10),
        child: normalButton(
          text: 'Crear ticket',
          onPressed: () async {
            bool isValid = true;
            isValid = isValid && _emailController.text.isNotEmpty;
            isValid = isValid && _descriptionController.text.isNotEmpty;
            isValid = isValid && _typeController.text.isNotEmpty;
            isValid = isValid && _userController.text.isNotEmpty;
            if (!isValid) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Por favor llene todos los campos'),
                ),
              );
              return;
            }

            String typeId = _typeController.text.split(' - ')[0];
            if (_userController == 'Manager') {
              _userController.text = 'manager';
            } else if (_userController == 'Tecnico') {
              _userController.text = 'tecnic';
            } else {
              _userController.text = 'callcenter';
            }

            Map<String, dynamic> data = {
              'user_with_problem': _emailController.text,
              'description': _descriptionController.text,
              'type_user': _userController.text,
              'problem': typeId
            };

            await createTicket(
              'api/problems_tikets/',
              data,
              _selectedImage!,
              context,
            );
          },
          color: Colors.green,
          textColor: Colors.white,
        ),
      ),
    );
  }
}