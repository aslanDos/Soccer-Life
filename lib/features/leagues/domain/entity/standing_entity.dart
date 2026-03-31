import 'package:equatable/equatable.dart';

class StandingEntity extends Equatable {
  final int rank;
  final int teamId;
  final String teamName;
  final String teamLogo;
  final int played;
  final int win;
  final int draw;
  final int lose;
  final int goalsFor;
  final int goalsAgainst;
  final int points;
  final String? description;

  const StandingEntity({
    required this.rank,
    required this.teamId,
    required this.teamName,
    required this.teamLogo,
    required this.played,
    required this.win,
    required this.draw,
    required this.lose,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.points,
    this.description,
  });

  int get goalDiff => goalsFor - goalsAgainst;

  @override
  List<Object?> get props => [rank, teamId];
}
