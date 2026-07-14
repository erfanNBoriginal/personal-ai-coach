import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_ai_coach/domains/business_repository/models/roadmap.dart';
import 'package:personal_ai_coach/modules/roadmap/cubit/roadmap_cubit.dart';
import 'package:personal_ai_coach/ui_kit/stepper.dart';
import 'package:personal_ai_coach/ui_kit/ui_kit.dart' as U;

class RoadmapPage extends StatelessWidget {
  static String route = '/roadmap';
  final Roadmap? roadMap;
  const RoadmapPage({super.key, required this.roadMap});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoadmapCubit(initialRoadmap: roadMap),
      child: BlocBuilder<RoadmapCubit, RoadmapState>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: U.Theme.afternoonPallet.getColors,
                begin: AlignmentGeometry.topCenter,
                end: AlignmentGeometry.bottomCenter,
              ),
            ),
            child: ListView(
              children: [
                U.Text(
                  text: state.roadmap!.goal,
                  textSize: U.TextSize.s18,
                  textWeight: U.TextWeight.bold,
                ),
                U.Stepper(
                  useDashedLine: true,
                  items: [
                    ...state.roadmap!.milestones.expand(
                      (e) => [
                        StepperItem(
                                    isDisabled: e.weeklyObjectives.isEmpty,
                          isDone: false,
                          title: e.title,
                          child: U.Stepper(
                            items: [
                              ...e.weeklyObjectives.expand(
                                (e) => [
                                  StepperItem(
                                    isDone: false,
                                    title: e.week.toString(),
                                    child: U.Text(text: e.outcome),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // StepperItem(
                    // isDone: false,
                    // title: 'Set your goal',
                    // child: U.Stepper(
                    // items: [
                    //       StepperItem(
                    //         isDone: false,
                    //         title: 'Set your goal',
                    //         child: U.Stepper(
                    //           items: [
                    //             StepperItem(
                    //               isDone: false,
                    //               title: 'Set your goal',
                    //               child: Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: const [
                    //                   Text(
                    //                     'Choose a goal to focus on this week.',
                    //                   ),
                    //                   SizedBox(height: 12),
                    //                 ],
                    //               ),
                    //             ),
                    //             StepperItem(
                    //               isDone: false,
                    //               title: 'Set your goal',
                    //               child: Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: const [
                    //                   Text(
                    //                     'Choose a goal to focus on this week.',
                    //                   ),
                    //                   SizedBox(height: 12),
                    //                 ],
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // StepperItem(
                    //   isDisabled: true,
                    //   isDone: false,
                    //   title: 'Set your goal',
                    //   child: U.Stepper(
                    //     items: [
                    //       StepperItem(
                    //         isDone: false,
                    //         title: 'Set your goal',
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: const [
                    //             Text('Choose a goal to focus on this week.'),
                    //             SizedBox(height: 12),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: 121,)
              ],
            ),
          );
        },
      ),
    );
  }
}
