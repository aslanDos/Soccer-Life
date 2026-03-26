import 'package:flutter/material.dart';
import 'package:soccer_life/core/shared/widgets/schedule/date_item.dart';
import 'package:soccer_life/core/shared/widgets/schedule/date_model.dart';

class DateSelectorList extends StatelessWidget {
  final List<DateModel> dates;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const DateSelectorList({
    super.key,
    required this.dates,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onTap(index),
            child: DateItem(
              date: dates[index],
              isSelected: index == selectedIndex,
            ),
          );
        },
      ),
    );
  }
}
