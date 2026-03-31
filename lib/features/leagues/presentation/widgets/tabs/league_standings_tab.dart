import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_life/core/di/dependency_injection.dart';
import 'package:soccer_life/features/leagues/domain/entity/league_entity.dart';
import 'package:soccer_life/features/leagues/presentation/provider/standings_provider.dart';
import 'package:soccer_life/features/leagues/presentation/widgets/league_standings_table.dart';

class LeagueStandingsTab extends StatelessWidget {
  final LeagueEntity league;

  const LeagueStandingsTab({super.key, required this.league});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          di<StandingsProvider>()..fetchStandings(league.id, league.season),
      child: Consumer<StandingsProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.error != null) {
            return Center(child: Text(provider.error!));
          }
          if (provider.standings.isEmpty) {
            return const Center(child: Text('No standings available'));
          }
          return LeagueStandingsTable(standings: provider.standings);
        },
      ),
    );
  }
}
