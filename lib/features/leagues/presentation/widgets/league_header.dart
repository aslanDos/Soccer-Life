import 'package:flutter/material.dart';
import 'package:soccer_life/features/leagues/domain/entity/league_entity.dart';
import 'package:soccer_life/features/leagues/presentation/widgets/league_info.dart';
import 'package:soccer_life/features/leagues/presentation/widgets/league_logo.dart';

class LeagueHeader extends StatelessWidget {
  final LeagueEntity league;
  const LeagueHeader({super.key, required this.league});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsetsGeometry.all(16),
      decoration: BoxDecoration(
        border: BoxBorder.fromLTRB(
          bottom: BorderSide(color: theme.colorScheme.secondary),
        ),
      ),
      child: Row(
        children: [
          // Logo
          LeagueLogo(logoUrl: league.logo),

          const SizedBox(width: 24),

          Expanded(
            child: LeagueInfo(
              name: league.name,
              country: league.countryName,
              season: league.season,
            ),
          ),
        ],
      ),
    );
  }
}
