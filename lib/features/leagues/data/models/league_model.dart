import 'package:soccer_life/features/leagues/domain/entity/league_entity.dart';

class LeagueModel extends LeagueEntity {
  const LeagueModel({
    required super.id,
    required super.name,
    required super.countryCode,
    required super.countryName,
    required super.countryFlag,
    required super.logo,
    required super.season,
  });

  factory LeagueModel.fromJson(Map<String, dynamic> json) {
    final league = json['league'] as Map<String, dynamic>;
    final country = json['country'] as Map<String, dynamic>;
    final seasons = json['seasons'] as List?;
    final currentSeason = seasons?.lastWhere(
      (s) => s['current'] == true,
      orElse: () => seasons.last,
    );

    return LeagueModel(
      id: league['id'] as int,
      name: league['name'] as String,
      countryCode: country['code'] as String? ?? '',
      countryName: country['name'] as String? ?? '',
      countryFlag: country['flag'] as String? ?? '',
      logo: league['logo'] as String? ?? '',
      season: currentSeason?['year'] as int? ?? 0,
    );
  }
}
