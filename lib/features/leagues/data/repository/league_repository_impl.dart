import 'package:dartz/dartz.dart';
import 'package:soccer_life/core/entities/country/country_entity.dart';
import 'package:soccer_life/core/errors/exception_failure_mapper.dart';
import 'package:soccer_life/core/errors/failures.dart';
import 'package:soccer_life/features/leagues/data/data_source/local/local_league_data_source.dart';
import 'package:soccer_life/features/leagues/data/data_source/remote/remote_league_data_source.dart';
import 'package:soccer_life/features/leagues/domain/entity/league_entity.dart';
import 'package:soccer_life/features/leagues/domain/repository/league_repository.dart';

class LeagueRepositoryImpl extends LeagueRepository {
  final RemoteLeagueDataSource remoteLeagueDataSource;
  final LocalLeagueDataSource localLeagueDataSource;

  LeagueRepositoryImpl({
    required this.remoteLeagueDataSource,
    required this.localLeagueDataSource,
  });

  @override
  Future<Either<Failure, List<CountryEntity>>> getCountires() async {
    if (localLeagueDataSource.hasCountries) {
      return Right(localLeagueDataSource.getCountries());
    }

    try {
      final countries = await remoteLeagueDataSource.getCountries();
      localLeagueDataSource.saveCountries(countries);
      return Right(countries);
    } catch (e) {
      if (e is Exception) return Left(mapExceptionToFailure(e));
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LeagueEntity>>> getLeagues(String countryCode) async {
    if (localLeagueDataSource.hasLeagues(countryCode)) {
      return Right(localLeagueDataSource.getLeagues(countryCode));
    }

    try {
      final leagues = await remoteLeagueDataSource.getLeagues(countryCode);
      localLeagueDataSource.saveLeagues(countryCode, leagues);
      return Right(leagues);
    } catch (e) {
      if (e is Exception) return Left(mapExceptionToFailure(e));
      return Left(ServerFailure(e.toString()));
    }
  }
}
