import 'package:soccer_life/core/entities/country/country_entity.dart';

class CountryModel extends CountryEntity {
  const CountryModel({
    required super.name,
    required super.code,
    required super.flagUrl,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name'] as String,
      code: json['code'] as String? ?? '',
      flagUrl: json['flag'] as String? ?? '',
    );
  }

  CountryEntity toEntity() {
    return CountryEntity(name: name, code: code, flagUrl: flagUrl);
  }
}
