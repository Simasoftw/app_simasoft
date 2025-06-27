import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  final int notificationCount;
  final VoidCallback onTap;

  const NotificationIcon({
    super.key,
    this.notificationCount = 0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade200, // Fondo del icono
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: Offset(2, 2),
                )
              ],
            ),
            child: Icon(
              Icons.notifications_none_outlined, // Ícono más estilizado
              color: Colors.deepPurple,           // Color del ícono
              size: 28,
            ),
          ),
        ),
        if (notificationCount > 0)
          Positioned(
            top: 4,
            right: 4,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$notificationCount',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
      ],
    );
  }
}
