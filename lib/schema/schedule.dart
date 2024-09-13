import 'dart:core';

class Subject {
  // Primary key
  final int id;

  // Display name
  final String name;

  // If it is visible in the user interface
  final bool isVisible;

  // If the subject is a rest period and you should be notified
  final bool isRestPeriod;

  const Subject(
      {required this.id, // primary key should always come first
      required this.name,
      required this.isVisible,
      required this.isRestPeriod});

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'is_visible': isVisible,
      'is_rest_period': isRestPeriod,
    };
  }

  @override
  String toString() {
    return "{'id': $id, 'name': $name, 'is_visible': $isVisible, 'is_rest_period': $isRestPeriod}";
  }
}

class DaySchedule {
  // Primary key
  final int id;

  // Weekday, should be compatible with Dart's weekdays.
  final int weekday;

  // If this schedule is the default one that should be used.
  final bool isSpecial;

  const DaySchedule(
      {required this.id, required this.weekday, required this.isSpecial});

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'weekday': weekday,
      'is_special': isSpecial,
    };
  }
}

class ScheduleTimeSlot {
  // Primary key
  final int id;

  // Foreign key – day schedule id mapping.
  final int dayScheduleId;

  // TODO: add a better date implementation

  const ScheduleTimeSlot({required this.id, required this.dayScheduleId});

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'day_schedule_id': dayScheduleId,
    };
  }
}

class ClassTimeMap {
  // Primary key
  final int id;

  // Foreign key – DaySchedule
  final int dayScheduleId;

  // Foreign key – Subject
  final int subjectId;

  // Foreign key – ScheduleTimeSlot
  final int scheduleTimeSlotId;

  const ClassTimeMap(
      {required this.id,
      required this.dayScheduleId,
      required this.subjectId,
      required this.scheduleTimeSlotId});

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'day_schedule_id': dayScheduleId,
      'schedule_time_slot_id': scheduleTimeSlotId,
    };
  }
}

class User {
  // Primary key
  final int id;

  // Data field
  final List<int> subjectIds;

  // TODO: see if implementation can be changed

  const User({required this.id, required this.subjectIds});

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'subject_ids': subjectIds,
    };
  }
}

class Reminder {
  // Primary key
  final int id;

  // Reminder name
  final String name;

  // Reminder description
  final String description;

  // Subject (ownership)
  final int subjectId;

  // TODO: add more required fields.

  const Reminder(
      {required this.id,
      required this.name,
      required this.description,
      required this.subjectId});

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'subject_id': subjectId,
    };
  }
}
