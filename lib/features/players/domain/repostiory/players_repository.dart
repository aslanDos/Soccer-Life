import 'package:dartz/dartz.dart';
import 'package:soccer_life/core/errors/failures.dart';
import 'package:soccer_life/features/players/domain/entity/player_entity.dart';

abstract class PlayerRepository {
  Future<Either<Failure, List<PlayerEntity>>> getPlayers(int teamId);
}
