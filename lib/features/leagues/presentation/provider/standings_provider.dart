import 'package:flutter/material.dart';
import 'package:soccer_life/features/leagues/domain/entity/standing_entity.dart';
import 'package:soccer_life/features/leagues/domain/usecases/get_standings_usecase.dart';

class StandingsProvider extends ChangeNotifier {
  final GetStandingsUsecase getStandingsUsecase;

  StandingsProvider(this.getStandingsUsecase);

  List<StandingEntity> _standings = [];
  bool _isLoading = false;
  String? _error;

  List<StandingEntity> get standings => _standings;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchStandings(int leagueId, int season) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await getStandingsUsecase(
      StandingsParams(leagueId: leagueId, season: season),
    );

    result.fold(
      (failure) => _error = failure.message,
      (data) => _standings = data,
    );

    _isLoading = false;
    notifyListeners();
  }
}
