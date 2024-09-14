import 'package:flutter/material.dart';

class ScheduleTimeSlot {
  // Primary key
  final int? id;

  // Foreign key – day schedule id mapping.
  final int dayScheduleId;

  final TimeOfDay startTime;

  final TimeOfDay endTime;

  const ScheduleTimeSlot(
      {required this.id,
      required this.dayScheduleId,
      required this.startTime,
      required this.endTime});

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'day_schedule_id': dayScheduleId,
      'start_time': startTime.toString(),
      'end_time': endTime.toString(),
    };
  }
}
