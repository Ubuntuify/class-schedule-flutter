import 'package:flutter/material.dart';
import 'package:schedule/schema/subject.dart';
import 'package:schedule/services/db.dart';

class NewSubjectPage extends StatefulWidget {
  const NewSubjectPage({super.key});

  @override
  State<NewSubjectPage> createState() => _NewSubjectPageState();
}

class _NewSubjectPageState extends State<NewSubjectPage> {
  bool _isVisibleCheckbox = true;
  bool _isRestPeriodCheckbox = false;

  String _subjectName = '';

  Future<void> _onSubmit(BuildContext context) async {
    DatabaseManager().insertSubject(Subject(
        id: null,
        name: _subjectName,
        isVisible: _isVisibleCheckbox,
        isRestPeriod: _isRestPeriodCheckbox));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        child: Scaffold(
          appBar: AppBar(
              leading: const BackButton(), title: const Text('New Subject')),
          // bottomNavigationBar: BottomAppBar(
          //   child: ,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: SizedBox(
                          width: 375,
                          child: TextField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Subject'),
                            onChanged: (subjectName) =>
                                _subjectName = subjectName,
                          ))),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Checkbox(
                            value: _isRestPeriodCheckbox,
                            onChanged: (checked) => setState(
                                () => _isRestPeriodCheckbox = checked!)),
                        const Text('Rest Period')
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Checkbox(
                          value: _isVisibleCheckbox,
                          onChanged: (checked) =>
                              setState(() => _isVisibleCheckbox = checked!)),
                      const Text(
                        'Visible',
                      )
                    ],
                  ),
                ),
                FilledButton(
                    onPressed: () => _onSubmit(context),
                    child: const Text('Create')),
              ],
            ),
          ),
        ));
  }
}
