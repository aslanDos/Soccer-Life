import 'package:flutter/material.dart';
import 'package:soccer_life/core/entities/country/country_entity.dart';
import 'package:soccer_life/core/usecases/usecase.dart';
import 'package:soccer_life/features/leagues/domain/usecases/get_countries_usecase.dart';

class CountriesProvider extends ChangeNotifier {
  final GetCountriesUsecase getCountries;

  CountriesProvider(this.getCountries);

  List<CountryEntity> _countries = [];
  bool _isLoading = false;
  String? _error;

  List<CountryEntity> get countries => _countries;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchCountries() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await getCountries(const NoParams());

    result.fold(
      (failure) {
        _error = failure.message;
      },
      (data) {
        _countries = data;
      },
    );

    _isLoading = false;
    notifyListeners();
  }
}
