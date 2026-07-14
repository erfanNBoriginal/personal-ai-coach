import 'package:flutter/material.dart';
import 'package:personal_ai_coach/ui_kit/stepper.dart';
import 'package:personal_ai_coach/ui_kit/ui_kit.dart' as U;

class RoadmapPage extends StatelessWidget {
  static String route = '/roadmap';

  const RoadmapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: U.Theme.afternoonPallet.getColors,
          begin: AlignmentGeometry.topCenter,
          end: AlignmentGeometry.bottomCenter,
        ),
      ),
      child: U.Stepper(
        items: [
          StepperItem(
            isDone: false,
            title: 'Set your goal',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Choose a goal to focus on this week.'),
                SizedBox(height: 12),
              ],
            ),
          ),
          StepperItem(
            isDone: false,
            title: 'Set your goal',
            child: U.Stepper(
              items: [
                StepperItem(
                  isDone: false,
                  title: 'Set your goal',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Choose a goal to focus on this week.'),
                      SizedBox(height: 12),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
