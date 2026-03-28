import 'package:flutter/material.dart';
import 'package:soccer_life/features/favorites/presentation/widgets/favorites_news_tab.dart';
import 'package:soccer_life/features/favorites/presentation/widgets/favorites_players_tab.dart';
import 'package:soccer_life/features/favorites/presentation/widgets/favorites_teams_tab.dart';
import 'package:soccer_life/features/favorites/presentation/widgets/favoties_games_tab.dart';

class FavoritesTab extends StatelessWidget implements PreferredSizeWidget {
  const FavoritesTab({super.key});

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
      tabs: FavoritesTabType.values.map((tab) => Tab(text: tab.label)).toList(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}

enum FavoritesTabType {
  games('Games'),
  teams('Teams'),
  players('Players'),
  news('News');

  final String label;

  const FavoritesTabType(this.label);

  Widget buildView() {
    switch (this) {
      case FavoritesTabType.games:
        return const FavoritesGamesTab();
      case FavoritesTabType.teams:
        return const FavoritesTeamsTab();
      case FavoritesTabType.players:
        return const FavoritesPlayersTab();
      case FavoritesTabType.news:
        return const FavoritesNewsTab();
    }
  }
}
