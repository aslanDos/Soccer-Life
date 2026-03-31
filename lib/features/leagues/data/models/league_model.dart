import 'package:soccer_life/features/leagues/domain/entity/league_entity.dart';
import 'package:soccer_life/features/leagues/domain/entity/league_season.dart';

class LeagueModel extends LeagueEntity {
  const LeagueModel({
    required super.id,
    required super.name,
    required super.countryCode,
    required super.countryName,
    required super.countryFlag,
    required super.logo,
    required super.season,
    super.seasons,
  });

  factory LeagueModel.fromJson(Map<String, dynamic> json) {
    final league = json['league'] as Map<String, dynamic>;
    final country = json['country'] as Map<String, dynamic>;
    final rawSeasons = json['seasons'] as List? ?? [];

    final seasons = rawSeasons
        .map((s) {
          final coverage = s['coverage'] as Map<String, dynamic>? ?? {};
          return LeagueSeason(
            year: s['year'] as int,
            start: s['start'] as String? ?? '',
            end: s['end'] as String? ?? '',
            current: s['current'] as bool? ?? false,
            hasStandings: coverage['standings'] as bool? ?? false,
          );
        })
        .toList();

    final currentSeason = seasons.firstWhere(
      (s) => s.current,
      orElse: () => seasons.isNotEmpty ? seasons.last : const LeagueSeason(
        year: 0,
        start: '',
        end: '',
        current: false,
      ),
    );

    return LeagueModel(
      id: league['id'] as int,
      name: league['name'] as String,
      countryCode: country['code'] as String? ?? '',
      countryName: country['name'] as String? ?? '',
      countryFlag: country['flag'] as String? ?? '',
      logo: league['logo'] as String? ?? '',
      season: currentSeason.year,
      seasons: seasons,
    );
  }
}
