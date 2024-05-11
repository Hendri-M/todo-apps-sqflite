import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:todo_apps/themes/theme.dart';
import 'package:todo_apps/widgets/grid_notes.dart';

class GridViewNotes extends StatelessWidget {
  const GridViewNotes({super.key});

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

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
        itemCount: 10,
        mainAxisSpacing: 22,
        crossAxisSpacing: 15,
        padding: const EdgeInsets.only(bottom: 10, top: 5),
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (context, idx) {
          return NotesGrid(
              priorities: 'High Priority',
              title: 'Trial Notes',
              description:
                  'This is a trial notes text, for check the text box can be filled or scrolled',
              createdAt: DateFormat("dd/MM/yyyy").format(DateTime.now()),
              colorsPriority: getColor('High Priority'));
        });
  }
}
