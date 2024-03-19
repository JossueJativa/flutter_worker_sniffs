// ignore_for_file: must_be_immutable, library_private_types_in_public_api, use_super_parameters

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

ElevatedButton normalButton({
  required String text,
  required VoidCallback onPressed,
  required Color color,
  required Color textColor,
}) {
  return ElevatedButton(
    onPressed: () {
      onPressed();
    },
    style: ElevatedButton.styleFrom(
      maximumSize: const Size(350, 50),
      minimumSize: const Size(350, 50),
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 20, color: textColor),
    ),
  );
}

class InputImage extends StatefulWidget {
  final String labelText;
  final String hintText;
  final dynamic
      image; // Cambié el tipo de File a dynamic para manejar tanto File como String
  final Function(dynamic)?
      onImageSelected; // Cambié el tipo de File a dynamic para manejar tanto File como String

  const InputImage(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.image,
      this.onImageSelected});

  @override
  _InputImageState createState() => _InputImageState();
}

class _InputImageState extends State<InputImage> {
  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        widget.onImageSelected!(File(pickedFile
            .path)); // Notificar al padre que se ha seleccionado una imagen
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.labelText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 380,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Seleccionar fuente de imagen"),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          GestureDetector(
                            child: const Text("Tomar foto"),
                            onTap: () {
                              Navigator.pop(context);
                              _getImage(ImageSource.camera);
                            },
                          ),
                          const Padding(padding: EdgeInsets.all(8.0)),
                          GestureDetector(
                            child: const Text("Seleccionar de galería"),
                            onTap: () {
                              Navigator.pop(context);
                              _getImage(ImageSource.gallery);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Row(
              children: [
                Text(
                  widget.hintText,
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),
                const Spacer(),
                const Icon(Icons.image, color: Colors.black),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        if (widget.image != null) // Verificar si hay una imagen
          SizedBox(
            width: 380,
            height: 380,
            child:
                (widget.image is File) // Verificar si la imagen es de tipo File
                    ? Image.file(
                        widget.image as File,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        widget.image
                            as String, // Si no es de tipo File, asumimos que es una URL de red
                        fit: BoxFit.cover,
                      ),
          ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class DropDownMenuManager extends StatefulWidget {
  String text;
  final TextEditingController controller;
  DropDownMenuManager(
      {super.key, required this.text, required this.controller});

  @override
  _DropDownMenuManagerState createState() => _DropDownMenuManagerState();
}

class _DropDownMenuManagerState extends State<DropDownMenuManager> {
  String valueChoosen = 'Seleccione';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(
                FocusNode()); // Para cerrar el teclado si está abierto
            _showDropDownMenu(context);
          },
          child: Container(
            height: 70,
            width: 380,
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    valueChoosen,
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.black),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showDropDownMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDropDownMenuItem('Seleccione'),
            _buildDropDownMenuItem('Técnico'),
            _buildDropDownMenuItem('Call Center'),
          ],
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          valueChoosen = value;
          widget.controller.text = value;
        });
      }
    });
  }

  Widget _buildDropDownMenuItem(String text) {
    return InkWell(
      onTap: () {
        Navigator.pop(context, text);
      },
      child: Container(
        width: 360,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15),
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class DropDownMenuCallcenter extends StatefulWidget {
  String text;
  String value1;
  String value2;
  String valueSelected;
  final TextEditingController controller;
  DropDownMenuCallcenter(
      {super.key, required this.text, required this.controller, required this.value1, required this.value2, required this.valueSelected});

  @override
  _DropDownMenuCallcenterState createState() => _DropDownMenuCallcenterState();
}

class _DropDownMenuCallcenterState extends State<DropDownMenuCallcenter> {
  String valueChoosen = 'Seleccione';

  @override
  void initState() {
    super.initState();
    valueChoosen = widget.valueSelected; // Establecer el valor seleccionado inicialmente
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(
                FocusNode()); // Para cerrar el teclado si está abierto
            _showDropDownMenu(context, widget.value1, widget.value2);
          },
          child: Container(
            height: 70,
            width: 380,
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    valueChoosen,
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.black),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showDropDownMenu(BuildContext context, String value1, String value2) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDropDownMenuItem('Seleccione'),
            _buildDropDownMenuItem(value1),
            _buildDropDownMenuItem(value2),
          ],
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          valueChoosen = value;
          widget.controller.text = value;
        });
      }
    });
  }

  Widget _buildDropDownMenuItem(String text) {
    return InkWell(
      onTap: () {
        Navigator.pop(context, text);
      },
      child: Container(
        width: 360,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15),
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class DropdownFuture extends StatefulWidget {
  final String text;
  final TextEditingController controller;
  const DropdownFuture({key, required this.text, required this.controller}) : super(key: key);

  @override
  _DropdownFutureState createState() => _DropdownFutureState();
}

class _DropdownFutureState extends State<DropdownFuture> {
  List<String> _list = [];
  List<int> _ids = [];
  String _value = 'Seleccione';

  @override
  void initState() {
    super.initState();
    _fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(
                FocusNode()); // Para cerrar el teclado si está abierto
            _showDropDownMenu(context);
          },
          child: Container(
            height: 70,
            width: 380,
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _value,
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.black),
              ],
            ),
          ),
        )
      ],
    );
  }

  Future<void> _fetchMessages() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/problems/'));
    if (response.statusCode == 200) {
      final List<String> messages = [];
      final List<int> ids = [];
      final data = json.decode(response.body);
      for (var message in data){
        ids.add(message['id']);
        messages.add("${message['title_description']} - ${utf8.decode(message['description'].runes.toList())}");
      }

      setState(() {
        _list = messages;
        _ids = ids;
      });
    } else {
      throw Exception('Failed to load messages');
    }
  }

  void _showDropDownMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < _list.length; i++) _buildDropDownMenuItem(_list[i], _ids[i]),
          ],
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          _value = value;
          widget.controller.text = value;
        });
      }
    });
  }

  Widget _buildDropDownMenuItem(String text, int id) {
    return InkWell(
      onTap: () {
        Navigator.pop(context, '$id - $text');
      },
      child: Container(
        width: 360,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15),
        child: Text(
          '$id - $text',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}