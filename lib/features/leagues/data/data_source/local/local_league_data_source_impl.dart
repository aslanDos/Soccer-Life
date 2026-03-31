import 'package:soccer_life/core/entities/country/country_model.dart';
import 'package:soccer_life/features/leagues/data/data_source/local/local_league_data_source.dart';
import 'package:soccer_life/features/leagues/data/models/fixture_model.dart';
import 'package:soccer_life/features/leagues/data/models/league_model.dart';
import 'package:soccer_life/features/leagues/data/models/standing_model.dart';

class LocalLeagueDataSourceImpl implements LocalLeagueDataSource {
  List<CountryModel> _countriesCache = [];
  final Map<String, List<LeagueModel>> _leaguesCache = {};
  final Map<String, List<StandingModel>> _standingsCache = {};
  final Map<String, List<FixtureModel>> _fixturesCache = {};

  String _key(int leagueId, int season) => '${leagueId}_$season';

  // Keeping old name as alias so existing standings callers still compile
  String _standingsKey(int leagueId, int season) => _key(leagueId, season);

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

  @override
  bool hasFixtures(int leagueId, int season) =>
      _fixturesCache.containsKey(_key(leagueId, season));

  @override
  List<FixtureModel> getFixtures(int leagueId, int season) =>
      _fixturesCache[_key(leagueId, season)] ?? [];

  @override
  void saveFixtures(int leagueId, int season, List<FixtureModel> fixtures) {
    _fixturesCache[_key(leagueId, season)] = fixtures;
  }
}
