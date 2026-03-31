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
    final image = Image.network(
      logoUrl,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (_, _, _) => Icon(Icons.sports_soccer, size: size),
    );

    if (!withBackground) return image;

    return image;
  }
}

// class _LeagueLogo extends StatelessWidget {
//   final String url;

//   const _LeagueLogo(this.url);

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(6),
//       child: url.isNotEmpty
//           ? Image.network(
//               url,
//               width: 36,
//               height: 36,
//               fit: BoxFit.contain,
//               errorBuilder: (_, _, _) => _placeholder(),
//             )
//           : _placeholder(),
//     );
//   }

//   Widget _placeholder() {
//     return Container(
//       width: 36,
//       height: 36,
//       color: Colors.grey.shade300,
//       child: const Icon(Icons.sports_soccer, size: 20),
//     );
//   }
// }
