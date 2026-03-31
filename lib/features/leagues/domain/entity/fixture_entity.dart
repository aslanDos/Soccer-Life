import 'package:equatable/equatable.dart';

enum FixtureStatus { notStarted, live, finished }

class TeamRef extends Equatable {
  final int id;
  final String name;
  final String logo;

  const TeamRef({required this.id, required this.name, required this.logo});

  @override
  List<Object?> get props => [id, name, logo];
}

class FixtureEntity extends Equatable {
  final int id;
  final String round;
  final DateTime date;
  final FixtureStatus status;
  final int? elapsed;
  final TeamRef home;
  final TeamRef away;
  final int? goalsHome;
  final int? goalsAway;

  const FixtureEntity({
    required this.id,
    required this.round,
    required this.date,
    required this.status,
    this.elapsed,
    required this.home,
    required this.away,
    this.goalsHome,
    this.goalsAway,
  });

  @override
  List<Object?> get props => [id];
}
