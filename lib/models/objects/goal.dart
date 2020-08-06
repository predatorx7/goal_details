import 'package:flutter/foundation.dart' show required;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'goal.g.dart';

@HiveType(typeId: 1)
enum GoalType {
  @HiveField(0)
  personal,
  @HiveField(1)
  community
}

@JsonSerializable(nullable: false)
@HiveType(typeId: 0)
class Goal extends HiveObject {
  Goal.withTimeOfDay({
    @required this.title,
    TimeOfDay targetTimeOfDay,
    this.targetDate,
    this.targetSGIDate,
    @required this.creationTime,
    this.goalType,
  })  : assert(title != null && creationTime != null),
        this.targetTime = targetDate.add(
          Duration(
              hours: targetTimeOfDay.hour, minutes: targetTimeOfDay.minute),
        ) {
    if (targetDate != null) {
      assert(start < end);
    }
  }

  Goal({
    @required this.title,
    this.targetTime,
    this.targetDate,
    this.targetSGIDate,
    @required this.creationTime,
    GoalType goalType,
  })  : assert(title != null && creationTime != null),
        this.goalType = goalType ?? GoalType.personal {
    if (targetDate != null) {
      assert(start < end);
    }
  }

  @HiveField(0)
  final String title;

  @HiveField(1)
  @JsonKey(nullable: true)
  final DateTime targetDate;

  @HiveField(2)
  @JsonKey(nullable: true)
  final DateTime targetSGIDate;

  @HiveField(3)
  @JsonKey(nullable: true)
  @Deprecated('Use [targetTimeOfDay] instead')
  DateTime targetTime;

  @JsonKey(ignore: true)
  // ignore: deprecated_member_use_from_same_package
  TimeOfDay get targetTimeOfDay =>
      targetTime == null ? null : TimeOfDay.fromDateTime(targetTime);

  set targetTimeOfDay(TimeOfDay timeOfDay) {
    // ignore: deprecated_member_use_from_same_package
    targetTime = convertTimeOfDayToDateTime(timeOfDay, targetDate);
  }

  static DateTime convertTimeOfDayToDateTime(TimeOfDay timeOfDay,
      [DateTime dateTime]) {
    DateTime q = dateTime ?? DateTime.now();
    return DateTime(q.year, q.month, q.day, timeOfDay.hour, timeOfDay.minute);
  }

  @HiveField(4)
  final DateTime creationTime;

  @HiveField(5)
  final GoalType goalType;
  int get start => creationTime.millisecondsSinceEpoch;

  int get end => targetTimeOfDay != null
      ? targetTime.millisecondsSinceEpoch
      : targetDate.add(Duration(days: 1)).millisecondsSinceEpoch;

  /// Returns a new [Goal] with modified details.
  Goal addInfo({
    String title,
    TimeOfDay targetTimeOfDay,
    DateTime targetDate,
    DateTime targetSGIDate,
    GoalType goalType,
  }) {
    return Goal.withTimeOfDay(
      title: title ?? this.title,
      creationTime: creationTime ?? this.creationTime,
      targetTimeOfDay: targetTimeOfDay ?? this.targetTimeOfDay,
      targetDate: targetDate ?? this.targetDate,
      targetSGIDate: targetSGIDate ?? this.targetSGIDate,
      goalType: goalType ?? this.goalType,
    );
  }

  /// Returns a double value between range 0-1 to denote the ratio of time
  /// elapsed since creation.
  ///
  /// It returns 1.0 if current time is higher than [targetTimeOfDay].
  double completed() {
    final DateTime currentTime = DateTime.now();
    return completedTillDateTime(currentTime);
  }

  int get percentageCompleted => (completed() * 100).round();

  /// Duration passed since creation of this Goal in milliseconds since Unix Epoch
  int elapsedDuration() => DateTime.now().millisecondsSinceEpoch - start;

  /// Total duration of this goal in milliseconds
  int get totalDuraton => end - start;

  /// Returns a double between range 0-1 to denote the percentage of time
  /// elapsed since creation.
  ///
  /// It returns 1.0 if [current] time is higher than [targetTimeOfDay].
  ///
  /// Uses parameter [current] for testing to use a mock value for DateTime.now in calculations.
  double completedTillDateTime(DateTime currentTime) {
    if (targetDate == null) return 0.0;
    final int now = currentTime.millisecondsSinceEpoch;
    if (now > end) {
      return 1.0;
    }
    int elapsedDuration = now - start;
    int totalDuraton = end - start;
    return elapsedDuration / totalDuraton;
  }

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);

  Map<String, dynamic> toJson() => _$GoalToJson(this);
}
