import 'package:flutter/material.dart';

class LeagueInfo extends StatelessWidget {
  final String name;
  final String country;
  final int season;

  const LeagueInfo({
    super.key,
    required this.name,
    required this.country,
    required this.season,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: theme.textTheme.headlineMedium),
        Text(country, style: theme.textTheme.bodySmall),
        Text(season.toString(), style: theme.textTheme.bodySmall),
      ],
    );
  }
}
