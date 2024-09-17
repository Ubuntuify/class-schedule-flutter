import 'package:flutter/material.dart';
import 'package:schedule/services/db.dart';

import '../../schema/subject.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseManager databaseManager = DatabaseManager();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Card(
          child: SizedBox(
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [Icon(Icons.school_rounded), Placeholder()],
                )),
          ),
        ),
      ],
    );
  }

  Future<Subject> _getNextSubject() async {
    TimeOfDay now = TimeOfDay.now();

    throw UnimplementedError(
        'getNextClass private function not yet implemented.');
  }
}
