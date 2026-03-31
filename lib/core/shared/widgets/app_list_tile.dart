import 'package:flutter/material.dart';

class AppListTile extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  const AppListTile({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: theme.colorScheme.surface,
          ),
          child: child,
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   final theme = Theme.of(context);

  //   return Material(
  //     color: Colors.transparent,
  //     child: InkWell(
  //       onTap: onTap,
  //       child: Ink(
  //         padding: padding,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(12),
  //           color: theme.colorScheme.surface,
  //         ),
  //         child: Row(
  //           children: [
  //             leading,
  //             const SizedBox(width: 12),
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(title, style: theme.textTheme.titleMedium),
  //                   if (subtitle != null)
  //                     Text(
  //                       subtitle!,
  //                       style: theme.textTheme.bodySmall?.copyWith(
  //                         color: theme.colorScheme.onSurface.withValues(
  //                           alpha: 0.6,
  //                         ),
  //                       ),
  //                     ),
  //                 ],
  //               ),
  //             ),
  //             trailing ??
  //                 Icon(
  //                   Ionicons.chevron_forward,
  //                   color: theme.colorScheme.onSecondary,
  //                 ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
