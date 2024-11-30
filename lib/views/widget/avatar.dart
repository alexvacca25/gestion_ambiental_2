import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    super.key,
    this.radius = 50,
    this.icon = Icons.person,
    this.iconSize,
    this.backgroundColor = Colors.blue,
    this.iconColor = Colors.white,
    this.imageUrl,
  });

  final double radius; // Radio del avatar.
  final IconData icon; // Ícono por defecto si no hay imagen.
  final double? iconSize; // Tamaño del ícono.
  final Color backgroundColor; // Color de fondo.
  final Color iconColor; // Color del ícono.
  final String? imageUrl; // URL de la imagen (opcional).

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      backgroundImage: imageUrl != null
          ? NetworkImage(imageUrl!)
          : null, // Muestra la imagen si hay URL.
      child: imageUrl == null
          ? Icon(
              icon,
              size: iconSize ??
                  radius * 0.9, // Escala el tamaño del ícono según el radio.
              color: iconColor,
            )
          : null, // No muestra el ícono si hay una imagen.
    );
  }
}
