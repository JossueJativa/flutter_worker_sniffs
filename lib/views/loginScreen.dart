// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:flutter_worker_sniffs/controller/async_ulr.dart';
import 'package:flutter_worker_sniffs/models/buttons.dart';
import 'package:flutter_worker_sniffs/models/inputs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ super.key });

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff040d26),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),

              Image.asset(
                'assets/icono-logo-fondo-azul.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 20),
              inputInfo(
                labelText: 'Email',
                hintText: 'Enter your email',
                controller: _emailController,
                isPassword: false,
              ),
              inputInfo(
                labelText: 'Password',
                hintText: 'Enter your password',
                isPassword: true,
                controller: _passwordController,
              ),

              const SizedBox(height: 50),
              normalButton(
                text: 'Iniciar Sección',
                onPressed: () async {
                  const url = 'api/user/login/';
                  Map<String, dynamic>? response = await login_api(_emailController.text, _passwordController.text, url: url);

                  if (response['status']) {
                    if(response['type'] == 'manager'){
                      Navigator.popAndPushNamed(context, '/manager', arguments: response['data']);
                    }else if (response['type'] == 'callcenter') {
                      Navigator.popAndPushNamed(context, '/callcenter', arguments: response['data']);
                    } else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('You are not a manager'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Invalid email or password'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                color: const Color(0xffcec4b6),
                textColor: Colors.black,
              ),

              const SizedBox(height: 20),
            ],
          ),
        )
      )
    );
  }
}