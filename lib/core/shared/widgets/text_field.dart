import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:soccer_life/core/shared/theme/app_colors.dart';

class AppTextField extends StatelessWidget {
  final Widget? icon;
  final String? placeHolderText;
  final Color? placeHolderTextColor;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final TextEditingController controller;
  final double borderRadius;

  const AppTextField({
    super.key,
    this.icon,
    this.placeHolderText = 'Search',
    this.placeHolderTextColor,
    this.backgroundColor,
    this.padding,
    required this.controller,
    this.borderRadius = 100,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.secondary,
        border: Border.all(color: AppColors.black5, width: 1),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        children: [
          icon ??
              Icon(
                Ionicons.search,
                size: 17,
                color: theme.colorScheme.onSecondary,
              ),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              autocorrect: false,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSecondary,
              ),
              decoration: InputDecoration(
                hintText: placeHolderText,
                hintStyle: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSecondary,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
