import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final Icon? icon;
  final Color? color;
  final VoidCallback? onTap;
  final bool? disableFeedback;
  const Button({
    super.key,
    required this.title,
    this.icon,
    this.color,
    this.onTap,
    this.disableFeedback = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      child: InkWell(
        splashFactory: disableFeedback!
            ? NoSplash.splashFactory
            : InkRipple.splashFactory,
        onTap: onTap,
        borderRadius: BorderRadius.circular(100),
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 12, vertical: 8),
          child: Text(title, style: ,),
        ),
      ),
    );
  }
}
