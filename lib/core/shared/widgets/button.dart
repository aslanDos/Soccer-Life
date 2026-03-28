import 'package:flutter/material.dart';

enum _ButtonVariant { primary, secondary, segmented }

class AppButton extends StatelessWidget {
  final String title;
  final Icon? icon;
  final VoidCallback? onTap;
  final bool? shadow;

  final _ButtonVariant variant;
  final bool isActive;

  const AppButton._({
    required this.title,
    this.icon,
    this.onTap,
    required this.variant,
    this.isActive = false,
    this.shadow = false,
  });

  // factories

  factory AppButton.primary({
    required String title,
    VoidCallback? onTap,
    Icon? icon,
    bool? shadow,
  }) {
    return AppButton._(
      title: title,
      icon: icon,
      onTap: onTap,
      variant: _ButtonVariant.primary,
      shadow: shadow,
    );
  }

  factory AppButton.secondary({
    required String title,
    VoidCallback? onTap,
    Icon? icon,
    bool? shadow,
  }) {
    return AppButton._(
      title: title,
      icon: icon,
      onTap: onTap,
      variant: _ButtonVariant.secondary,
      shadow: shadow,
    );
  }

  factory AppButton.segmented({
    required String title,
    required bool isActive,
    VoidCallback? onTap,
    bool? shadow,
  }) {
    return AppButton._(
      title: title,
      onTap: onTap,
      variant: _ButtonVariant.segmented,
      shadow: shadow,
      isActive: isActive,
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = _getStyle(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(style.radius),
        boxShadow: shadow == true
            ? [
                BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 8,
                  color: Colors.black.withValues(alpha: 0.08),
                ),
              ]
            : [],
      ),
      child: Material(
        color: style.backgroundColor,
        borderRadius: BorderRadius.circular(style.radius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(style.radius),
          child: Padding(
            padding: style.padding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[icon!, const SizedBox(width: 6)],
                Text(title, style: style.textStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _ButtonStyle _getStyle(BuildContext context) {
    final theme = Theme.of(context);

    switch (variant) {
      case _ButtonVariant.segmented:
        return _ButtonStyle(
          backgroundColor: isActive
              ? theme.colorScheme.primary
              : Colors.grey.shade200,
          textStyle: TextStyle(
            color: isActive ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          radius: 24,
        );

      case _ButtonVariant.secondary:
        return _ButtonStyle(
          backgroundColor: theme.colorScheme.surfaceContainer,
          textStyle: theme.textTheme.bodySmall!.copyWith(
            color: theme.colorScheme.onSurface,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          radius: 100,
        );

      case _ButtonVariant.primary:
        return _ButtonStyle(
          backgroundColor: theme.colorScheme.primary,
          textStyle: const TextStyle(color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          radius: 24,
        );
    }
  }
}

class _ButtonStyle {
  final Color backgroundColor;
  final TextStyle textStyle;
  final EdgeInsets padding;
  final double radius;

  _ButtonStyle({
    required this.backgroundColor,
    required this.textStyle,
    required this.padding,
    required this.radius,
  });
}
