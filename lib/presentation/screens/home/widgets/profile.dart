import 'package:flutter/material.dart';


class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {

        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
              8),
          child: Image.asset(
            'assets/images/avatar.png',
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
