import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:todo_apps/themes/theme.dart';
import 'package:todo_apps/widgets/bottomsheet.dart';
import 'package:todo_apps/widgets/grid_notes.dart';

import '../models/notes.dart';

class GridViewNotes extends StatelessWidget {
  final List<Notes> notes;
  final VoidCallback func;
  GridViewNotes({super.key, required this.notes, required this.func});

  Color getColor(String color) {
    switch (color) {
      case "High Priority":
        return prRed;
      case "Medium Priority":
        return prYellow;
      case "Low Priority":
        return prOrange;
      default:
        Colors.grey[400];
    }
    return Colors.grey;
  }

  final keys = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      itemCount: notes.length,
      mainAxisSpacing: 10,
      crossAxisSpacing: 15,
      padding: const EdgeInsets.only(bottom: 10, top: 5),
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
      itemBuilder: (context, idx) {
        return GestureDetector(
          onTap: () => bottomSheets(
              context,
              notes[idx].priority,
              notes[idx].id,
              true,
              func,
              TextEditingController(text: notes[idx].title),
              TextEditingController(text: notes[idx].description),
              keys),
          child: NotesGrid(
              id: notes[idx].id,
              priorities: notes[idx].priority,
              title: notes[idx].title,
              description: notes[idx].description,
              createdAt: DateFormat("dd/MM/yyyy").format(notes[idx].createdAt),
              func: func,
              colorsPriority: getColor(notes[idx].priority)),
        );
      },
    );
  }
}
