import 'package:flutter/material.dart';
import 'package:todo_apps/database/note_db.dart';
import 'package:todo_apps/themes/theme.dart';

class NotesGrid extends StatelessWidget {
  final int? id;
  final String priorities;
  final String title;
  final String description;
  final String createdAt;
  final VoidCallback func;
  final Color colorsPriority;

  const NotesGrid(
      {super.key,
      this.id,
      required this.priorities,
      required this.title,
      required this.description,
      required this.createdAt,
      required this.func,
      required this.colorsPriority});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: contentColor, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 8, right: 10, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.circle,
                  size: 10,
                  color: colorsPriority,
                ),
                const SizedBox(width: 5),
                Text(
                  priorities,
                  style: textStyle.copyWith(
                      fontSize: 10, fontWeight: semiBoldText),
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: textStyle.copyWith(fontSize: 14, fontWeight: boldText),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: textStyle.copyWith(fontSize: 12, fontWeight: semiBoldText),
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showPopUp(context, id!, func);
                  },
                  child: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                    size: 18,
                  ),
                ),
                Text(
                  'Created at: $createdAt',
                  style: textStyle.copyWith(
                      fontSize: 8,
                      fontWeight: semiBoldText,
                      color: cretedColor),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

showPopUp(BuildContext context, int id, VoidCallback func) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(
            Icons.warning_rounded,
            color: Colors.amber,
            size: 50,
          ),
          title: Text(
            'Do you want to delete this note ?',
            style: textStyle.copyWith(fontSize: 14, fontWeight: semiBoldText),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'No',
                style: textStyle.copyWith(
                    fontWeight: semiBoldText, color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                delete(id);
                func();
                Navigator.pop(context);
              },
              child: Text(
                'Yes',
                style: textStyle.copyWith(
                    fontWeight: semiBoldText, color: Colors.green),
              ),
            ),
          ],
        );
      });
}

Future delete(int id) async {
  await NotesDB.instance.delete(id);
}
