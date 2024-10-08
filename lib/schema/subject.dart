import 'package:schedule/util/util.dart';

class Subject {
  //
  //
  final int? id; // primary key
  final String name;
  final String description;
  final String location;
  final bool isVisible; // if it is visible in the user interface
  final bool isRestPeriod; // if it is a rest period

  const Subject(
      {required this.id, // primary key should always come first
      required this.name,
      required this.isVisible,
      required this.isRestPeriod,
      required this.description,
      required this.location});

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'location': location,
      'is_visible': isVisible,
      'is_rest_period': isRestPeriod,
    };
  }

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        location: map['location'],
        isVisible: intToBool(map['is_visible']),
        isRestPeriod: intToBool(map['is_rest_period']));
  }

  @override
  String toString() =>
      "{'id': $id, 'name': $name, 'description': $description, 'location': $location, 'is_visible': $isVisible, 'is_rest_period': $isRestPeriod}";
}
