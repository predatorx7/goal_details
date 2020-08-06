import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../lib/models/objects/goal.dart';

import '../err_utils.dart';

void goaldetailsTest() {
  test('Incomplete Goal details', () {
    final DateTime creationTime = DateTime.now();

    final goal = Goal(
      title: 'first goal',
      creationTime: creationTime,
    );

    final goalJson = encodeToString(goal);

    final otherGoal =
        Goal.fromJson(json.decode(goalJson) as Map<String, dynamic>);

    expect(goal.title, otherGoal.title);
    expect(goal.targetDate, otherGoal.targetDate);
    expect(goal.targetTime, otherGoal.targetTime);
    expect(goal.creationTime, otherGoal.creationTime);
    expect(goal.targetSGIDate, otherGoal.targetSGIDate);
    expect(goal.goalType, otherGoal.goalType);

    expect(encodeToString(otherGoal), equals(goalJson));
  });
  test('Complete Goal details', () {
    final DateTime targetDate = DateTime(2020, 10, 8);
    final TimeOfDay targetTimeOfDay = TimeOfDay(hour: 9, minute: 30);
    final String formattedTargetTime = '9:30 AM';
    final DateTime creationTime = DateTime.now();
    final DateTime targetSGIDate = DateTime(2020, 9, 20);
    final GoalType goalType = GoalType.personal;

    final goal = Goal(
      title: 'first goal',
      targetDate: targetDate,
      targetTime: Goal.convertTimeOfDayToDateTime(targetTimeOfDay),
      creationTime: creationTime,
      targetSGIDate: targetSGIDate,
      goalType: goalType,
    );

    final goalJson = encodeToString(goal);

    final otherGoal =
        Goal.fromJson(json.decode(goalJson) as Map<String, dynamic>);

    expect(goal.title, otherGoal.title);
    expect(goal.targetDate, otherGoal.targetDate);
    expect(goal.targetTime, otherGoal.targetTime);
    expect(goal.creationTime, otherGoal.creationTime);
    expect(goal.targetSGIDate, otherGoal.targetSGIDate);
    expect(goal.goalType, otherGoal.goalType);

    expect(encodeToString(otherGoal), equals(goalJson));

    // Formats DateTime in hours and minutes
    final DateFormat formatter = DateFormat.jm();

    expect(formatter.format(goal.targetTime), formattedTargetTime);
    final DateTime _targetTime = Goal.convertTimeOfDayToDateTime(
      targetTimeOfDay,
      goal.targetDate,
    );

    final DateTime advancedTargetTime = _targetTime.add(Duration(days: 1));

    expect(goal.completedTillDateTime(advancedTargetTime), 1.0);

    final DateTime preTargetTime = _targetTime.subtract(Duration(days: 10));
    final double completionPercentage =
        goal.completedTillDateTime(preTargetTime);
    expect(0.0 < completionPercentage && completionPercentage < 1.0, true);
    expect((completionPercentage * 100).round(), 84);
  });
}
