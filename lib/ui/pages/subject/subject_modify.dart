import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schedule/schema/subject.dart';
import 'package:schedule/services/db.dart';
import 'package:schedule/util/validate.dart';

class EditSubjectPage extends StatefulWidget {
  const EditSubjectPage(
      {super.key, this.subject, required this.editMode, this.callback});

  final Subject? subject;
  final bool editMode;

  final Function? callback;

  @override
  State<EditSubjectPage> createState() => _EditSubjectPageState();
}

class _EditSubjectPageState extends State<EditSubjectPage> {
  // ✨
  // All fields within the EditSubjectPage class. Assigned a value during widget
  // initialization.
  late String _name;
  late String _location;
  late String _description;
  late bool _visibleCheckbox;
  late bool _restPeriodCheckbox;

  Future<void> _onSubmit(BuildContext context) async {
    // ✨
    // Empty text fields create undefined behavior in the SQLite database. There
    // should most likely also add a warning in the text box itself.
    if (_name == '' || _location == '' || _description == '') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Text fields must not be empty'),
          behavior: SnackBarBehavior.floating));
      return;
    }

    // ✨
    // Uses the DatabaseManager to insert a subject. It will replace if there is
    // an existing instance, therefore ID is not provided as an editable argument
    // for users.
    Subject createdSubject = Subject(
        id: widget.editMode ? widget.subject!.id : null,
        name: _name,
        location: _location,
        description: _description,
        isVisible: _visibleCheckbox,
        isRestPeriod: _restPeriodCheckbox);

    if (widget.editMode) {
      DatabaseManager().updateSubject(createdSubject);
    } else {
      DatabaseManager().insertSubject(createdSubject);
    }

    widget.callback!();

    // ✨
    // Pops the current screen, once finished.
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(widget.editMode
            ? 'Successfully updated course "${createdSubject.name}"!'
            : 'Successfully created course!'),
        behavior: SnackBarBehavior.floating));
  }

  @override
  void initState() {
    // 🚫
    // This is an error check for making sure an invalid state does not occur.
    if (widget.editMode && widget.subject == null) {
      throw ArgumentError(
          'EditSubjectPage.editMode was true, when a Subject was not passed to the Widget.');
    }

    // ✨
    // Since both create and edit subject pages are now integrated, we can no longer set
    // the variables at initialization. It is now set at initState() when the page gets
    // added to the Navigator.
    _name = widget.editMode ? widget.subject!.name : '';
    _location = widget.editMode ? widget.subject!.location : '';
    _description = widget.editMode ? widget.subject!.description : '';
    _visibleCheckbox = widget.editMode ? widget.subject!.isVisible : true;
    _restPeriodCheckbox =
        widget.editMode ? widget.subject!.isRestPeriod : false;

    // ✨
    // Continue initializing the Widget? state.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> formOptions = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: SizedBox(
                width: 375,
                child: TextFormField(
                  initialValue: _name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormFieldValidators.validateSqlFormField,
                  maxLength: 48,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Subject'),
                  onChanged: (subjectName) => _name = subjectName,
                  autofocus: true,
                ))),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: SizedBox(
                width: 375,
                child: TextFormField(
                  initialValue: _location,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormFieldValidators.validateSqlFormField,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Location'),
                  maxLength: 48,
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
                child: TextFormField(
                  initialValue: _description,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormFieldValidators.validateSqlFormField,
                  maxLength: 80,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  maxLines: 3,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Description'),
                  onChanged: (text) => _description = text,
                ))),
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Divider(),
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
          child: Row(children: [
            Checkbox(
                value: _visibleCheckbox,
                onChanged: (status) =>
                    setState(() => _visibleCheckbox = status!)),
            const Text(
              'Visible',
            )
          ]))
    ];

    if (widget.editMode) {
      formOptions.insert(
          0,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: SizedBox(
                    width: 375,
                    child: TextFormField(
                      initialValue: widget.subject!.id.toString(),
                      enabled: false,
                      readOnly: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'ID'),
                    ))),
          ));
    }

    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: AppBar(
          leading: const CloseButton(),
          title: widget.editMode
              ? const Text('Edit Subject')
              : const Text('New Subject'),
          actions: <Widget>[
            TextButton(
                onPressed: () => _onSubmit(context),
                child:
                    widget.editMode ? const Text('Save') : const Text('Create'))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: formOptions),
        ),
      ),
    );
  }
}
