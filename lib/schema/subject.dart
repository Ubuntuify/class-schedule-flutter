class Subject {
  // Primary key
  final int? id;

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

  // factory Subject.fromMap(Map<String, dynamic> map) {
  //   return Subject(
  //       id: map['id'], name: 'default', isVisible: true, isRestPeriod: false);
  // }

  @override
  String toString() =>
      "{'id': $id, 'name': $name, 'is_visible': $isVisible, 'is_rest_period': $isRestPeriod}";
}
