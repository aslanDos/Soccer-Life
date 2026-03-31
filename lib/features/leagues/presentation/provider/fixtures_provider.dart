import 'package:soccer_life/core/presentation/async_provider.dart';
import 'package:soccer_life/features/leagues/domain/entity/fixture_entity.dart';
import 'package:soccer_life/features/leagues/domain/usecases/get_fixtures_usecase.dart';

enum MatchFilter { all, upcoming, finished }

class FixturesProvider extends AsyncProvider<FixtureEntity> {
  final GetFixturesUsecase _getFixtures;

  FixturesProvider(this._getFixtures);

  MatchFilter _filter = MatchFilter.all;
  MatchFilter get filter => _filter;

  List<FixtureEntity> get fixtures => data;

  List<FixtureEntity> get filtered {
    switch (_filter) {
      case MatchFilter.all:
        return data;
      case MatchFilter.upcoming:
        return data
            .where((f) => f.status == FixtureStatus.notStarted)
            .toList();
      case MatchFilter.finished:
        return data.where((f) => f.status == FixtureStatus.finished).toList();
    }
  }

  /// Fixtures grouped by round, preserving insertion order.
  Map<String, List<FixtureEntity>> get byRound {
    final map = <String, List<FixtureEntity>>{};
    for (final f in filtered) {
      (map[f.round] ??= []).add(f);
    }
    return map;
  }

  /// The current round for the Overview tab: first round that has at least one
  /// non-finished fixture, or the last round if all are done.
  String? get currentRound {
    final rounds = <String, List<FixtureEntity>>{};
    for (final f in data) {
      (rounds[f.round] ??= []).add(f);
    }
    for (final entry in rounds.entries) {
      if (entry.value.any((f) => f.status != FixtureStatus.finished)) {
        return entry.key;
      }
    }
    return rounds.keys.lastOrNull;
  }

  List<FixtureEntity> fixturesForRound(String round) =>
      data.where((f) => f.round == round).toList();

  void setFilter(MatchFilter f) {
    _filter = f;
    notifyListeners();
  }

  Future<void> fetchFixtures(int leagueId, int season) =>
      run(_getFixtures(FixturesParams(leagueId: leagueId, season: season)));
}
