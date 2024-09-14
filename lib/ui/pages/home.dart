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
    return const Column(children: [
      Padding(
          padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 10),
          child: Row(
            children: [
              Card(
                child: SizedBox(
                  height: 100,
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Text('Next Class'),
                            Spacer(),
                            Icon(Icons.school),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          'Psychology 1A',
                        ), // TODO: change stub
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          children: [
                            Icon(Icons.schedule, size: 15),
                            Text(' in %% minutes '),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Card()
            ],
          ))
    ]);
  }

  Future<Subject> _getNextSubject() async {
    TimeOfDay now = TimeOfDay.now();

    throw UnimplementedError(
        'getNextClass private function not yet implemented.');
  }
}
