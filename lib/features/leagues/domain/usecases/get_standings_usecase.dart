import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:soccer_life/core/errors/failures.dart';
import 'package:soccer_life/core/usecases/usecase.dart';
import 'package:soccer_life/features/leagues/domain/entity/standing_entity.dart';
import 'package:soccer_life/features/leagues/domain/repository/league_repository.dart';

class GetStandingsUsecase
    extends UseCase<List<StandingEntity>, StandingsParams> {
  final LeagueRepository leagueRepository;

  GetStandingsUsecase(this.leagueRepository);

  @override
  Future<Either<Failure, List<StandingEntity>>> call(StandingsParams params) {
    return leagueRepository.getStandings(params.leagueId, params.season);
  }
}

class StandingsParams extends Equatable {
  final int leagueId;
  final int season;

  const StandingsParams({required this.leagueId, required this.season});

  @override
  List<Object> get props => [leagueId, season];
}
