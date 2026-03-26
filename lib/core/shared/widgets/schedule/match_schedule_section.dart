import 'package:flutter/material.dart';
import 'package:soccer_life/core/shared/widgets/schedule/date_model.dart';
import 'package:soccer_life/core/shared/widgets/schedule/date_selector_list.dart';

class MatchScheduleSection extends StatelessWidget {
  final List<DateModel> dates;
  final int selectedIndex;
  final ValueChanged<int> onDateSelected;

  const MatchScheduleSection({
    super.key,
    required this.dates,
    required this.selectedIndex,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        _ScheduleHeader(),
        const SizedBox(height: 12),
        DateSelectorList(
          dates: dates,
          selectedIndex: selectedIndex,
          onTap: onDateSelected,
        ),
      ],
    );
  }
}

class _ScheduleHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Match Schedule',
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }
}
