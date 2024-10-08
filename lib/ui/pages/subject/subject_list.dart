import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:schedule/schema/subject.dart';
import 'package:schedule/services/db.dart';
import 'package:schedule/ui/common/subject_display.dart';
import 'package:schedule/ui/pages/subject/subject_modify.dart';

class ClassListPage extends StatefulWidget {
  const ClassListPage({super.key});

  @override
  State<ClassListPage> createState() => _ClassListPageState();
}

enum ListMenuBar { showHidden, sortBy }

class _ClassListPageState extends State<ClassListPage> {
  static Future<List<Subject>>? subjects;
  bool hiddenVisibility = false;

  @override
  void initState() {
    subjects = DatabaseManager().subjects();
    super.initState();
  }

  void _reloadList() {
    setState(() {
      subjects = DatabaseManager().subjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,

        // ✨
        // Create a full Scaffold as classes is a whole page instead of just an element.
        child: Scaffold(

            // ✨
            // Create an app bar with a back button and other actions.
            appBar: AppBar(
              leading: const BackButton(),
              title: const Text('Classes'),
              scrolledUnderElevation: 1,
              actions: <Widget>[
                IconButton(
                    // ✨
                    // Push the new subject page onto the stack.
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => EditSubjectPage(
                                editMode: false, callback: _reloadList))),
                    tooltip: 'Add subject',
                    icon: const Icon(Icons.add)),
                PopupMenuButton(
                    // ✨
                    // Create a new MenuBar for other options like sorting, etc.
                    itemBuilder: (context) => <PopupMenuEntry<ListMenuBar>>[
                          PopupMenuItem<ListMenuBar>(
                              value: ListMenuBar.showHidden,
                              onTap: () => setState(() {
                                    hiddenVisibility = !hiddenVisibility;
                                  }),
                              child: ListTile(
                                leading: hiddenVisibility
                                    ? const Icon(Icons.visibility_off_outlined)
                                    : const Icon(Icons.visibility_outlined),
                                title: Text(hiddenVisibility
                                    ? 'Hide hidden items'
                                    : 'Show hidden items'),
                              ))
                        ],
                    icon: const Icon(Icons.more_vert)),
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder<List<Subject>>(
                    future: subjects,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Subject>> snapshot) {
                      // ✨
                      // Verify if the Future returns with data. This makes sure
                      // that 'subjects' is not null.
                      if (snapshot.hasData) {
                        // ✨
                        // Filters based on visibility.
                        Iterable<Subject> visibleSubjects = !hiddenVisibility
                            ? snapshot.data!.where((data) => data.isVisible)
                            : snapshot.data!;

                        if (visibleSubjects.isEmpty) {
                          dev.log(
                              "No visible subjects found in table 'subjects', showing no classes screen.");

                          // ✨
                          // Returns a no classes screen and asks to add a subject if no visible subjects
                          // are found. Return statement prevents other code from running.
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.sentiment_very_dissatisfied_rounded),
                                Padding(
                                    padding: EdgeInsets.all(8),
                                    child: SizedBox(
                                      width: 220,
                                      child: Text(
                                        "There doesn't seem to be any classes right now, maybe add one?",
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                              ],
                            ),
                          );
                        }

                        // ✨
                        // This code runs when at least one visible subject is found.
                        dev.log(
                            "Found ${visibleSubjects.length} visible subjects out of ${snapshot.data!.length} total. Hidden visibility is set to $hiddenVisibility. Displaying list.");

                        // ✨
                        // Returns a ListView with an itemBuilder to create the items and add dividers.
                        return ListView.separated(
                          itemCount: visibleSubjects.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                          itemBuilder: (BuildContext context, int index) {
                            // ✨
                            // Gets current subject by using the index provided as a list.
                            Subject subject = visibleSubjects.toList()[index];

                            return SubjectDisplayItem(
                                subject: subject, callback: _reloadList);
                          },
                        );
                      } else {
                        // if: snapshot doesn't have a value yet.
                        return const Center(
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    }),
              ),
            )));
  }
}
