import 'package:flutter/material.dart';
import 'package:soccer_life/features/leagues/domain/entity/league_entity.dart';
import 'package:soccer_life/features/leagues/presentation/widgets/tabs/league_matches_tab.dart';
import 'package:soccer_life/features/leagues/presentation/widgets/tabs/league_overview_tab.dart';
import 'package:soccer_life/features/leagues/presentation/widgets/tabs/league_standings_tab.dart';

class LeagueTab extends StatelessWidget implements PreferredSizeWidget {
  const LeagueTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TabBar(
      labelStyle: theme.textTheme.headlineSmall,
      dividerColor: theme.colorScheme.outline,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      splashFactory: NoSplash.splashFactory,
      labelColor: theme.colorScheme.primary,
      unselectedLabelColor: theme.colorScheme.onSecondary,
      tabs: LeagueTabType.values.map((tab) => Tab(text: tab.label)).toList(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(44);
}

enum LeagueTabType {
  overview('Overview'),
  matches('Matches'),
  standings('Standings');

  final String label;

  const LeagueTabType(this.label);

  Widget buildView(LeagueEntity league) => switch (this) {
    LeagueTabType.overview => LeagueOverviewTab(league: league),
    LeagueTabType.matches => LeagueMatchesTab(league: league),
    LeagueTabType.standings => LeagueStandingsTab(league: league),
  };
}
