// ignore_for_file: non_constant_identifier_names, camel_case_types, use_super_parameters, library_private_types_in_public_api, must_be_immutable, unnecessary_null_comparison

import 'package:flutter/material.dart';

class inputInfo extends StatefulWidget {
  final String labelText;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;

  const inputInfo({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.isPassword,
    required this.controller,
  }) : super(key: key);

  @override
  _inputInfoState createState() => _inputInfoState();
}

class _inputInfoState extends State<inputInfo> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelText,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: widget.labelText,
              labelStyle: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintText: widget.hintText,
              fillColor: Colors.white,
              filled: true,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : const Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
            ),
            obscureText: widget.isPassword ? _obscureText : false,
            controller: widget.controller,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class DataInfo extends StatefulWidget {
  final String labelText;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final IconData icon;
  final bool isDigit;

  const DataInfo({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.isPassword,
    required this.controller,
    required this.icon,
    required this.isDigit,
  }) : super(key: key);

  @override
  _DataInfoState createState() => _DataInfoState();
}

class _DataInfoState extends State<DataInfo> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelText,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            keyboardType:
                widget.isDigit ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: widget.labelText,
              labelStyle: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintText: widget.hintText,
              fillColor: Colors.white,
              filled: true,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : Icon(
                      widget.icon,
                      color: Colors.black,
                    ),
            ),
            controller: widget.controller,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
            obscureText: widget.isPassword ? _obscureText : false,
          ),
        ],
      ),
    );
  }
}

class SearchInput extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  final bool isDigit;
  final VoidCallback callback;

  const SearchInput({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.icon,
    required this.isDigit,
    required this.callback,
  }) : super(key: key);

  @override
  _SearchInputState createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff040d26),
      padding: const EdgeInsets.all(10),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
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
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: widget.isDigit
                          ? TextInputType.number
                          : TextInputType.text,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: widget.hintText,
                        labelStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: widget.hintText,
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      controller: widget.controller,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 60,
                    height: 65,
                    child: FloatingActionButton(
                      onPressed: () {
                        widget.callback();
                      },
                      backgroundColor: Colors.white,
                      child: const Icon(Icons.search),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShowInfo extends StatefulWidget {
  final String name;
  final String labelText;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final IconData icon;
  final bool isDigit;
  final bool isDate;

  const ShowInfo({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.isPassword,
    required this.controller,
    required this.icon,
    required this.isDigit,
    required this.name,
    required this.isDate,
  }) : super(key: key);

  @override
  _ShowInfoState createState() => _ShowInfoState();
}

class _ShowInfoState extends State<ShowInfo> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            keyboardType: widget.isDigit
                ? TextInputType.number
                : (widget.isDate
                    ? TextInputType.datetime
                    : TextInputType.text),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: widget.labelText,
              labelStyle: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintText: widget.hintText,
              fillColor: Colors.white,
              filled: true,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : InkWell(
                      onTap: () {
                        if (widget.isDate) {
                          _selectDate(context);
                        }
                      },
                      child: Icon(
                        widget.icon,
                        color: Colors.black,
                      ),
                    ),
            ),
            controller: widget.controller,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
            obscureText: widget.isPassword ? _obscureText : false,
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? initialDate = DateTime.now();

    if (widget.controller.text.isNotEmpty) {
      try {
        initialDate = DateTime.parse(widget.controller.text);
      } catch (e) {
        print("Error parsing date: $e");
      }
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate!,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        // Formateamos la fecha seleccionada para mostrar solo la fecha sin la hora
        widget.controller.text = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }
}
