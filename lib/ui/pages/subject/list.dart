import 'package:flutter/material.dart';
import 'package:schedule/ui/pages/subject/new_subject.dart';

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
              actions: <Widget>[
                IconButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const NewSubjectPage())),
                    icon: const Icon(Icons.add)),
                PopupMenuButton(
                    itemBuilder: (context) => [
                          const PopupMenuItem(
                              child: ListTile(
                            leading: Icon(Icons.visibility_outlined),
                            title: Text('Show hidden items'),
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
  @override
  Widget build(BuildContext context) {
    // DatabaseManager().getSubjects().then((subjects) => {});
    //
    // if (subjects.isEmpty) {
    //   return const Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Icon(Icons.sentiment_very_dissatisfied_rounded),
    //         Padding(padding: EdgeInsets.all(5)),
    //         Text(
    //           'There doesn\'t seem to be any classes right\nnow, maybe add one?',
    //           textAlign: TextAlign.center,
    //         )
    //       ],
    //     ),
    //   );
    // }

    return ListTile(
      isThreeLine: true,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(color: Colors.redAccent.shade100),
          child: const Center(
            child: Icon(Icons.school_outlined),
          ),
        ),
      ),
      title: const Text('Psychology 1A'),
      subtitle: const Text('Lorem ipsum, viva la revolution!'),
    );
  }
}
