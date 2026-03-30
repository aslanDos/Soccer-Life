import 'package:dartz/dartz.dart';
import 'package:soccer_life/core/errors/exception_failure_mapper.dart';
import 'package:soccer_life/core/errors/failures.dart';
import 'package:soccer_life/core/network/api_client.dart';
import 'package:soccer_life/core/network/api_endpoints.dart';
import 'package:soccer_life/core/network/api_response.dart';
import 'package:soccer_life/features/players/data/models/player_model.dart';
import 'package:soccer_life/features/players/domain/entity/player_entity.dart';
import 'package:soccer_life/features/players/domain/repostiory/players_repository.dart';

class PlayerRepositoryImpl implements PlayerRepository {
  final ApiClient apiClient;

  PlayerRepositoryImpl(this.apiClient);

  @override
  Future<Either<Failure, List<PlayerEntity>>> getPlayers(int teamId) async {
    try {
      final response = await apiClient.get(
        ApiEndpoints.squads,
        queryParameters: {'team': teamId},
      );

      // The squads endpoint wraps each item as { "team": {...}, "players": [...] }
      final squads = ApiResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) => json,
      ).data;

      if (squads.isEmpty) return const Right([]);

      final players = (squads.first['players'] as List)
          .map((e) => PlayerModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return Right(players);
    } catch (e) {
      if (e is Exception) return Left(mapExceptionToFailure(e));
      return Left(ServerFailure(e.toString()));
    }
  }
}
