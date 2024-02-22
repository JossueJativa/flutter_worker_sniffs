// ignore_for_file: library_private_types_in_public_api, unused_field

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_worker_sniffs/controller/async_ulr.dart';
import 'package:flutter_worker_sniffs/models/appbar_bottonbar.dart';
import 'package:flutter_worker_sniffs/models/buttons.dart';
import 'package:flutter_worker_sniffs/models/inputs.dart';

class WorkerScreen extends StatefulWidget {
  final Map<String, dynamic> workerData;
  const WorkerScreen({super.key, required this.workerData});

  @override
  _WorkerScreenState createState() => _WorkerScreenState();
}

class _WorkerScreenState extends State<WorkerScreen> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerIdentity = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerPhoto = TextEditingController();
  File? _selectedImage;
  late File _imageFile;
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _controllerName.text = widget.workerData['user']['first_name'];
    _controllerLastName.text = widget.workerData['user']['last_name'];
    _controllerUsername.text = widget.workerData['user']['username'];
    _controllerEmail.text = widget.workerData['user']['email'];
    _controllerIdentity.text = widget.workerData['user']['identity'];
    _controllerPhone.text = widget.workerData['user']['phone'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppbarMenu(
          name: widget.workerData['user']['username'],
        ),
      ),
      body: Container(
        color: const Color(0xff040d26),
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            ShowInfo(
              name: 'Nombre',
              labelText: widget.workerData['user']['first_name'],
              hintText: 'Ingrese nuevo nombre',
              isPassword: false,
              controller: _controllerName,
              icon: Icons.person,
              isDigit: false,
            ),
            ShowInfo(
              name: 'Apellido',
              labelText: widget.workerData['user']['last_name'],
              hintText: 'Ingrese nuevo apellido',
              isPassword: false,
              controller: _controllerLastName,
              icon: Icons.person,
              isDigit: false,
            ),
            ShowInfo(
              name: 'Usuario',
              labelText: widget.workerData['user']['username'],
              hintText: 'Ingrese nuevo usuario',
              isPassword: false,
              controller: _controllerUsername,
              icon: Icons.person,
              isDigit: false,
            ),
            ShowInfo(
              name: 'Correo',
              labelText: widget.workerData['user']['email'],
              hintText: 'Ingrese nuevo correo',
              isPassword: false,
              controller: _controllerEmail,
              icon: Icons.email,
              isDigit: false,
            ),
            ShowInfo(
              name: 'Cédula',
              labelText: widget.workerData['user']['identity'],
              hintText: 'Ingrese nueva cédula',
              isPassword: false,
              controller: _controllerIdentity,
              icon: Icons.credit_card,
              isDigit: true,
            ),
            ShowInfo(
              name: 'Teléfono',
              labelText: widget.workerData['user']['phone'],
              hintText: 'Ingrese nuevo teléfono',
              isPassword: false,
              controller: _controllerPhone,
              icon: Icons.phone,
              isDigit: true,
            ),
            // InputImage(
            //   hintText: 'Ingrese nueva foto',
            //   labelText: 'Foto del trabajador',
            //   onImageSelected: (image) {
            //     setState(() {
            //       _selectedImage = image;
            //     });
            //   },
            //   image: _selectedImage,
            // ),
            if (_selectedImage == null)
              Image.network(widget.workerData['photo'],
                  width: 380, height: 380),

            const SizedBox(height: 10),
            normalButton(
              color: Colors.green,
              text: 'Actualizar',
              textColor: Colors.white,
              onPressed: () {
                File? file;
                Map<String, dynamic> data = {
                  'first_name': _controllerName.text,
                  'last_name': _controllerLastName.text,
                  'email': _controllerEmail.text,
                  'identity': _controllerIdentity.text,
                  'phone': _controllerPhone.text,
                };

                if (_selectedImage != null) {
                  file = File(_selectedImage!.path);
                } else {
                  file = null;
                }

                update_worker(
                  'api/user/',
                  widget.workerData['user']['id'].toString(),
                  data,
                  context,
                  file,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
