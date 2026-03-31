import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? trailing;
  final VoidCallback? onLeadingTap;

  final double height;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;

  const CustomAppBar({
    super.key,
    this.leading,
    this.title,
    this.trailing,
    this.onLeadingTap,
    this.height = 60,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: height,
          child: Padding(
            padding: padding,
            child: Row(
              children: [
                if (leading != null)
                  GestureDetector(onTap: onLeadingTap, child: leading!)
                else
                  const SizedBox(width: 24),

                const SizedBox(width: 12),

                Expanded(child: title ?? const SizedBox()),

                const SizedBox(width: 12),

                if (trailing != null) trailing! else const SizedBox(width: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
