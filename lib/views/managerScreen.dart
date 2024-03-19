// Importaciones necesarias
// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously, file_names, library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_worker_sniffs/controller/async_ulr.dart';
import 'package:flutter_worker_sniffs/models/appbar_bottonbar.dart';
import 'package:flutter_worker_sniffs/models/buttons.dart';
import 'package:flutter_worker_sniffs/models/inputs.dart';
import 'package:flutter_worker_sniffs/services/notification_services.dart';

class ManagerScreen extends StatefulWidget {
  // Datos del usuario
  final Map<String, dynamic> data;

  // Constructor de la pantalla del gerente
  const ManagerScreen({super.key, required this.data});

  @override
  _ManagerScreenState createState() => _ManagerScreenState();
}

class _ManagerScreenState extends State<ManagerScreen> {
  // Controladores de texto para los campos de entrada
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  File? _selectedImage;

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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Crear Usuario",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                    decorationThickness: 2,
                  ),
                ),
                // Campos de entrada para los datos del usuario
                DataInfo(
                  labelText: "Nombre/s",
                  hintText: "Ingresar el nombre del trabajador",
                  icon: Icons.person,
                  controller: _nameController,
                  isPassword: false,
                  isDigit: false,
                ),
                DataInfo(
                  labelText: "Apellido/s",
                  hintText: "Ingresar el apellido del trabajador",
                  icon: Icons.person,
                  controller: _lastNameController,
                  isPassword: false,
                  isDigit: false,
                ),
                DataInfo(
                  labelText: "Email",
                  hintText: "Ingresar el email del trabajador",
                  icon: Icons.email,
                  controller: _emailController,
                  isPassword: false,
                  isDigit: false,
                ),
                DataInfo(
                  labelText: "Celular",
                  hintText: "Ingresar el celular del trabajador",
                  icon: Icons.phone,
                  controller: _phoneController,
                  isPassword: false,
                  isDigit: true,
                ),
                DataInfo(
                  labelText: "Cédula/RUC/Pasaporte",
                  hintText: "Ingresar el identificador del trabajador",
                  icon: Icons.perm_identity,
                  controller: _idController,
                  isPassword: false,
                  isDigit: true,
                ),
                DataInfo(
                  labelText: "Contraseña temporal",
                  hintText: "Ingresar el apellido del trabajador",
                  icon: Icons.password,
                  controller: _passwordController,
                  isPassword: true,
                  isDigit: false,
                ),
                DataInfo(
                  labelText: "Confirmar contraseña temporal",
                  hintText: "Ingresar el apellido del trabajador",
                  icon: Icons.password,
                  controller: _confirmPasswordController,
                  isPassword: true,
                  isDigit: false,
                ),
                const Text(
                  "Asignar tipo de trabajador",
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
                // Menú desplegable para seleccionar el tipo de trabajador
                DropDownMenuManager(
                  text: "Seleccione el tipo de trabajador",
                  controller: _typeController,
                ),
                const SizedBox(height: 20),
                // Widget para cargar una imagen
                InputImage(
                  hintText: "Subir foto del trabajador",
                  labelText: "Foto del trabajador",
                  onImageSelected: (image) {
                    setState(() {
                      _selectedImage = image;
                    });
                  },
                  image: _selectedImage,
                ),
                const SizedBox(height: 20),
                // Botón para registrar el usuario
                normalButton(
                  text: 'Registrar Usuario',
                  onPressed: () async {
                    // Validar todos los campos
                    bool isValid = true;
                    isValid = isValid && _nameController.text.isNotEmpty;
                    isValid = isValid && _lastNameController.text.isNotEmpty;
                    isValid = isValid && _emailController.text.isNotEmpty;
                    isValid = isValid && _phoneController.text.isNotEmpty;
                    isValid = isValid && _idController.text.isNotEmpty;
                    isValid = isValid && _passwordController.text.isNotEmpty;
                    isValid =
                        isValid && _confirmPasswordController.text.isNotEmpty;
                    isValid = isValid && _typeController.text.isNotEmpty;
                    isValid = isValid && _selectedImage != null;

                    // Si algún campo no está lleno, mostrar mensaje de error
                    if (!isValid) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Todos los campos deben estar llenos'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      Map<String, dynamic> response = await create_user_api(
                        url: '/api/user/',
                        firstName: _nameController.text,
                        lastName: _lastNameController.text,
                        email: _emailController.text,
                        phone: _phoneController.text,
                        password: _passwordController.text,
                        id: _idController.text,
                      );

                      if (response['status']) {
                        if (_typeController.text == "Call Center") {
                          bool createResponse = await createCallCenter(
                              _selectedImage!,
                              response['data']['id'].toString(),
                              'api/callcenter/');
                          if (createResponse) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Usuario creado con éxito'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            sendNotification(
                              'manager',
                              'Se ha creado un nuevo trabajador',
                              'callcenter: ${_nameController.text} ${_lastNameController.text}'
                            );
                            Navigator.popAndPushNamed(context, '/manager',
                                arguments: widget.data);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Error al crear el usuario'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } else if (_typeController.text == "Técnico") {
                          bool createResponse = await createTecnic(
                              _selectedImage!,
                              response['data']['id'].toString(),
                              'api/tecnic/'
                          );

                          if (createResponse) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Usuario creado con éxito'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            sendNotification(
                              'manager',
                              'Se ha creado un nuevo trabajador',
                              'tecnic: ${_nameController.text} ${_lastNameController.text}'
                            );
                            Navigator.popAndPushNamed(context, '/manager',
                                arguments: widget.data);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Error al crear el usuario'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }else {
                          
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Error al crear el usuario'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  color: Colors.green,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottonbarMenu(
        data: widget.data,
        currentPage: 0,
      ),
    );
  }
}
