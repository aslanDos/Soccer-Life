import 'package:flutter/material.dart';

class PlayerListTile extends StatelessWidget {
  final String name;
  final String team;
  final String position;
  final String imageUrl;
  final VoidCallback? onTap;

  const PlayerListTile({
    super.key,
    required this.name,
    required this.team,
    required this.position,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            /// 👤 Avatar
            CircleAvatar(
              radius: 26,
              backgroundImage: NetworkImage(imageUrl),
              backgroundColor: Colors.grey[200],
            ),

            const SizedBox(width: 12),

            /// 📄 Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(team, style: theme.textTheme.bodySmall),
                ],
              ),
            ),

            /// 🏷 Position badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: _getPositionColor(position),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                position,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 8),

            /// ➡️ Arrow
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  Color _getPositionColor(String position) {
    switch (position.toLowerCase()) {
      case 'goalkeeper':
        return Colors.orange;
      case 'defender':
        return Colors.blue;
      case 'midfielder':
        return Colors.green;
      case 'attacker':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
