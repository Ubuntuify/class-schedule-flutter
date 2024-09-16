// import 'dart:core';
//
// class ClassTimeMap {
//   // Primary key
//   final int id;
//
//   // Foreign key – DaySchedule
//   final int dayScheduleId;
//
//   // Foreign key – Subject
//   final int subjectsId;
//
//   // Foreign key – ScheduleTimeSlot
//   final int scheduleTimeSlotId;
//
//   const ClassTimeMap(
//       {required this.id,
//       required this.dayScheduleId,
//       required this.subjectId,
//       required this.scheduleTimeSlotId});
//
//   Map<String, Object?> toMap() {
//     return {
//       'id': id,
//       'day_schedule_id': dayScheduleId,
//       'schedule_time_slot_id': scheduleTimeSlotId,
//     };
//   }
// }
//
// class User {
//   // Primary key
//   final int id;
//
//   // Data field
//   final List<int> subjectIds;
//
//   // TODO: see if implementation can be changed
//
//   const User({required this.id, required this.subjectIds});
//
//   Map<String, Object?> toMap() {
//     return {
//       'id': id,
//       'subject_ids': subjectIds,
//     };
//   }
// }
//
// class Reminder {
//   // Primary key
//   final int id;
//
//   // Reminder name
//   final String name;
//
//   // Reminder description
//   final String description;
//
//   // Subject (ownership)
//   final int subjectId;
//
//   // TODO: add more required fields.
//
//   const Reminder(
//       {required this.id,
//       required this.name,
//       required this.description,
//       required this.subjectId});
//
//   Map<String, Object?> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description,
//       'subject_id': subjectId,
//     };
//   }
// }
