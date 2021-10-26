import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class Flushbars {
  error(BuildContext context, String message) {
    Flushbar(
      messageText: Text(message,
          style: const TextStyle(color: Colors.white)),
      icon: const Icon(
        Icons.error_outline,
        size: 28.0,
        color: Color(0xFFCB0447),
      ),
      shouldIconPulse: true,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      duration: const Duration(seconds: 3),
      borderColor: Colors.white.withOpacity(0.04),
      borderWidth: 1,
      backgroundColor: Colors.black12,
      flushbarStyle: FlushbarStyle.FLOATING,
      isDismissible: true,
      barBlur: 8,
      margin:const EdgeInsets.only(bottom: 20, left: 8, right: 8),
      borderRadius: BorderRadius.circular(15),
    ).show(context);
  }
}
