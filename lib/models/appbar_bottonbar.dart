// ignore_for_file: use_super_parameters, must_be_immutable

import 'package:flutter/material.dart';

class AppbarMenu extends StatelessWidget {
  final String name;

  const AppbarMenu({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xff10205c),
      title: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/');
          },
          icon: const Icon(Icons.logout, color: Colors.white),
        ),
      ],
    );
  }
}

class BottonbarMenu extends StatelessWidget {
  final Map<String, dynamic> data;
  final int currentPage;

  const BottonbarMenu({Key? key, required this.data, required this.currentPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xffb6955f),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Agregar Trabajador',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.backpack),
          label: 'Ver trabajadores',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Ver Clientes',
        ),
      ],
      currentIndex: currentPage,
      selectedItemColor:
          Colors.white, // Color para el ícono de la página seleccionada
      unselectedItemColor:
          Colors.black, // Color para el ícono de la página no seleccionada
      onTap: (int index) {
        if (index == 0) {
          Navigator.popAndPushNamed(context, '/manager', arguments: data);
        } else if (index == 1) {
          Navigator.popAndPushNamed(context, '/workers', arguments: data);
        } else if (index == 2) {
          Navigator.popAndPushNamed(context, '/clients', arguments: data);
        }
      },
    );
  }
}