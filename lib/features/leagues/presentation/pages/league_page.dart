import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:soccer_life/features/leagues/domain/entity/league_entity.dart';
import 'package:soccer_life/features/leagues/presentation/widgets/league_header.dart';
import 'package:soccer_life/features/leagues/presentation/widgets/league_tab.dart';

class LeaguePage extends StatelessWidget {
  final LeagueEntity league;

  const LeaguePage({super.key, required this.league});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: LeagueTabType.values.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(league.name),
          leading: IconButton(
            icon: const Icon(Ionicons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LeagueHeader(league: league),
            const LeagueTab(),
            Expanded(
              child: TabBarView(
                children: LeagueTabType.values
                    .map((tab) => tab.buildView(league))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
