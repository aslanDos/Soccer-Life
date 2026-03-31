import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_life/core/di/dependency_injection.dart';
import 'package:soccer_life/features/leagues/domain/entity/league_season.dart';
import 'package:soccer_life/features/leagues/domain/entity/standing_entity.dart';
import 'package:soccer_life/features/leagues/domain/usecases/get_standings_usecase.dart';
import 'package:soccer_life/features/leagues/presentation/widgets/tiles/season_winner_tile.dart';

class LeagueInfo extends StatelessWidget {
  final int leagueId;
  final String name;
  final String country;
  final int season;
  final List<LeagueSeason> seasons;

  const LeagueInfo({
    super.key,
    required this.leagueId,
    required this.name,
    required this.country,
    required this.season,
    this.seasons = const [],
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentSeason = seasons.firstWhere(
      (s) => s.year == season,
      orElse: () =>
          LeagueSeason(year: season, start: '', end: '', current: true),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: theme.textTheme.headlineMedium),
        const SizedBox(height: 4),
        Text(country, style: theme.textTheme.bodySmall),
        const SizedBox(height: 6),
        _SeasonChip(
          leagueId: leagueId,
          currentSeason: currentSeason,
          allSeasons: seasons,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------

class _SeasonChip extends StatelessWidget {
  final int leagueId;
  final LeagueSeason currentSeason;
  final List<LeagueSeason> allSeasons;

  const _SeasonChip({
    required this.leagueId,
    required this.currentSeason,
    required this.allSeasons,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: allSeasons.isEmpty ? null : () => _showSeasonsSheet(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.outline),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(currentSeason.label, style: theme.textTheme.labelMedium),
            if (allSeasons.isNotEmpty) ...[
              const SizedBox(width: 4),
              Icon(
                Icons.expand_more,
                size: 14,
                color: theme.colorScheme.onSurface,
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showSeasonsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => ChangeNotifierProvider(
        create: (_) => _SeasonsProvider(
          usecase: di<GetStandingsUsecase>(),
          leagueId: leagueId,
          seasons: allSeasons,
        )..load(),
        child: _SeasonsBottomSheet(),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Loads all seasons in parallel; exposes only those that returned a winner.
// ---------------------------------------------------------------------------

typedef _SeasonResult = ({LeagueSeason season, StandingEntity winner});

class _SeasonsProvider extends ChangeNotifier {
  final GetStandingsUsecase usecase;
  final int leagueId;
  final List<LeagueSeason> seasons;

  _SeasonsProvider({
    required this.usecase,
    required this.leagueId,
    required this.seasons,
  });

  List<_SeasonResult> results = [];
  bool isLoading = true;

  Future<void> load() async {
    // Most-recent-first order; filter to seasons with standings coverage.
    final candidates = [...seasons.where((s) => s.hasStandings)]
      ..sort((a, b) => b.year.compareTo(a.year));

    final fetched = await Future.wait(
      candidates.map((s) async {
        final result = await usecase(
          StandingsParams(leagueId: leagueId, season: s.year),
        );
        return result.fold(
          (_) => null,
          (standings) => standings.isNotEmpty
              ? (season: s, winner: standings.first)
              : null,
        );
      }),
    );

    results = fetched.whereType<_SeasonResult>().toList();
    isLoading = false;
    notifyListeners();
  }
}

// ---------------------------------------------------------------------------

class _SeasonsBottomSheet extends StatelessWidget {
  const _SeasonsBottomSheet();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<_SeasonsProvider>(
      builder: (context, provider, _) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            if (provider.isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: CircularProgressIndicator(),
              )
            else ...[
              ...provider.results.map(
                (r) => SeasonWinnerTile(season: r.season, winner: r.winner),
              ),
            ],
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
