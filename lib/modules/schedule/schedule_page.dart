import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_ai_coach/domains/business_repository/models/weekly_tasks.dart';
import 'package:personal_ai_coach/modules/schedule/cubit/schedule_cubit.dart';
import 'package:personal_ai_coach/modules/schedule/daily_schedule.dart';
import 'package:personal_ai_coach/ui_kit/ui_kit.dart' as U;

class SchedulePage extends StatefulWidget {
  static String route = '/schedule';
  final List<SpecificTasks> initialTasks;
  const SchedulePage({super.key, required this.initialTasks});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<GlobalKey> _pageKeys = [];
  double _maxPageHeight = 0;

  @override
  void initState() {
    super.initState();
    print('widget.initialTasks.length');
    print(widget.initialTasks.length);
    _pageKeys = List.generate(
      widget.initialTasks[0].tasks.length,
      (_) => GlobalKey(),
    );
    // Measure after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) => _measurePages());
  }

  void _measurePages() {
    print('_pageKeys.length');
    print(_pageKeys.length);
    double maxHeight = 0;
    for (final key in _pageKeys) {
      final context = key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          maxHeight = math.max(maxHeight, box.size.height);
          print('maxHeight');
          print(maxHeight);
        }
      }
    }
    if (maxHeight != _maxPageHeight && mounted) {
      setState(() => _maxPageHeight = maxHeight);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleCubit(initialTasks: widget.initialTasks),
      child: BlocBuilder<ScheduleCubit, ScheduleState>(
        builder: (context, state) {
          final cubit = context.read<ScheduleCubit>();
          print('_maxPageHeightsssssssssssss');
          print(_maxPageHeight);
          return Scaffold(
            body: SafeArea(
              child: ListView(
                children: [
                  U.AppBar(title: 'todays tasks', blur: true),
                  const SizedBox(height: 22),
                  // Wrap ScrollableTabview in SizedBox with measured height
                  SizedBox(
                    height:
                        350 +
                        (_maxPageHeight > 0
                            ? _maxPageHeight
                            : MediaQuery.of(context).size.height * 0.7),
                    child: U.ScrollableTabview(
                      tabController: cubit.tabCtril,
                      pageController: cubit.pageCtrl,
                      headers: [
                        ...state.dailyTasks.map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 111,
                              width: 111,
                              child: DailyBanner(day: e.day, done: 11),
                            ),
                          ),
                        ),
                      ],
                      pages: [
                        ...state.dailyTasks.asMap().entries.map((entry) {
                          final index = entry.key;
                          final e = entry.value;
                          return Container(
                            key: _pageKeys[index],
                            child: DailySchedule(tasks: e.tasks),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
