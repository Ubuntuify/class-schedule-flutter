import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Hello, \$user!',
              style: GoogleFonts.righteous(fontSize: 20, color: Colors.white),
            ))
      ],
    );
  }

  Subject _getNextSubject() {
    throw UnimplementedError(
        'getNextClass private function not yet implemented.');
  }
}
