import 'package:soccer_life/core/entities/country/country_model.dart';
import 'package:soccer_life/features/leagues/data/models/fixture_model.dart';
import 'package:soccer_life/features/leagues/data/models/league_model.dart';
import 'package:soccer_life/features/leagues/data/models/standing_model.dart';

abstract class LocalLeagueDataSource {
  List<CountryModel> getCountries();
  void saveCountries(List<CountryModel> countries);
  bool get hasCountries;

  List<LeagueModel> getLeagues(String countryCode);
  void saveLeagues(String countryCode, List<LeagueModel> leagues);
  bool hasLeagues(String countryCode);

  List<StandingModel> getStandings(int leagueId, int season);
  void saveStandings(int leagueId, int season, List<StandingModel> standings);
  bool hasStandings(int leagueId, int season);

  List<FixtureModel> getFixtures(int leagueId, int season);
  void saveFixtures(int leagueId, int season, List<FixtureModel> fixtures);
  bool hasFixtures(int leagueId, int season);
}
