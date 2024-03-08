// ignore_for_file: library_private_types_in_public_api, use_super_parameters, file_names, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_worker_sniffs/controller/async_url_callcenter.dart';
import 'package:flutter_worker_sniffs/models/appbar_bottonbar.dart';
import 'package:flutter_worker_sniffs/models/buttons.dart';
import 'package:flutter_worker_sniffs/models/inputs.dart';
import 'package:flutter_worker_sniffs/models/tablesClass.dart';

class CreateClient extends StatefulWidget {
  final Map<String, dynamic> data;
  const CreateClient({ Key? key, required this.data }) : super(key: key);

  @override
  _CreateClientState createState() => _CreateClientState();
}

class _CreateClientState extends State<CreateClient> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _partOfDayController = TextEditingController();
  final TextEditingController _totalpriceController = TextEditingController();
  final TextEditingController _optionsToInstallController = TextEditingController();
  final List<TableInfoCheckbox> _list = [];
  File? _selectedImage;

  void setPriceProduts() {
    double total = 0;
    for (var item in _list) {
      total += double.parse(item.price);
    }
    total = total * 1.12;
    total = double.parse(total.toStringAsFixed(2));
    _totalpriceController.text = total.toString();
  }

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
                  "Crear Cliente",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                    decorationThickness: 2,
                  ),
                ),
                DataInfo(
                  labelText: "Nombre/s",
                  hintText: "Ingresar el nombre del cliente",
                  icon: Icons.person,
                  controller: _nameController,
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
                TableCheck(list: _list,),
                normalButton(
                  text: "Agregar productos", 
                  onPressed: () {
                    setPriceProduts();
                  }, 
                  color: Colors.white, 
                  textColor: Colors.black
                ),
                ShowInfo(
                  controller: _totalpriceController,
                  name: 'Precio a pagar',
                  labelText: 'Precio a pagar',
                  hintText: 'Ingrese el precio a pagar',
                  icon: Icons.monetization_on,
                  isPassword: false,
                  isDigit: true,
                  isDate: false,
                  readOnly: true,
                ),
                ShowInfo(
                  controller: _dateController,
                  name: 'Fecha de instalación',
                  labelText: 'Fecha de instalación',
                  hintText: 'Ingrese la fecha de instalación',
                  icon: Icons.date_range,
                  isPassword: false,
                  isDigit: false,
                  isDate: true,
                ),
                DropDownMenuCallcenter(
                  controller: _partOfDayController,
                  text: 'Seleccione parte del dia',
                  value1: 'mañana',
                  value2: 'tarde',
                  valueSelected: 'Seleccione',
                ),
                DropDownMenuCallcenter(
                  controller: _optionsToInstallController,
                  text: 'Seleccione opciones para instalar',
                  value1: 'Recoger',
                  value2: 'Delivery',
                  valueSelected: 'Seleccione',
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
                const SizedBox(height: 10),
                normalButton(
                  color: Colors.green,
                  text: 'Crear pedido',
                  textColor: Colors.white,
                  onPressed: () async {
                    bool isValid = true;
                    List<int> list = [];
                    File? photo = _selectedImage;
                    for (var item in _list) {
                      list.add(item.id);
                    }
                    isValid = isValid && _nameController.text.isNotEmpty;
                    isValid = isValid && _phoneController.text.isNotEmpty;
                    isValid = isValid && _idController.text.isNotEmpty;
                    isValid = isValid && _dateController.text.isNotEmpty;
                    isValid = isValid && _partOfDayController.text.isNotEmpty;
                    isValid = isValid && _optionsToInstallController.text.isNotEmpty;
                    isValid = isValid && _totalpriceController.text.isNotEmpty;
                    isValid = isValid && list.isNotEmpty;
                    if (!isValid) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Todos los campos son requeridos'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    //Convertir el date en YYYY-MM-DD
                    String dateString = _dateController.text;
                    List<String> parts = dateString.split('-');
                    if (parts.length == 3 && parts[1].length == 1) {
                      parts[1] = '0${parts[1]}';
                    }
                    String formattedDate = parts.join('-');
                    _dateController.text = formattedDate.substring(0, 10);

                    Map<String, dynamic> dataJson = {
                      "username": _nameController.text,
                      "phone": _phoneController.text,
                      "identity": _idController.text,
                      "date_instalation": _dateController.text, // Convertir DateTime a cadena ISO 8601
                      "part_of_day": _partOfDayController.text,
                      "options_to_give_instalation": _optionsToInstallController.text,
                      "total_price": _totalpriceController.text,
                      "products_bought": list,
                    };
                    bool isCreated = await createClient(
                      'api/client/', 
                      dataJson,
                      photo!,
                    );
                    if (isCreated) {
                      // Reinicio de los campos
                      _nameController.clear();
                      _phoneController.clear();
                      _idController.clear();
                      _dateController.clear();
                      _partOfDayController.clear();
                      _optionsToInstallController.clear();
                      _totalpriceController.clear();
                      _list.clear();
                      _selectedImage = null;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Cliente creado con éxito'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error al crear el cliente'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                )
              ]
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottonbarMenuCallcenter(
        data: widget.data,
        currentPage: 1,
      ),
    );
  }
}