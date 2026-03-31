import 'package:dartz/dartz.dart';
import 'package:soccer_life/core/entities/country/country_entity.dart';
import 'package:soccer_life/core/errors/failures.dart';
import 'package:soccer_life/features/leagues/domain/entity/fixture_entity.dart';
import 'package:soccer_life/features/leagues/domain/entity/league_entity.dart';
import 'package:soccer_life/features/leagues/domain/entity/standing_entity.dart';

abstract class LeagueRepository {
  Future<Either<Failure, List<CountryEntity>>> getCountires();
  Future<Either<Failure, List<LeagueEntity>>> getLeagues(String countryCode);
  Future<Either<Failure, List<StandingEntity>>> getStandings(
    int leagueId,
    int season,
  );
  Future<Either<Failure, List<FixtureEntity>>> getFixtures(
    int leagueId,
    int season,
  );
}
