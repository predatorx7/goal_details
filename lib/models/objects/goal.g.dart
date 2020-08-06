// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoalTypeAdapter extends TypeAdapter<GoalType> {
  @override
  final int typeId = 1;

  @override
  GoalType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return GoalType.personal;
      case 1:
        return GoalType.community;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, GoalType obj) {
    switch (obj) {
      case GoalType.personal:
        writer.writeByte(0);
        break;
      case GoalType.community:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GoalAdapter extends TypeAdapter<Goal> {
  @override
  final int typeId = 0;

  @override
  Goal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Goal(
      title: fields[0] as String,
      targetTime: fields[3] as DateTime,
      targetDate: fields[1] as DateTime,
      targetSGIDate: fields[2] as DateTime,
      creationTime: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Goal obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.targetDate)
      ..writeByte(2)
      ..write(obj.targetSGIDate)
      ..writeByte(3)
      ..write(obj.targetTime)
      ..writeByte(4)
      ..write(obj.creationTime)
      ..writeByte(5)
      ..write(obj.goalType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goal _$GoalFromJson(Map<String, dynamic> json) {
  return Goal(
    title: json['title'] as String,
    targetTime: json['targetTime'] == null
        ? null
        : DateTime.parse(json['targetTime'] as String),
    targetDate: json['targetDate'] == null
        ? null
        : DateTime.parse(json['targetDate'] as String),
    targetSGIDate: json['targetSGIDate'] == null
        ? null
        : DateTime.parse(json['targetSGIDate'] as String),
    creationTime: DateTime.parse(json['creationTime'] as String),
    goalType: _$enumDecode(_$GoalTypeEnumMap, json['goalType']),
  );
}

Map<String, dynamic> _$GoalToJson(Goal instance) => <String, dynamic>{
      'title': instance.title,
      'targetDate': instance.targetDate?.toIso8601String(),
      'targetSGIDate': instance.targetSGIDate?.toIso8601String(),
      'targetTime': instance.targetTime?.toIso8601String(),
      'creationTime': instance.creationTime.toIso8601String(),
      'goalType': _$GoalTypeEnumMap[instance.goalType],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

const _$GoalTypeEnumMap = {
  GoalType.personal: 'personal',
  GoalType.community: 'community',
};
