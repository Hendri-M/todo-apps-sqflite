import 'package:flutter/material.dart';
import 'package:todo_apps/themes/theme.dart';

class NotesGrid extends StatelessWidget {
  final String priorities;
  final String title;
  final String description;
  final String createdAt;
  final Color colorsPriority;

  const NotesGrid(
      {super.key,
      required this.priorities,
      required this.title,
      required this.description,
      required this.createdAt,
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
              style: textStyle.copyWith(fontSize: 14, fontWeight: semiBoldText),
            ),
            const SizedBox(height: 2),
            Text(
              description,
              style: textStyle.copyWith(fontSize: 10, fontWeight: semiBoldText),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
