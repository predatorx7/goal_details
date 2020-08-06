import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:goal_details/models/objects/goal.dart';
import 'package:hive/hive.dart';

class GoalProvider extends ChangeNotifier {
  final Box<Goal> goalsBox;
  Goal goal;

  GoalProvider(this.goalsBox, this.goal);

  dynamic get key => goal.key;

  void save({
    TimeOfDay selectTimeOfDay,
    DateTime selectDate,
    DateTime selectSGIDate,
    GoalType selectGoalType,
  }) async {
    final _key = key;
    goal = goal.addInfo(
      targetDate: selectDate ?? targetDate,
      targetSGIDate: selectSGIDate ?? targetSGIDate,
      targetTimeOfDay: selectTimeOfDay ?? targetTimeOfDay,
      goalType: selectGoalType ?? goalType,
    );
    print('Key type: ${_key.runtimeType.toString()}');
    await goalsBox.put(_key, goal);
    await goal.save();
    notifyListeners();
  }

  String get title => goal.title;

  DateTime get targetDate => goal?.targetDate ?? DateTime.now();
  DateTime get targetSGIDate => goal?.targetSGIDate ?? DateTime.now();
  TimeOfDay get targetTimeOfDay => goal?.targetTimeOfDay ?? TimeOfDay.now();
  GoalType get goalType => goal?.goalType ?? GoalType.personal;

  double get completed => goal.completed();

  Future<void> delete() async => await goalsBox.delete(key);
}
