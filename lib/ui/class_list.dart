import 'package:flutter/material.dart';

class ClassListPage extends StatelessWidget {
  const ClassListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        child: Scaffold(
            appBar: AppBar(
              leading: const BackButton(),
              title: const Text('Classes'),
            ),
            body: const Column(
              children: [],
            )));
  }
}
