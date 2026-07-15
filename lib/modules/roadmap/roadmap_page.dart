import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_ai_coach/domains/business_repository/business_repository.dart';
import 'package:personal_ai_coach/domains/business_repository/models/roadmap.dart';
import 'package:personal_ai_coach/modules/roadmap/cubit/roadmap_cubit.dart';
import 'package:personal_ai_coach/ui_kit/stepper.dart';
import 'package:personal_ai_coach/ui_kit/ui_kit.dart' as U;

class RoadmapPage extends StatelessWidget {
  static String route = '/roadmap';
  final Roadmap? roadMap;
  final String? goal;
  const RoadmapPage({super.key, required this.roadMap, this.goal});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoadmapCubit(
        initialRoadmap: roadMap,
        repo: context.read<BusinessRepository>(),
      ),
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
                          color: U.Theme.primaryText,
                        ),
                        U.Text(
                          isCentered: true,
                          text:
                              'we have prepared a roadmap for you to achieve your goal',
                          textSize: U.TextSize.s18,
                          textWeight: U.TextWeight.bold,
                          color: U.Theme.primaryText,
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                U.Stepper(
                  isMoveable: true,
                  useDashedLine: true,
                  items: [
                    ...state.roadmap!.milestones.expand(
                      (item) => [
                        StepperItem(
                          itemBackground: U.Theme.secondaryText.withValues(
                            alpha: 0.7,
                          ),
                          subTitle: 'Milestone ${item.id}',
                          inProgress: item.order == 1,
                          isDisabled: item.weeklyObjectives.isEmpty,
                          isDone: false,
                          title: item.title,
                          child: U.Stepper(
                            isMoveable: true,
                            items: [
                              ...item.weeklyObjectives.expand(
                                (e) => [
                                  StepperItem(
                                    itemBackground: U.Theme.divider.withValues(
                                      alpha: 0.23,
                                    ),
                                    subTitle: "week: ${e.week.toString()}",
                                    inProgress: e.week == 2,
                                    isDone: e.week == 1,
                                    title: e.focus,
                                    onTap: () {
                                      print('heyyyyyyyyyyyyyyyy');
                                      print(
                                        'currentMilestone: ${item.toMap()} currentWeek: ${e.week.toString()} ',
                                      );
                                      context
                                          .read<RoadmapCubit>()
                                          .onWeeklyTasksCreated(
                                            'user goal and state: ${state.goal} currentMilestone: ${item.toMap().toString()} currentWeek: ${e.week.toString()} ',
                                          );
                                    },
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
                                              if (state.loading)
                                                Column(
                                                  children: [
                                                    SizedBox(height: 5),
                                                    CircularProgressIndicator(),
                                                  ],
                                                ),
                                              state.weeklyTasks?.weekNumber ==
                                                      e.week
                                                  ? U.Stepper(
                                                    isMoveable: true,
                                                      items: [
                                                        ...state
                                                            .weeklyTasks!
                                                            .days
                                                            .map(
                                                              (
                                                                e,
                                                              ) => StepperItem(
                                                                isDone: false,
                                                                title: e.date,
                                                                child: U.Text(
                                                                  text: e
                                                                      .primaryTask
                                                                      .description,
                                                                ),
                                                              ),
                                                            ),
                                                      ],
                                                    )
                                                  : SizedBox(),
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
