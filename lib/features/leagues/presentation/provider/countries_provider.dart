import 'package:soccer_life/core/entities/country/country_entity.dart';
import 'package:soccer_life/core/presentation/async_provider.dart';
import 'package:soccer_life/core/usecases/usecase.dart';
import 'package:soccer_life/features/leagues/domain/usecases/get_countries_usecase.dart';

class CountriesProvider extends AsyncProvider<CountryEntity> {
  final GetCountriesUsecase _getCountries;

  CountriesProvider(this._getCountries);

  List<CountryEntity> get countries => data;

  Future<void> fetchCountries() => run(_getCountries(const NoParams()));
}
