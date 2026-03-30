import 'package:dartz/dartz.dart';
import 'package:soccer_life/core/entities/country/country_entity.dart';
import 'package:soccer_life/core/errors/failures.dart';
import 'package:soccer_life/core/usecases/usecase.dart';
import 'package:soccer_life/features/leagues/domain/repository/league_repository.dart';

class GetCountriesUsecase extends UseCase<List<CountryEntity>, NoParams> {
  final LeagueRepository leagueRepository;

  GetCountriesUsecase(this.leagueRepository);

  @override
  Future<Either<Failure, List<CountryEntity>>> call(NoParams params) {
    return leagueRepository.getCountires();
  }
}
