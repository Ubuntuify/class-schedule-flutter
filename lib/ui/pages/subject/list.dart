import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:schedule/schema/subject.dart';
import 'package:schedule/services/db.dart';
import 'package:schedule/ui/pages/subject/new.dart';

class ClassListPage extends StatefulWidget {
  const ClassListPage({super.key});

  @override
  State<ClassListPage> createState() => _ClassListPageState();
}

class _ClassListPageState extends State<ClassListPage> {
  bool hiddenVisibility = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        child: Scaffold(
            appBar: AppBar(
              leading: const BackButton(),
              title: const Text('Classes'),
              scrolledUnderElevation: 1,
              actions: <Widget>[
                IconButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const NewSubjectPage())),
                    icon: const Icon(Icons.add)),
                PopupMenuButton(
                    itemBuilder: (context) => [
                          PopupMenuItem(
                              child: ListTile(
                            leading: const Icon(Icons.visibility_outlined),
                            title: Text(hiddenVisibility
                                ? 'Hide' ' hidden items'
                                : 'Show' ' hidden items'),
                          ))
                        ],
                    icon: const Icon(Icons.more_vert)),
              ],
            ),
            body: const ClassList()));
  }
}

class ClassList extends StatefulWidget {
  const ClassList({super.key});

  @override
  State<ClassList> createState() => _ClassListState();
}

class _ClassListState extends State<ClassList> {
  static Future<List<Subject>>? subjects;
  bool hiddenVisibility = false;

  @override
  void initState() {
    subjects = DatabaseManager().getSubjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Subject>>(
            future: subjects,
            builder:
                (BuildContext context, AsyncSnapshot<List<Subject>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  // TODO: change logic to pre-process table and use more native;
                  dev.log("Subject table is empty, using empty widget.");
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
                } else {
                  // ✨
                  // Filters based on visibility.
                  Iterable<Subject> visibleSubjects = !hiddenVisibility
                      ? snapshot.data!.where((data) => data.isVisible)
                      : snapshot.data!;

                  return ListView.separated(
                    itemCount: visibleSubjects.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemBuilder: (BuildContext context, int index) {
                      Subject subject = visibleSubjects.toList()[index];

                      return ListTile(
                          onTap: () => {},
                          onLongPress: () => {},

                          // ✨
                          // Creates the logo before the subject for cool factor.
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                  // proper dark mode support
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Theme.of(context)
                                          .colorScheme
                                          .primaryFixed
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSecondary),
                              child: const Center(
                                child: Icon(Icons.school_outlined),
                              ),
                            ),
                          ),

                          // ✨
                          // Actual subject information.
                          title: Text(subject.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                subject.description,
                                textAlign: TextAlign.left,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    size: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3.0, vertical: 2),
                                    child: Text(subject.location),
                                  )
                                ],
                              )
                            ],
                          ));
                    },
                  );
                }
              } else if (snapshot.hasError) {
                throw Error();
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
    );
  }
}
