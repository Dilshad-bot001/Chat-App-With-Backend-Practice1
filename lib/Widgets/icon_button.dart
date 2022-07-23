import 'package:chat_application_with_backend_practice1/theme.dart';
import 'package:flutter/material.dart';

class IconBackground extends StatelessWidget {

  final IconData icon;
  final VoidCallback onTap;

  const IconBackground({ Key? key, required this.icon, required this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(6.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(6.0),
        splashColor: AppColors.secondary,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(
            icon,
            size: 18.0,
          ),
        ),
      ),
    );
  }
}

class IconBorder extends StatelessWidget {

  final IconData icon;
  final VoidCallback onTap;

  const IconBorder({ Key? key, required this.icon, required this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(6.0),
      splashColor: AppColors.secondary,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(
            width: 2.0,
            color: Theme.of(context).cardColor,
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            icon,
            size: 16.0,
          ),
        ),
      ),
    );
  }
}