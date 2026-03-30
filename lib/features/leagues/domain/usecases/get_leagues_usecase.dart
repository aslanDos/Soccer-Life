import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:soccer_life/core/errors/failures.dart';
import 'package:soccer_life/core/usecases/usecase.dart';
import 'package:soccer_life/features/leagues/domain/entity/league_entity.dart';
import 'package:soccer_life/features/leagues/domain/repository/league_repository.dart';

class GetLeaguesUsecase extends UseCase<List<LeagueEntity>, LeagueParams> {
  final LeagueRepository leagueRepository;

  GetLeaguesUsecase(this.leagueRepository);

  @override
  Future<Either<Failure, List<LeagueEntity>>> call(LeagueParams params) {
    return leagueRepository.getLeagues(params.countryCode);
  }
}

class LeagueParams extends Equatable {
  final String countryCode;

  const LeagueParams(this.countryCode);

  @override
  List<Object> get props => [countryCode];
}
