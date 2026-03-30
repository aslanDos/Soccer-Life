import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:soccer_life/core/network/api_client.dart';
import 'package:soccer_life/core/network/api_endpoints.dart';
import 'package:soccer_life/features/leagues/data/data_source/local/local_league_data_source.dart';
import 'package:soccer_life/features/leagues/data/data_source/local/local_league_data_source_impl.dart';
import 'package:soccer_life/features/leagues/data/data_source/remote/remote_league_data_source.dart';
import 'package:soccer_life/features/leagues/data/data_source/remote/remote_league_data_source_impl.dart';
import 'package:soccer_life/features/leagues/data/repository/league_repository_impl.dart';
import 'package:soccer_life/features/leagues/domain/repository/league_repository.dart';
import 'package:soccer_life/features/leagues/domain/usecases/get_countries_usecase.dart';
import 'package:soccer_life/features/leagues/domain/usecases/get_leagues_usecase.dart';
import 'package:soccer_life/features/leagues/presentation/provider/countries_provider.dart';
import 'package:soccer_life/features/leagues/presentation/provider/leagues_provider.dart';
import 'package:soccer_life/features/players/data/repository/player_repostiroy_impl.dart';
import 'package:soccer_life/features/players/domain/repostiory/players_repository.dart';
import 'package:soccer_life/features/players/presentation/provider/players_provider.dart';

GetIt di = GetIt.instance;

Future<void> init() async {
  // Core
  di.registerLazySingleton<ApiClient>(
    () => ApiClient(
      baseUrl: ApiEndpoints.baseUrl,
      headers: {'x-apisports-key': dotenv.env['API_KEY'] ?? ''},
    ),
  );

  // Players
  di.registerLazySingleton<PlayerRepository>(
    () => PlayerRepositoryImpl(di<ApiClient>()),
  );
  di.registerFactory<PlayersProvider>(
    () => PlayersProvider(di<PlayerRepository>()),
  );

  // Leagues
  di.registerLazySingleton<LocalLeagueDataSource>(
    () => LocalLeagueDataSourceImpl(),
  );
  di.registerLazySingleton<RemoteLeagueDataSource>(
    () => RemoteLeagueDataSourceImpl(apiClient: di<ApiClient>()),
  );
  di.registerLazySingleton<LeagueRepository>(
    () => LeagueRepositoryImpl(
      remoteLeagueDataSource: di<RemoteLeagueDataSource>(),
      localLeagueDataSource: di<LocalLeagueDataSource>(),
    ),
  );
  di.registerLazySingleton<GetCountriesUsecase>(
    () => GetCountriesUsecase(di<LeagueRepository>()),
  );
  di.registerLazySingleton<GetLeaguesUsecase>(
    () => GetLeaguesUsecase(di<LeagueRepository>()),
  );
  di.registerFactory<CountriesProvider>(
    () => CountriesProvider(di<GetCountriesUsecase>()),
  );
  di.registerFactory<LeaguesProvider>(
    () => LeaguesProvider(di<GetLeaguesUsecase>()),
  );
}
