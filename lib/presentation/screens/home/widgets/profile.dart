import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../perfil/perfil_screen.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () { 
          Get.to(() => PerfilScreen()); 
        },
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
                50),
            child: Image.asset(
              'assets/images/avatar.png',
              width: 115,
              height: 115,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
