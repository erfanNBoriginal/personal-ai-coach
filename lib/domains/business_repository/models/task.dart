import 'dart:core';
import 'package:flutter/material.dart';

class WeeklyTasks {
  final String type;
  final int weekNumber;
  final String weekStartDate;
  final String weekEndDate;
  final MilestoneContext milestoneContext;
  final List<DayTask> days;
  final ProgressSnapshot progressSnapshot;
  final String insight;

  WeeklyTasks({
    required this.type,
    required this.weekNumber,
    required this.weekStartDate,
    required this.weekEndDate,
    required this.milestoneContext,
    required this.days,
    required this.progressSnapshot,
    required this.insight,
  });

  factory WeeklyTasks.fromMap(Map<String, dynamic> map) {
    return WeeklyTasks(
      type: map['type'] ?? '',
      weekNumber: map['weekNumber'] ?? 0,
      weekStartDate: map['weekStartDate'] ?? '',
      weekEndDate: map['weekEndDate'] ?? '',
      milestoneContext: MilestoneContext.fromMap(
        map['milestoneContext'] as Map<String, dynamic>? ?? {},
      ),
      days: List.from(
        map['days'] ?? [],
      ).map((e) => DayTask.fromMap(e)).toList(),
      progressSnapshot: ProgressSnapshot.fromMap(
        map['progressSnapshot'] as Map<String, dynamic>? ?? {},
      ),
      insight: map['insight'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'weekNumber': weekNumber,
      'weekStartDate': weekStartDate,
      'weekEndDate': weekEndDate,
      'milestoneContext': milestoneContext.toMap(),
      'days': days.map((e) => e.toMap()).toList(),
      'progressSnapshot': progressSnapshot.toMap(),
      'insight': insight,
    };
  }
}

class MilestoneContext {
  final String milestoneId;
  final String milestoneTitle;

  MilestoneContext({required this.milestoneId, required this.milestoneTitle});

  factory MilestoneContext.fromMap(Map<String, dynamic> map) {
    return MilestoneContext(
      milestoneId: map['milestoneId'] ?? '',
      milestoneTitle: map['milestoneTitle'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'milestoneId': milestoneId, 'milestoneTitle': milestoneTitle};
  }
}

class DayTask {
  final String date;
  String status;
  final String scheduledTimeSlot;
  final String scheduledTimeLabel;
  final PrimaryTask primaryTask;
  final List<SupportingTask> supportingTasks;

  DayTask({
    required this.date,
    required this.status,
    required this.scheduledTimeSlot,
    required this.scheduledTimeLabel,
    required this.primaryTask,
    required this.supportingTasks,
  });

  factory DayTask.fromMap(Map<String, dynamic> map) {
    return DayTask(
      date: map['date'] ?? '',
      status: map['status'] ?? 'pending',
      scheduledTimeSlot: map['scheduledTimeSlot'] ?? '',
      scheduledTimeLabel: map['scheduledTimeLabel'] ?? '',
      primaryTask: PrimaryTask.fromMap(
        map['primaryTask'] as Map<String, dynamic>? ?? {},
      ),
      supportingTasks: List.from(
        map['supportingTasks'] ?? [],
      ).map((e) => SupportingTask.fromMap(e)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'status': status,
      'scheduledTimeSlot': scheduledTimeSlot,
      'scheduledTimeLabel': scheduledTimeLabel,
      'primaryTask': primaryTask.toMap(),
      'supportingTasks': supportingTasks.map((e) => e.toMap()).toList(),
    };
  }
}

class PrimaryTask {
  final String id;
  final String title;
  final String description;
  final int estimatedMinutes;
  final String scheduledStartTime; // "HH:mm"
  final String scheduledEndTime; // "HH:mm"
  final String type;
  final String whyItMatters;
  final List<SuggestedSearch> suggestedSearches;

  PrimaryTask({
    required this.id,
    required this.title,
    required this.description,
    required this.estimatedMinutes,
    required this.scheduledStartTime,
    required this.scheduledEndTime,
    required this.type,
    required this.whyItMatters,
    required this.suggestedSearches,
  });

  factory PrimaryTask.fromMap(Map<String, dynamic> map) {
    return PrimaryTask(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      estimatedMinutes: map['estimatedMinutes'] ?? 0,
      scheduledStartTime: map['scheduledStartTime'] ?? '',
      scheduledEndTime: map['scheduledEndTime'] ?? '',
      type: map['type'] ?? '',
      whyItMatters: map['whyItMatters'] ?? '',
      suggestedSearches: List.from(
        map['suggestedSearches'] ?? [],
      ).map((e) => SuggestedSearch.fromMap(e)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'estimatedMinutes': estimatedMinutes,
      'scheduledStartTime': scheduledStartTime,
      'scheduledEndTime': scheduledEndTime,
      'type': type,
      'whyItMatters': whyItMatters,
      'suggestedSearches': suggestedSearches.map((e) => e.toMap()).toList(),
    };
  }

  /// Convenience for schedule-page rendering
  TimeOfDay get startTimeOfDay {
    final parts = scheduledStartTime.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}

class SupportingTask {
  final String id;
  final String title;
  final int estimatedMinutes;
  final String scheduledStartTime;
  final String scheduledEndTime;
  final String type;
  final bool optional;

  SupportingTask({
    required this.id,
    required this.title,
    required this.estimatedMinutes,
    required this.scheduledStartTime,
    required this.scheduledEndTime,
    required this.type,
    required this.optional,
  });

  factory SupportingTask.fromMap(Map<String, dynamic> map) {
    return SupportingTask(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      estimatedMinutes: map['estimatedMinutes'] ?? 0,
      scheduledStartTime: map['scheduledStartTime'] ?? '',
      scheduledEndTime: map['scheduledEndTime'] ?? '',
      type: map['type'] ?? '',
      optional: map['optional'] == true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'estimatedMinutes': estimatedMinutes,
      'scheduledStartTime': scheduledStartTime,
      'scheduledEndTime': scheduledEndTime,
      'type': type,
      'optional': optional,
    };
  }
}

class SuggestedSearch {
  final String query;

  SuggestedSearch({required this.query});

  factory SuggestedSearch.fromMap(Map<String, dynamic> map) {
    return SuggestedSearch(query: map['query'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {'query': query};
  }
}

class ProgressSnapshot {
  final String currentMilestone;
  final int milestonesCompleted;
  final int totalMilestones;
  final int weeksAheadOrBehind;
  final String momentumStatus;

  ProgressSnapshot({
    required this.currentMilestone,
    required this.milestonesCompleted,
    required this.totalMilestones,
    required this.weeksAheadOrBehind,
    required this.momentumStatus,
  });

  factory ProgressSnapshot.fromMap(Map<String, dynamic> map) {
    return ProgressSnapshot(
      currentMilestone: map['currentMilestone'] ?? '',
      milestonesCompleted: map['milestonesCompleted'] ?? 0,
      totalMilestones: map['totalMilestones'] ?? 0,
      weeksAheadOrBehind: map['weeksAheadOrBehind'] ?? 0,
      momentumStatus: map['momentumStatus'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'currentMilestone': currentMilestone,
      'milestonesCompleted': milestonesCompleted,
      'totalMilestones': totalMilestones,
      'weeksAheadOrBehind': weeksAheadOrBehind,
      'momentumStatus': momentumStatus,
    };
  }
}
