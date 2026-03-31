import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:soccer_life/core/errors/failures.dart';
import 'package:soccer_life/core/usecases/usecase.dart';
import 'package:soccer_life/features/leagues/domain/entity/fixture_entity.dart';
import 'package:soccer_life/features/leagues/domain/repository/league_repository.dart';

class GetFixturesUsecase extends UseCase<List<FixtureEntity>, FixturesParams> {
  final LeagueRepository repository;

  GetFixturesUsecase(this.repository);

  @override
  Future<Either<Failure, List<FixtureEntity>>> call(FixturesParams params) =>
      repository.getFixtures(params.leagueId, params.season);
}

class FixturesParams extends Equatable {
  final int leagueId;
  final int season;

  const FixturesParams({required this.leagueId, required this.season});

  @override
  List<Object?> get props => [leagueId, season];
}
