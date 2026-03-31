import 'package:soccer_life/core/presentation/async_provider.dart';
import 'package:soccer_life/features/leagues/domain/entity/standing_entity.dart';
import 'package:soccer_life/features/leagues/domain/usecases/get_standings_usecase.dart';

class StandingsProvider extends AsyncProvider<StandingEntity> {
  final GetStandingsUsecase _getStandings;

  StandingsProvider(this._getStandings);

  List<StandingEntity> get standings => data;

  Future<void> fetchStandings(int leagueId, int season) =>
      run(_getStandings(StandingsParams(leagueId: leagueId, season: season)));
}
