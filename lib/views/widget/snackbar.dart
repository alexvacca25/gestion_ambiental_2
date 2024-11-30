import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showModernSnackbar({
  required String title,
  required String message,
  IconData? icon = Icons.info,
  Color backgroundColor = Colors.blue,
  Color textColor = Colors.white,
  Color iconColor = Colors.white,
}) {
  Get.snackbar(
    title,
    message,
    icon: Icon(
      icon,
      color: iconColor,
      size: 28,
    ),
    snackPosition: SnackPosition.TOP, // Puedes cambiar a BOTTOM si prefieres.
    backgroundColor: backgroundColor,
    colorText: textColor,
    borderRadius: 16.0,
    margin: const EdgeInsets.all(16.0),
    padding: const EdgeInsets.all(16.0),
    duration: const Duration(seconds: 3),
    animationDuration: const Duration(milliseconds: 500),
    barBlur: 10.0,
    isDismissible: true,
    forwardAnimationCurve: Curves.easeOutBack,
    reverseAnimationCurve: Curves.easeInBack,
  );
}
