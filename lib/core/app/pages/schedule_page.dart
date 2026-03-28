import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:soccer_life/core/shared/widgets/button.dart';
import 'package:soccer_life/core/shared/widgets/schedule/date_model.dart';
import 'package:soccer_life/core/shared/widgets/schedule/match_schedule_section.dart';
import 'package:soccer_life/core/shared/widgets/text_field.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final int selectedIndex = 0;
  final TextEditingController controller = TextEditingController();

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

            SizedBox(height: 24),

            Row(
              children: [
                Expanded(child: AppTextField(controller: controller)),
                SizedBox(width: 8),
                AppButton.secondary(
                  title: 'Filter',
                  icon: Icon(Ionicons.filter, size: 20),
                  shadow: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
