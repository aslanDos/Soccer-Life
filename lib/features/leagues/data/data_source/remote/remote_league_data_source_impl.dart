import 'package:soccer_life/core/entities/country/country_model.dart';
import 'package:soccer_life/core/network/api_client.dart';
import 'package:soccer_life/core/network/api_endpoints.dart';
import 'package:soccer_life/core/network/api_response.dart';
import 'package:soccer_life/features/leagues/data/data_source/remote/remote_league_data_source.dart';
import 'package:soccer_life/features/leagues/data/models/league_model.dart';
import 'package:soccer_life/features/leagues/data/models/standing_model.dart';

class RemoteLeagueDataSourceImpl extends RemoteLeagueDataSource {
  final ApiClient apiClient;

  RemoteLeagueDataSourceImpl({required this.apiClient});

  @override
  Future<List<CountryModel>> getCountries({String? name, String? code, String? search}) async {
    final response = await apiClient.get(
      ApiEndpoints.countries,
      queryParameters: {
        'name': ?name,
        'code': ?code,
        'search': ?search,
      },
    );
    return ApiResponse.fromJson(
      response.data as Map<String, dynamic>,
      CountryModel.fromJson,
    ).data;
  }

  @override
  Future<List<LeagueModel>> getLeagues(String countryCode) async {
    final response = await apiClient.get(
      ApiEndpoints.leagues,
      queryParameters: {'code': countryCode},
    );
    return ApiResponse.fromJson(
      response.data as Map<String, dynamic>,
      LeagueModel.fromJson,
    ).data;
  }

  @override
  Future<List<StandingModel>> getStandings(int leagueId, int season) async {
    final response = await apiClient.get(
      ApiEndpoints.standings,
      queryParameters: {'league': leagueId, 'season': season},
    );
    final json = response.data as Map<String, dynamic>;
    final responseList = json['response'] as List? ?? [];
    if (responseList.isEmpty) return [];
    final leagueData = responseList[0] as Map<String, dynamic>;
    final standingsGroups = leagueData['league']['standings'] as List? ?? [];
    if (standingsGroups.isEmpty) return [];
    final group = standingsGroups[0] as List;
    return group
        .map((e) => StandingModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
