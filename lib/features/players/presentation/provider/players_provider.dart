import 'package:flutter/material.dart';
import 'package:soccer_life/features/players/domain/entity/player_entity.dart';
import 'package:soccer_life/features/players/domain/repostiory/players_repository.dart';

class PlayersProvider extends ChangeNotifier {
  final PlayerRepository repository;

  PlayersProvider(this.repository);

  List<PlayerEntity> _players = [];
  bool _isLoading = false;
  String? _error;

  List<PlayerEntity> get players => _players;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchPlayers(int teamId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await repository.getPlayers(teamId);

    result.fold(
      (failure) => _error = failure.message,
      (data) => _players = data,
    );

    _isLoading = false;
    notifyListeners();
  }
}
