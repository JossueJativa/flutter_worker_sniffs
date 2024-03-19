// ignore_for_file: use_super_parameters, must_be_immutable

import 'package:flutter/material.dart';

class AppbarMenu extends StatelessWidget {
  final String name;
  final String email;
  const AppbarMenu({
    super.key,
    required this.name, required this.email,
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
            Navigator.pushNamed(
              context,
              '/ticket',
              arguments: email,
            );
          }, 
          icon: const Icon(Icons.question_mark, color: Colors.white)
        ),
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

class BottonbarMenuCallcenter extends StatelessWidget {
  final Map<String, dynamic> data;
  final int currentPage;

  const BottonbarMenuCallcenter({Key? key, required this.data, required this.currentPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xffb6955f),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Ver Clientes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Agregar Pedido',
        ),
      ],
      currentIndex: currentPage,
      selectedItemColor: Colors.white, // Color para el ícono de la página seleccionada
      unselectedItemColor: Colors.black, // Color para el ícono de la página no seleccionada
      onTap: (int index) {
        if (index == 0) {
          Navigator.popAndPushNamed(context, '/callcenter', arguments: data);
        } else if (index == 1) {
          Navigator.popAndPushNamed(context, '/createclient', arguments: data);
        }
      },
    );
  }
}

class UpdateData extends StatelessWidget {
  final Map<String, dynamic> data;
  final String page;
const UpdateData({ Key? key, required this.data, required this.page }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return FloatingActionButton(
      onPressed: () {
        Navigator.popAndPushNamed(context, page, arguments: data);
      },
      backgroundColor: const Color(0xff10205c),
      child: const Icon(Icons.refresh, color: Colors.white),
    );
  }
}