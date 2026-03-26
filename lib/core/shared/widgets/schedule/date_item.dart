import 'package:flutter/material.dart';
import 'package:soccer_life/core/shared/theme/app_colors.dart';
import 'package:soccer_life/core/shared/widgets/schedule/date_model.dart';

class DateItem extends StatelessWidget {
  final DateModel date;
  final bool isSelected;

  const DateItem({super.key, required this.date, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.blue6 : AppColors.black4,
        borderRadius: BorderRadius.circular(100),
      ),
      padding: EdgeInsets.all(14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date.weekday,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isSelected ? AppColors.white : AppColors.black7,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            date.day,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: isSelected ? AppColors.white : AppColors.black7,
            ),
          ),
        ],
      ),
    );
  }
}
