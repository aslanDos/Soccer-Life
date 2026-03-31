import 'package:equatable/equatable.dart';

class LeagueSeason extends Equatable {
  final int year;
  final String start;
  final String end;
  final bool current;
  final bool hasStandings;

  const LeagueSeason({
    required this.year,
    required this.start,
    required this.end,
    required this.current,
    this.hasStandings = false,
  });

  /// E.g. 2023 → "2023/24", 2020 → "2020/21"
  String get label {
    final endYear = (year + 1).toString();
    return '$year/$endYear';
  }

  @override
  List<Object?> get props => [year];
}
