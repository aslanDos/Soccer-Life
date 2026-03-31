import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:soccer_life/core/shared/widgets/app_list_tile.dart';
import 'package:soccer_life/features/leagues/domain/entity/league_entity.dart';
import 'package:soccer_life/features/leagues/presentation/widgets/league_logo.dart';

class LeagueTile extends StatelessWidget {
  final LeagueEntity league;
  final VoidCallback? onTap;
  final bool? includeCountryName;

  const LeagueTile({
    super.key,
    required this.league,
    this.onTap,
    this.includeCountryName = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppListTile(
      onTap: onTap,
      child: Row(
        children: [
          LeagueLogo(logoUrl: league.logo, size: 25),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(league.name, style: theme.textTheme.headlineSmall),
                includeCountryName!
                    ? Text(league.countryName, style: theme.textTheme.bodySmall)
                    : SizedBox.shrink(),
              ],
            ),
          ),
          Icon(Ionicons.chevron_forward, color: theme.colorScheme.onSecondary),
        ],
      ),
    );
  }
}
