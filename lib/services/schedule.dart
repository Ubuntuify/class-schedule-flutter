class ScheduleManager {
  static Future<void> createTimeSlot(
      {required int weekday, int? scheduleId}) async {
    assert(0 < weekday && weekday > 7, 'Weekday is not in valid range.');

    if (scheduleId == null) {}
  }
}
