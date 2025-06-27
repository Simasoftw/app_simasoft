import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:app_simasoft/presentation/screens/home/home_screen.dart';

class AlertScreen extends StatelessWidget {
  final VoidCallback? funcion;
  final String title;
  final String message;
  final IconData icon;
  final Color colorIcon;

  const AlertScreen({
    Key? key,
    this.funcion,
    required this.message,
    required this.title,
    required this.icon,
    required this.colorIcon,
  }) : super(key: key);

  void mostrarAlertaIOS(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenWidth * 0.12;

    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Column(
            children: [
              Icon(icon, color: colorIcon, size: iconSize),
              const SizedBox(height: 10),
              Text(title, textAlign: TextAlign.center),
            ],
          ),
          content: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          actions: [
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Cancelar'),
              onPressed: () => Navigator.pop(context),
            ),
            CupertinoDialogAction(
              child: const Text('Aceptar'),
              onPressed: () {
                if (funcion != null) funcion!();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  void mostrarAlertaAndroid(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenWidth * 0.2;

    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(title, textAlign: TextAlign.center),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: colorIcon, size: iconSize),
                const SizedBox(height: 10),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                if (funcion != null) funcion!();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  void mostrarAlerta(BuildContext context) {
    if (Platform.isIOS) {
      mostrarAlertaIOS(context);
    } else {
      mostrarAlertaAndroid(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mostrarAlerta(context);
    });
    return const SizedBox.shrink(); // Widget invisible
  }
}
