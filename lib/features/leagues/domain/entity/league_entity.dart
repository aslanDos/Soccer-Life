import 'package:equatable/equatable.dart';

class LeagueEntity extends Equatable {
  final int id;
  final String name;
  final String countryCode;
  final String countryName;
  final String countryFlag;
  final String logo;
  final int season;

  const LeagueEntity({
    required this.id,
    required this.name,
    required this.countryCode,
    required this.countryName,
    required this.countryFlag,
    required this.logo,
    required this.season,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    countryCode,
    countryName,
    countryFlag,
    logo,
    season,
  ];
}
