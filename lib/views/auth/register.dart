import 'package:flutter/material.dart';
import 'package:gestion_ambiental_2/controller/auth_controller.dart';
import 'package:gestion_ambiental_2/views/widget/avatar.dart';
import 'package:gestion_ambiental_2/views/widget/input.dart';
import 'package:gestion_ambiental_2/views/widget/snackbar.dart';
import 'package:get/get.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController txtUsername = TextEditingController();
    TextEditingController txtPassword1 = TextEditingController();
    TextEditingController txtPassword2 = TextEditingController();

    // Obtener el ancho de la pantalla
    double screenWidth = MediaQuery.of(context).size.width;

    // Validar si la pantalla es ancha
    bool isWideScreen = screenWidth > 580;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Usuarios'),
      ),
      body: Center(
        child: isWideScreen
            ? Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 500,
                  width: screenWidth * 0.4, // Ancho del 40% de la pantalla
                  padding: const EdgeInsets.all(16.0),
                  child: _buildRegisterForm(
                      txtUsername, txtPassword1, txtPassword2),
                ),
              )
            : _buildRegisterForm(txtUsername, txtPassword1, txtPassword2),
      ),
    );
  }

  Widget _buildRegisterForm(TextEditingController txtUsername,
      TextEditingController txtPassword1, TextEditingController txtPassword2) {
    AuthController controluser = Get.put(AuthController());
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomAvatar(
          radius: 50,
          icon: Icons.person,
          backgroundColor: Colors.green,
          iconColor: Colors.white,
        ),
        InputText(
          controlador: txtUsername,
          titulo: 'Username',
          icono: Icons.person,
        ),
        InputText(
          controlador: txtPassword1,
          titulo: 'Password',
          isPassword: true,
          icono: Icons.lock,
        ),
        InputText(
          controlador: txtPassword2,
          titulo: 'Confirm Password',
          isPassword: true,
          icono: Icons.lock,
        ),
        ElevatedButton(
            onPressed: () {
              if (txtUsername.text.isEmpty) {
                showModernSnackbar(
                  title: 'Registro!',
                  message: 'Ingrese un Usuario',
                  icon: Icons.cancel,
                  backgroundColor: Colors.yellow,
                  textColor: Colors.white,
                  iconColor: Colors.white,
                );
              } else if (txtPassword1.text != txtPassword2.text ||
                  txtPassword1.text.isEmpty ||
                  txtPassword2.text.isEmpty) {
                showModernSnackbar(
                  title: 'Registro!',
                  message: 'Las Contraseñas No Coinciden',
                  icon: Icons.cancel,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  iconColor: Colors.white,
                );
              } else {
               controluser.registerUser(txtUsername.text, txtPassword1.text);
              }
            },
            child: const Text("Registrarse")),
      ],
    );
  }
}
