import 'package:chat_application_with_backend_practice1/theme.dart';
import 'package:flutter/material.dart';

class GlowingActionButton extends StatelessWidget {

  final Color color;
  final IconData icon;
  final double size;
  final VoidCallback onPressed;

  const GlowingActionButton({ Key? key, required this.color, required this.icon, this.size = 54.0, required this.onPressed }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            spreadRadius: 10.0,
            blurRadius: 24.0,
          ),                  
        ]
      ),
      child: ClipOval(
        child: Material(
          color: color,
          child: InkWell(
            splashColor: AppColors.cardLight,
            onTap: onPressed,
            child: SizedBox(
              width: size,
              height: size,
              child: Icon(
                icon,
                size: 26.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}