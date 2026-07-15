import 'dart:core';

class Roadmap {
  final String type;
  final String goal;
  final String summary;
  final int totalDurationWeeks;
  final String difficultyProgression;
  final List<Milestone> milestones;

  Roadmap({
    required this.type,
    required this.goal,
    required this.summary,
    required this.totalDurationWeeks,
    required this.difficultyProgression,
    required this.milestones,
  });

  factory Roadmap.fromMap(Map<String, dynamic> map) {
    return Roadmap(
      type: map['type'] ?? '',
      goal: map['goal'] ?? '',
      summary: map['summary'] ?? '',
      totalDurationWeeks: map['totalDurationWeeks'] ?? 0,
      difficultyProgression: map['difficultyProgression'] ?? '',
      milestones: List.from(
        map['milestones'] ?? [],
      ).map((e) => Milestone.fromMap(e)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'goal': goal,
      'summary': summary,
      'totalDurationWeeks': totalDurationWeeks,
      'difficultyProgression': difficultyProgression,
      'milestones': milestones.map((e) => e.toMap()).toList(),
    };
  }
}

class Milestone {
  final String id;
  final int order;
  final String title;
  final String description;
  final int startWeek;
  final int endWeek;
  final List<WeeklyObjective> weeklyObjectives;
  final Checkpoint checkpoint;

  Milestone({
    required this.id,
    required this.order,
    required this.title,
    required this.description,
    required this.startWeek,
    required this.endWeek,
    required this.weeklyObjectives,
    required this.checkpoint,
  });

  factory Milestone.fromMap(Map<String, dynamic> map) {
    return Milestone(
      id: map['id'] ?? '',
      order: map['order'] ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      startWeek: map['startWeek'] ?? 0,
      endWeek: map['endWeek'] ?? 0,
      weeklyObjectives: List.from(
        map['weeklyObjectives'] ?? [],
      ).map((e) => WeeklyObjective.fromMap(e)).toList(),
      checkpoint: Checkpoint.fromMap(
        map['checkpoint'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order': order,
      'title': title,
      'description': description,
      'startWeek': startWeek,
      'endWeek': endWeek,
      'weeklyObjectives': weeklyObjectives.map((e) => e.toMap()).toList(),
      'checkpoint': checkpoint.toMap(),
    };
  }
}

class WeeklyObjective {
  final int week;
  final String focus;
  final String outcome;

  WeeklyObjective({
    required this.week,
    required this.focus,
    required this.outcome,
  });

  factory WeeklyObjective.fromMap(Map<String, dynamic> map) {
    return WeeklyObjective(
      week: map['week'] ?? 0,
      focus: map['focus'] ?? '',
      outcome: map['outcome'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'week': week, 'focus': focus, 'outcome': outcome};
  }
}

class Checkpoint {
  final String id;
  final String title;
  final String criteria;

  Checkpoint({required this.id, required this.title, required this.criteria});

  factory Checkpoint.fromMap(Map<String, dynamic> map) {
    return Checkpoint(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      criteria: map['criteria'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'criteria': criteria};
  }
}
