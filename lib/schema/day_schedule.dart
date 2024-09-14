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
