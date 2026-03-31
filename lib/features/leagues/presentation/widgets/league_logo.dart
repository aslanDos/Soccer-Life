import 'package:flutter/material.dart';

class LeagueLogo extends StatelessWidget {
  final String logoUrl;
  final double size;
  final bool withBackground;

  const LeagueLogo({
    super.key,
    required this.logoUrl,
    this.size = 70,
    this.withBackground = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final image = Image.network(
      logoUrl,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (_, _, _) => Icon(Icons.sports_soccer, size: size),
    );

    if (!withBackground) return image;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: image,
    );
  }
}
