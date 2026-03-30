import 'package:flutter/material.dart';
import 'package:soccer_life/features/leagues/domain/entity/league_entity.dart';
import 'package:soccer_life/features/leagues/domain/usecases/get_leagues_usecase.dart';

class LeaguesProvider extends ChangeNotifier {
  final GetLeaguesUsecase getLeaguesUsecase;

  LeaguesProvider(this.getLeaguesUsecase);

  List<LeagueEntity> _leagues = [];
  bool _isLoading = false;
  String? _error;

  List<LeagueEntity> get leagues => _leagues;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchLeagues(String countryCode) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await getLeaguesUsecase(LeagueParams(countryCode));

    result.fold(
      (failure) => _error = failure.message,
      (data) => _leagues = data,
    );

    _isLoading = false;
    notifyListeners();
  }
}
