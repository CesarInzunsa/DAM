import 'package:flutter/material.dart';

import '../controller/credentialController.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: _drawLogin(),
      ),
    );
  }

  Widget _drawLogin() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            child: Icon(Icons.person_outline, size: 50),
          ),
          const SizedBox(height: 20),
          _drawForm(),
          const SizedBox(height: 20),
          _drawButtons(),
        ],
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  Widget _drawForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
              controller: _userController,
              decoration: const InputDecoration(
                labelText: 'usuario',
                suffixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese su usuario';
                }
                return null;
              }),
          const SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'password',
              suffixIcon: Icon(Icons.lock),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingrese su password';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  void checkCredentials() async {
    bool value = await CredentialController.checkCredentials(
        _userController.text, _passwordController.text);

    if (value) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Home(
            user: _userController.text,
            password: _passwordController.text,
          ),
        ),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario o contraseña incorrectos')),
      );
      Navigator.pop(context);
    }
  }

  Widget _drawButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              checkCredentials();
            }
          },
          child: const Text('Ingresar'),
        ),
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Olvidé mi contraseña')),
            );
          },
          child: const Text('Crear cuenta'),
        ),
      ],
    );
  }
}
