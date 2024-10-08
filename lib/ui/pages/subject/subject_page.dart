import 'package:flutter/material.dart';
import 'package:schedule/schema/subject.dart';

class SubjectViewPage extends StatefulWidget {
  const SubjectViewPage({super.key, required this.subject});

  final Subject subject;

  @override
  State<SubjectViewPage> createState() => _SubjectViewPageState();
}

class _SubjectViewPageState extends State<SubjectViewPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
