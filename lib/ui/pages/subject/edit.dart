import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schedule/schema/subject.dart';
import 'package:schedule/services/db.dart';

class NewSubjectPage extends StatefulWidget {
  const NewSubjectPage({super.key});

  @override
  State<NewSubjectPage> createState() => _NewSubjectPageState();
}

class _NewSubjectPageState extends State<NewSubjectPage> {
  bool _visibleCheckbox = true;
  bool _restPeriodCheckbox = false;

  String _name = '';
  String _location = '';
  String _description = '';

  Future<void> _onSubmit(BuildContext context) async {
    if (_name == '') return; // TODO: give error feedback
    if (_location == '') return;
    if (_description == '') return;

    DatabaseManager().insertSubject(Subject(
        id: null,
        name: _name,
        location: _location,
        description: _description,
        isVisible: _visibleCheckbox,
        isRestPeriod: _restPeriodCheckbox));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        child: Scaffold(
          appBar: AppBar(
              leading: const BackButton(), title: const Text('New Subject')),
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
                            maxLength: 10,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Subject'),
                            onChanged: (subjectName) => _name = subjectName,
                            autofocus: true,
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: SizedBox(
                          width: 375,
                          child: TextField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Location'),
                            maxLength: 10,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            onChanged: (text) => _location = text,
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: SizedBox(
                          width: 375,
                          height: 110,
                          child: TextField(
                            maxLength: 80,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            maxLines: 3,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Description'),
                            onChanged: (text) => _description = text,
                          ))),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Checkbox(
                            value: _restPeriodCheckbox,
                            onChanged: (status) =>
                                setState(() => _restPeriodCheckbox = status!)),
                        const Text('Rest Period')
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Checkbox(
                          value: _visibleCheckbox,
                          onChanged: (status) =>
                              setState(() => _visibleCheckbox = status!)),
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
