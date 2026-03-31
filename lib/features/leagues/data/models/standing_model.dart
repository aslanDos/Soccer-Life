import 'package:soccer_life/features/leagues/domain/entity/standing_entity.dart';

class StandingModel extends StandingEntity {
  const StandingModel({
    required super.rank,
    required super.teamId,
    required super.teamName,
    required super.teamLogo,
    required super.played,
    required super.win,
    required super.draw,
    required super.lose,
    required super.goalsFor,
    required super.goalsAgainst,
    required super.points,
    super.description,
  });

  factory StandingModel.fromJson(Map<String, dynamic> json) {
    final team = json['team'] as Map<String, dynamic>;
    final all = json['all'] as Map<String, dynamic>;
    final goals = all['goals'] as Map<String, dynamic>;

    return StandingModel(
      rank: json['rank'] as int,
      teamId: team['id'] as int,
      teamName: team['name'] as String,
      teamLogo: team['logo'] as String? ?? '',
      played: all['played'] as int,
      win: all['win'] as int,
      draw: all['draw'] as int,
      lose: all['lose'] as int,
      goalsFor: goals['for'] as int,
      goalsAgainst: goals['against'] as int,
      points: json['points'] as int,
      description: json['description'] as String?,
    );
  }
}
