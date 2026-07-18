import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_ai_coach/domains/business_repository/models/weekly_tasks.dart';
import 'package:personal_ai_coach/modules/schedule/cubit/schedule_cubit.dart';
import 'package:personal_ai_coach/modules/schedule/daily_schedule.dart';
import 'package:personal_ai_coach/ui_kit/ui_kit.dart' as U;

class SchedulePage extends StatelessWidget {
  static String route = '/schedule';

  final List<SpecificTasks> initialTasks;

  const SchedulePage({super.key, required this.initialTasks});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ScheduleCubit(initialTasks: initialTasks),
      child: const _ScheduleView(),
    );
  }
}

class _ScheduleView extends StatelessWidget {
  const _ScheduleView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleCubit, ScheduleState>(
      builder: (context, state) {
        // Add selectedDayIndex to your state/cubit.
        final selectedIndex = state.selectedDayIndex;
        final selectedDay = state.dailyTasks[selectedIndex];

        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: U.AppBar(title: 'todays tasks', blur: true),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 22)),

                // Horizontal day selector
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 127,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.dailyTasks.length,
                      itemBuilder: (context, index) {
                        final day = state.dailyTasks[index];

                        return GestureDetector(
                          onTap: () {
                            context.read<ScheduleCubit>().selectDay(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: SizedBox(
                              width: 111,
                              child: DailyBanner(day: day.day, done: 11),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 55)),

                // Tasks are now part of the page scroll view.
                SliverList.separated(
                  itemCount: selectedDay.tasks.length,
                  itemBuilder: (context, index) {
                    return TaskCard(task: selectedDay.tasks[index]);
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 221)),
              ],
            ),
          ),
        );
      },
    );
  }
}
