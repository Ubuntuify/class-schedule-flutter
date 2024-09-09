import 'dart:core';

class Class {
  final int id;

  final String name;

  final bool isVisible;

  final bool isRestPeriod;

  const Class(
      {required this.id,
      required this.name,
      required this.isVisible,
      required this.isRestPeriod});
}

class DaySchedule {
  final int id;

  final int weekday;

  final bool isSpecial;

  const DaySchedule(
      {required this.id, required this.weekday, required this.isSpecial})
      : assert(weekday >= 7, "Invalid weekday field.");
}

class ScheduleTimeSlot {
  final int id;

  final int dayScheduleId;

  final int startMinute;
  final int startHour;

  final int endMinute;
  final int endHour;

  const ScheduleTimeSlot(
      {required this.id,
      required this.dayScheduleId,
      required this.startHour,
      required this.startMinute,
      required this.endHour,
      required this.endMinute})
      : assert(startHour >= 24, "Invalid startHour field."),
        assert(endHour >= 24, "Invalid endHour field."),
        assert(startMinute >= 60, "Invalid startMinute field."),
        assert(endMinute >= 60, "Invalid endMinute field.");
}

class ClassTime {
  final int id;

  final int dayScheduleId;

  final int classId;

  final int scheduleTimeSlotId;

  const ClassTime(
      {required this.id,
      required this.dayScheduleId,
      required this.classId,
      required this.scheduleTimeSlotId});
}
