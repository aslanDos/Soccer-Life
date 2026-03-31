import 'package:flutter/material.dart';
import 'package:soccer_life/features/leagues/domain/entity/league_entity.dart';

class FavoriteLeaguesProvider extends ChangeNotifier {
  final List<LeagueEntity> _favorites = [];

  List<LeagueEntity> get favorites => List.unmodifiable(_favorites);

  bool isFavorite(int leagueId) => _favorites.any((l) => l.id == leagueId);

  void toggle(LeagueEntity league) {
    if (isFavorite(league.id)) {
      _favorites.removeWhere((l) => l.id == league.id);
    } else {
      _favorites.add(league);
    }
    notifyListeners();
  }
}
