import 'package:soccer_life/core/presentation/async_provider.dart';
import 'package:soccer_life/features/leagues/domain/entity/league_entity.dart';
import 'package:soccer_life/features/leagues/domain/usecases/get_leagues_usecase.dart';

class LeaguesProvider extends AsyncProvider<LeagueEntity> {
  final GetLeaguesUsecase _getLeagues;

  LeaguesProvider(this._getLeagues);

  List<LeagueEntity> get leagues => data;

  Future<void> fetchLeagues(String countryCode) =>
      run(_getLeagues(LeagueParams(countryCode)));
}
