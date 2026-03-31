import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_life/core/di/dependency_injection.dart';
import 'package:soccer_life/features/leagues/domain/entity/fixture_entity.dart';
import 'package:soccer_life/features/leagues/domain/entity/league_entity.dart';
import 'package:soccer_life/features/leagues/presentation/provider/fixtures_provider.dart';
import 'package:soccer_life/features/leagues/presentation/provider/standings_provider.dart';
import 'package:soccer_life/features/leagues/presentation/widgets/league_standings_table.dart';

class LeagueOverviewTab extends StatelessWidget {
  final LeagueEntity league;

  const LeagueOverviewTab({super.key, required this.league});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              di<FixturesProvider>()..fetchFixtures(league.id, league.season),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              di<StandingsProvider>()..fetchStandings(league.id, league.season),
        ),
      ],
      child: Consumer2<FixturesProvider, StandingsProvider>(
        builder: (context, fixtures, standings, _) {
          final loading = fixtures.isLoading || standings.isLoading;
          if (loading) return const Center(child: CircularProgressIndicator());

          return SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _FixturesSection(provider: fixtures),
                _StandingsSection(provider: standings),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FixturesSection extends StatelessWidget {
  final FixturesProvider provider;

  const _FixturesSection({required this.provider});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (provider.fixtures.isEmpty) return const SizedBox.shrink();

    final round = provider.currentRound;
    if (round == null) return const SizedBox.shrink();

    final label = round.contains(' - ') ? round.split(' - ').last : round;
    final fixtures = provider.fixturesForRound(round);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Text('Week $label', style: theme.textTheme.headlineSmall),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(16, 8, 16, 12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [...fixtures.map((f) => _MatchRow(fixture: f))],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => DefaultTabController.of(context).animateTo(1),
            child: const Text('Show more fixtures  ›'),
          ),
        ),
      ],
    );
  }
}

class _StandingsSection extends StatelessWidget {
  final StandingsProvider provider;

  const _StandingsSection({required this.provider});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (provider.standings.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Text(
            'Standings',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        LeagueStandingsTable(standings: provider.standings, shrinkWrap: true),
      ],
    );
  }
}

// Reuse the match row from the Matches tab.
class _MatchRow extends StatelessWidget {
  final FixtureEntity fixture;

  const _MatchRow({required this.fixture});

  @override
  Widget build(BuildContext context) {
    // Delegate to the shared widget from league_matches_tab.dart.
    // We instantiate it via the public API — the private _MatchRow there
    // is intentionally duplicated here to avoid coupling private internals.

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          FixtureTeam(
            logoUrl: fixture.home.logo,
            teamName: fixture.home.name,
            goals: fixture.goalsHome!,
          ),
          SizedBox(height: 12),
          FixtureTeam(
            logoUrl: fixture.away.logo,
            teamName: fixture.away.name,
            goals: fixture.goalsAway!,
          ),
        ],
      ),
    );

    // return Padding(
    //   padding: const EdgeInsets.all(12),
    //   child: Row(
    //     children: [
    //       _Logo(url: fixture.home.logo),
    //       const SizedBox(width: 8),
    //       Expanded(
    //         child: Text(
    //           fixture.home.name,
    //           style: theme.textTheme.bodySmall,
    //           overflow: TextOverflow.ellipsis,
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 8),
    //         child: _Center(fixture: fixture),
    //       ),
    //       Expanded(
    //         child: Text(
    //           fixture.away.name,
    //           style: theme.textTheme.bodySmall,
    //           textAlign: TextAlign.end,
    //           overflow: TextOverflow.ellipsis,
    //         ),
    //       ),
    //       const SizedBox(width: 8),
    //       _Logo(url: fixture.away.logo),
    //     ],
    //   ),
    // );
  }
}

class FixtureTeam extends StatelessWidget {
  final String logoUrl;
  final String teamName;
  final int goals;

  const FixtureTeam({
    super.key,
    required this.logoUrl,
    required this.teamName,
    required this.goals,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        _Logo(url: logoUrl),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            teamName,
            style: theme.textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(goals.toString(), style: theme.textTheme.headlineSmall),
      ],
    );
  }
}

class _Logo extends StatelessWidget {
  final String url;
  const _Logo({required this.url});

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

class _Center extends StatelessWidget {
  final FixtureEntity fixture;
  const _Center({required this.fixture});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bold = theme.textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.primary,
    );

    switch (fixture.status) {
      case FixtureStatus.finished:
        return Text(
          '${fixture.goalsHome ?? 0}  ${fixture.goalsAway ?? 0}',
          style: bold,
        );
      case FixtureStatus.live:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${fixture.elapsed}'",
              style: theme.textTheme.labelSmall?.copyWith(color: Colors.green),
            ),
            Text(
              '${fixture.goalsHome ?? 0}:${fixture.goalsAway ?? 0}',
              style: bold,
            ),
          ],
        );
      case FixtureStatus.notStarted:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_dateLine(fixture.date), style: theme.textTheme.labelSmall),
            Text(_timeLine(fixture.date), style: theme.textTheme.labelSmall),
          ],
        );
    }
  }

  String _dateLine(DateTime date) {
    final now = DateTime.now();
    final local = date.toLocal();
    if (local.year == now.year &&
        local.month == now.month &&
        local.day == now.day) {
      return 'TODAY';
    }
    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    return '${local.day.toString().padLeft(2, '0')} ${months[local.month - 1]}';
  }

  String _timeLine(DateTime date) {
    final local = date.toLocal();
    return '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  }
}
