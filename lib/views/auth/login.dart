import 'package:flutter/material.dart';
import 'package:gestion_ambiental_2/controller/auth_controller.dart';
import 'package:gestion_ambiental_2/views/auth/register.dart';
import 'package:gestion_ambiental_2/views/widget/avatar.dart';
import 'package:gestion_ambiental_2/views/widget/input.dart';
import 'package:gestion_ambiental_2/views/widget/snackbar.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController txtUsername = TextEditingController();
    TextEditingController txtPassword = TextEditingController();

    // Obtener el ancho de la pantalla
    double screenWidth = MediaQuery.of(context).size.width;

    // Definir si se debe usar un Card o no
    bool isWideScreen = screenWidth > 580;

    return Scaffold(
      body: Center(
        child: isWideScreen
            ? Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 500,
                  width: screenWidth * 0.4, // Ancho del 40% de la pantalla

                  padding: const EdgeInsets.all(16.0),
                  child: _buildLoginForm(txtUsername, txtPassword),
                ),
              )
            : _buildLoginForm(txtUsername, txtPassword),
      ),
    );
  }

  Widget _buildLoginForm(
      TextEditingController txtUsername, TextEditingController txtPassword) {
    AuthController controlu = Get.put(AuthController());
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomAvatar(
          radius: 50,
          backgroundColor: Colors.purple,
          icon: Icons.person,
          iconColor: Colors.yellow,
        ),
        InputText(
          controlador: txtUsername,
          titulo: 'Username',
          icono: Icons.person,
        ),
        InputText(
          controlador: txtPassword,
          titulo: 'Password',
          isPassword: true,
          icono: Icons.lock,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                if (txtUsername.text.isEmpty || txtPassword.text.isEmpty) {
                  showModernSnackbar(
                    title: 'Registro!',
                    message: 'Datos Incompletos',
                    icon: Icons.cancel,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    iconColor: Colors.white,
                  );
                } else {
                  controlu.loginUser(txtUsername.text, txtPassword.text);
                }
              },
              child: const Text('Login')),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              onPressed: () {
                Get.toNamed('/register');
              },
              child: const Text('Registrarse')),
        ),
      ],
    );
  }
}
