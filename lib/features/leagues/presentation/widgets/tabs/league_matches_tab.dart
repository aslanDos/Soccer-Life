import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_life/core/di/dependency_injection.dart';
import 'package:soccer_life/features/leagues/domain/entity/fixture_entity.dart';
import 'package:soccer_life/features/leagues/domain/entity/league_entity.dart';
import 'package:soccer_life/features/leagues/presentation/provider/fixtures_provider.dart';

class LeagueMatchesTab extends StatelessWidget {
  final LeagueEntity league;

  const LeagueMatchesTab({super.key, required this.league});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          di<FixturesProvider>()..fetchFixtures(league.id, league.season),
      child: Consumer<FixturesProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.error != null) {
            return Center(child: Text(provider.error!));
          }
          if (provider.fixtures.isEmpty) {
            return const Center(child: Text('No fixtures available'));
          }
          return Column(
            children: [
              _FilterRow(
                selected: provider.filter,
                onSelected: provider.setFilter,
              ),
              Expanded(child: _FixtureList(provider: provider)),
            ],
          );
        },
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  final MatchFilter selected;
  final ValueChanged<MatchFilter> onSelected;

  const _FilterRow({required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Row(
        children: MatchFilter.values
            .map((f) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _FilterChip(
                    label: f.label,
                    selected: selected == f,
                    onTap: () => onSelected(f),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? theme.colorScheme.primary : Colors.transparent,
          border: Border.all(
            color: selected
                ? theme.colorScheme.primary
                : theme.colorScheme.outline,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: selected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurface,
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _FixtureList extends StatelessWidget {
  final FixturesProvider provider;

  const _FixtureList({required this.provider});

  @override
  Widget build(BuildContext context) {
    final byRound = provider.byRound;

    if (byRound.isEmpty) {
      return const Center(child: Text('No fixtures for this filter'));
    }

    final rounds = byRound.keys.toList();

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: rounds.length,
      itemBuilder: (context, index) {
        final round = rounds[index];
        final fixtures = byRound[round]!;
        return _RoundSection(round: round, fixtures: fixtures);
      },
    );
  }
}

class _RoundSection extends StatelessWidget {
  final String round;
  final List<FixtureEntity> fixtures;

  const _RoundSection({required this.round, required this.fixtures});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // API returns "Regular Season - 31" — show only the part after the dash.
    final label = round.contains(' - ') ? round.split(' - ').last : round;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
          child: Text(
            'Week $label',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...fixtures.map((f) => _MatchRow(fixture: f)),
      ],
    );
  }
}

class _MatchRow extends StatelessWidget {
  final FixtureEntity fixture;

  const _MatchRow({required this.fixture});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          // Home team
          _TeamLogo(url: fixture.home.logo),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              fixture.home.name,
              style: theme.textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Center: score / time / date
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: _MatchCenter(fixture: fixture),
          ),
          // Away team
          Expanded(
            child: Text(
              fixture.away.name,
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          _TeamLogo(url: fixture.away.logo),
        ],
      ),
    );
  }
}

class _MatchCenter extends StatelessWidget {
  final FixtureEntity fixture;

  const _MatchCenter({required this.fixture});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final bold = theme.textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.bold,
      color: primary,
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
      'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
      'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC',
    ];
    return '${local.day.toString().padLeft(2, '0')} ${months[local.month - 1]}';
  }

  String _timeLine(DateTime date) {
    final local = date.toLocal();
    final h = local.hour.toString().padLeft(2, '0');
    final m = local.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}

class _TeamLogo extends StatelessWidget {
  final String url;

  const _TeamLogo({required this.url});

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

extension on MatchFilter {
  String get label => switch (this) {
        MatchFilter.all => 'All',
        MatchFilter.upcoming => 'Upcoming',
        MatchFilter.finished => 'Finished',
      };
}
