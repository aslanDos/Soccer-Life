import 'package:flutter/material.dart';
import 'package:soccer_life/core/shared/widgets/app_list_tile.dart';
import 'package:soccer_life/features/leagues/domain/entity/league_season.dart';
import 'package:soccer_life/features/leagues/domain/entity/standing_entity.dart';

class SeasonWinnerTile extends StatelessWidget {
  final LeagueSeason season;
  final StandingEntity winner;

  const SeasonWinnerTile({
    super.key,
    required this.season,
    required this.winner,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppListTile(
      child: Row(
        children: [
          Text(
            season.label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: season.current ? FontWeight.bold : FontWeight.normal,
              color: season.current ? theme.colorScheme.primary : null,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  winner.teamName,
                  style: theme.textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(width: 8),
                _WinnerLogo(url: winner.teamLogo),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WinnerLogo extends StatelessWidget {
  final String url;
  const _WinnerLogo({required this.url});

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) return const SizedBox(width: 20, height: 20);
    return Image.network(
      url,
      width: 20,
      height: 20,
      fit: BoxFit.contain,
      errorBuilder: (_, _, _) => const SizedBox(width: 20, height: 20),
    );
  }
}
