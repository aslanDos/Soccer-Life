import 'package:soccer_life/core/entities/country/country_model.dart';
import 'package:soccer_life/features/leagues/data/data_source/local/local_league_data_source.dart';
import 'package:soccer_life/features/leagues/data/models/league_model.dart';
import 'package:soccer_life/features/leagues/data/models/standing_model.dart';

class LocalLeagueDataSourceImpl implements LocalLeagueDataSource {
  List<CountryModel> _countriesCache = [];
  final Map<String, List<LeagueModel>> _leaguesCache = {};
  final Map<String, List<StandingModel>> _standingsCache = {};

  String _standingsKey(int leagueId, int season) => '${leagueId}_$season';

  @override
  bool get hasCountries => _countriesCache.isNotEmpty;

  @override
  List<CountryModel> getCountries() => _countriesCache;

  @override
  void saveCountries(List<CountryModel> countries) {
    _countriesCache = countries;
  }

  @override
  bool hasLeagues(String countryCode) => _leaguesCache.containsKey(countryCode);

  @override
  List<LeagueModel> getLeagues(String countryCode) =>
      _leaguesCache[countryCode] ?? [];

  @override
  void saveLeagues(String countryCode, List<LeagueModel> leagues) {
    _leaguesCache[countryCode] = leagues;
  }

  @override
  bool hasStandings(int leagueId, int season) =>
      _standingsCache.containsKey(_standingsKey(leagueId, season));

  @override
  List<StandingModel> getStandings(int leagueId, int season) =>
      _standingsCache[_standingsKey(leagueId, season)] ?? [];

  @override
  void saveStandings(int leagueId, int season, List<StandingModel> standings) {
    _standingsCache[_standingsKey(leagueId, season)] = standings;
  }
}
