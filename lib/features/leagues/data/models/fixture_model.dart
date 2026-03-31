import 'package:soccer_life/features/leagues/domain/entity/fixture_entity.dart';

class FixtureModel extends FixtureEntity {
  const FixtureModel({
    required super.id,
    required super.round,
    required super.date,
    required super.status,
    super.elapsed,
    required super.home,
    required super.away,
    super.goalsHome,
    super.goalsAway,
  });

  factory FixtureModel.fromJson(Map<String, dynamic> json) {
    final fixture = json['fixture'] as Map<String, dynamic>;
    final league = json['league'] as Map<String, dynamic>;
    final teams = json['teams'] as Map<String, dynamic>;
    final goals = json['goals'] as Map<String, dynamic>;
    final statusMap = fixture['status'] as Map<String, dynamic>;
    final short = statusMap['short'] as String;

    return FixtureModel(
      id: fixture['id'] as int,
      round: league['round'] as String,
      date: DateTime.parse(fixture['date'] as String),
      status: _parseStatus(short),
      elapsed: statusMap['elapsed'] as int?,
      home: TeamRef(
        id: teams['home']['id'] as int,
        name: teams['home']['name'] as String,
        logo: teams['home']['logo'] as String? ?? '',
      ),
      away: TeamRef(
        id: teams['away']['id'] as int,
        name: teams['away']['name'] as String,
        logo: teams['away']['logo'] as String? ?? '',
      ),
      goalsHome: goals['home'] as int?,
      goalsAway: goals['away'] as int?,
    );
  }

  static FixtureStatus _parseStatus(String short) {
    const live = {'1H', 'HT', '2H', 'ET', 'BT', 'P', 'LIVE', 'INT', 'SUSP'};
    const finished = {'FT', 'AET', 'PEN', 'AWD', 'WO'};
    if (live.contains(short)) return FixtureStatus.live;
    if (finished.contains(short)) return FixtureStatus.finished;
    return FixtureStatus.notStarted;
  }
}
