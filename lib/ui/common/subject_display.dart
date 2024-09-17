import 'package:flutter/material.dart';
import 'package:schedule/schema/subject.dart';
import 'package:schedule/ui/pages/subject/edit_subject.dart';
import 'package:schedule/ui/pages/subject/view_subject.dart';

import 'icon.dart';

enum SubjectDisplayMenuBar { delete, edit }

class SubjectDisplayItem extends StatefulWidget {
  const SubjectDisplayItem({super.key, required this.subject});

  // ✨
  // Subject to display.
  final Subject subject;

  @override
  State<SubjectDisplayItem> createState() => _SubjectDisplayItemState();
}

class _SubjectDisplayItemState extends State<SubjectDisplayItem> {
  void showButtonMenu() {
    final RenderBox displayItem = context.findRenderObject()! as RenderBox;
    final RenderBox overlay = Navigator.of(
      context,
    ).overlay!.context.findRenderObject()! as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
        Rect.fromPoints(
            displayItem.localToGlobal(displayItem.size.bottomLeft(Offset.zero)),
            displayItem
                .localToGlobal(displayItem.size.bottomRight(Offset.zero))),
        Offset.zero & overlay.size);

    showMenu(
        context: context,
        items: <PopupMenuEntry<SubjectDisplayMenuBar>>[
          PopupMenuItem(
            child: ListTile(
              leading: const Icon(Icons.edit),
              title: Text("Edit '${widget.subject.name}'"),
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditSubjectPage(
                      subject: widget.subject,
                      editMode: true,
                    ))),
          ),
          PopupMenuItem(
            value: SubjectDisplayMenuBar.delete,
            child: ListTile(
              leading: const Icon(Icons.delete_forever_outlined),
              title: Text("Delete '${widget.subject.name}'"),
            ),
            onTap: () => showDeleteDialog(),
          )
        ],
        position: position);
  }

  void showDeleteDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: const Icon(Icons.delete_outline),
            title: const Center(child: Text('Delete')),
            content: Text(
              'Are you sure you want to delete \'${widget.subject.name}\'? '
              'This is a permanent action and cannot be reversed.',
              textAlign: TextAlign.justify,
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () => throw UnimplementedError(),
                  child: const Text('Yes, I\'m sure')),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('No')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                SubjectViewPage(subject: widget.subject))),
        onLongPress: () => showButtonMenu(),

        // ✨
        // Creates the logo before the subject for cool factor.
        leading: IconBorder(
            icon: widget.subject.isRestPeriod
                ? const Icon(Icons.air_outlined)
                : const Icon(Icons.school_outlined)),

        // ✨
        // Actual subject information.
        title: Text(widget.subject.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.subject.description,
              textAlign: TextAlign.left,
            ),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3.0, vertical: 2),
                  child: Text(widget.subject.location),
                )
              ],
            )
          ],
        ));
  }
}
