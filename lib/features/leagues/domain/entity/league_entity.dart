import 'package:equatable/equatable.dart';
import 'package:soccer_life/features/leagues/domain/entity/league_season.dart';

class LeagueEntity extends Equatable {
  final int id;
  final String name;
  final String countryCode;
  final String countryName;
  final String countryFlag;
  final String logo;
  final int season;
  final List<LeagueSeason> seasons;

  const LeagueEntity({
    required this.id,
    required this.name,
    required this.countryCode,
    required this.countryName,
    required this.countryFlag,
    required this.logo,
    required this.season,
    this.seasons = const [],
  });

  @override
  List<Object?> get props => [id, name, countryCode, countryName, countryFlag, logo, season];
}
