import 'package:flutter/material.dart';
import 'package:schedule/ui/pages/subject/new_subject.dart';

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
              actions: <Widget>[
                IconButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const NewSubjectPage())),
                    icon: const Icon(Icons.add))
              ],
            ),
            body: const Column(
              children: [
                Row(
                  children: [],
                )
              ],
            )));
  }
}
