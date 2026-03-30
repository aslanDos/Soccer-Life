import 'package:soccer_life/core/entities/country/country_model.dart';
import 'package:soccer_life/features/leagues/data/models/league_model.dart';

abstract class RemoteLeagueDataSource {
  Future<List<CountryModel>> getCountries({
    String? name,
    String? code,
    String? search,
  });

  Future<List<LeagueModel>> getLeagues(String countryCode);
}
