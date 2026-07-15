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
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        U.Text(
                          text: state.roadmap!.goal,
                          textSize: U.TextSize.s18,
                          textWeight: U.TextWeight.bold,
                          color: U.Theme.quaternaryText,
                        ),
                        U.Text(
                          isCentered: true,
                          text:
                              'we have prepared a roadmap for you to achieve your goal',
                          textSize: U.TextSize.s18,
                          textWeight: U.TextWeight.bold,
                          color: U.Theme.quaternaryText,
                        ),
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
                U.Stepper(
                  // isMoveable: true,
                  useDashedLine: true,
                  items: [
                    ...state.roadmap!.milestones.expand(
                      (e) => [
                        StepperItem(
                          itemBackground: U.Theme.secondaryText.withValues(
                            alpha: 0.8,
                          ),
                          subTitle: 'Milestone ${e.id}',
                          inProgress: e.order == 1,
                          isDisabled: e.weeklyObjectives.isEmpty,
                          isDone: false,
                          title: e.title,
                          child: U.Stepper(
                            // isMoveable: true,
                            items: [
                              ...e.weeklyObjectives.expand(
                                (e) => [
                                  StepperItem(
                                    itemBackground: U.Theme.divider
                                        .withValues(
                                          alpha: 0.23,
                                        ),
                                    subTitle: "week: ${e.week.toString()}",
                                    inProgress: e.week == 2,
                                    isDone: e.week == 1,
                                    title: e.focus,
                                    onTap: () {},
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // U.Text(
                                              //   text:
                                              //       "week: ${e.week.toString()}",
                                              // ),
                                              // SizedBox(height: 5),
                                              U.Text(text: e.outcome),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                      ],
                                    ),
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
                SizedBox(height: 121),
              ],
            ),
          );
        },
      ),
    );
  }
}
