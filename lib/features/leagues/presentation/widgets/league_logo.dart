import 'package:flutter/material.dart';

class LeagueLogo extends StatelessWidget {
  final String logoUrl;
  const LeagueLogo({super.key, required this.logoUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      logoUrl,
      width: 70,
      height: 70,
      fit: BoxFit.contain,
      errorBuilder: (_, _, _) => const Icon(Icons.sports_soccer, size: 80),
    );
  }
}
