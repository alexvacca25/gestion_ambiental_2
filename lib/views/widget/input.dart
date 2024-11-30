import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  const InputText({
    super.key,
    required this.controlador,
    required this.titulo,
    this.isPassword = false,
    this.icono,
  });

  final TextEditingController controlador;
  final String titulo;
  final bool isPassword; // Si es true, oculta el texto.
  final IconData? icono; // Icono opcional para el TextField.

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controlador,
        obscureText: isPassword, // Oculta el texto si es una contraseña.
        decoration: InputDecoration(
          labelText: titulo,
          prefixIcon: icono != null ? Icon(icono) : null, // Agrega un ícono si está presente.
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0), // Bordes redondeados.
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: Colors.blue, // Color del borde al enfocarse.
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
