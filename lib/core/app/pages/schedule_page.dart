import 'package:flutter/material.dart';
import 'package:soccer_life/core/shared/widgets/button.dart';
import 'package:soccer_life/core/shared/widgets/schedule/date_model.dart';
import 'package:soccer_life/core/shared/widgets/schedule/match_schedule_section.dart';

class SchedulePage extends StatelessWidget {
  SchedulePage({super.key});

  final int selectedIndex = 0;

  final mockDates = [
    DateModel(weekday: 'Sat', day: '01'),
    DateModel(weekday: 'Sun', day: '02'),
    DateModel(weekday: 'Mon', day: '03'),
    DateModel(weekday: 'Tue', day: '04'),
    DateModel(weekday: 'Wed', day: '05'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            MatchScheduleSection(
              dates: mockDates,
              selectedIndex: 0,
              onDateSelected: (index) {
                debugPrint('Selected: $index');
              },
            ),
            Button(
              title: 'Filter',
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
