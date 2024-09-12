import 'package:flutter/material.dart';
import 'package:schedule/schema/schedule.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: Text('Hi, <PLACEHOLDER>!'),
        )
      ],
    );
  }

  Subject _getNextSubject() {
    throw UnimplementedError(
        'getNextClass private function not yet implemented.');
  }
}
