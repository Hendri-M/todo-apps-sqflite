import 'package:flutter/material.dart';
import 'package:todo_apps/database/note_db.dart';
import 'package:todo_apps/models/notes.dart';
import 'package:todo_apps/themes/theme.dart';

List<String> priorities = ["High Priority", "Low Priority"];

void bottomSheets(
    BuildContext context,
    String? selected,
    int? id,
    bool update,
    VoidCallback set,
    TextEditingController title,
    TextEditingController desc,
    GlobalKey<FormState> key) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              right: 20,
              left: 20,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Form(
              key: key,
              child: Column(
                children: [
                  Divider(
                    height: 2,
                    thickness: 3,
                    indent: 125,
                    endIndent: 125,
                    color: textColorBlack.withAlpha(50),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'Your To-Do',
                    style:
                        textStyle.copyWith(fontSize: 20, fontWeight: boldText),
                  ),
                  const SizedBox(height: 17),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: DropdownButtonFormField(
                          value: selected,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: barrierColor,
                            isCollapsed: true,
                            contentPadding: const EdgeInsets.only(
                                left: 5, top: 2, bottom: 5),
                            hintText: 'Priority',
                            hintStyle: textStyle.copyWith(
                                fontSize: 12, fontWeight: regularText),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          validator: (value) =>
                              value == null ? 'Select priority' : null,
                          items: priorities
                              .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: textStyle.copyWith(
                                        fontSize: 12, fontWeight: regularText),
                                  )))
                              .toList(),
                          onChanged: (value) {
                            selected = value;
                          },
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: TextFormField(
                          controller: title,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: barrierColor,
                            isCollapsed: true,
                            hintText: 'Title',
                            hintStyle: textStyle.copyWith(
                                fontSize: 12, fontWeight: regularText),
                            contentPadding: const EdgeInsets.only(
                                left: 5, top: 2, bottom: 5),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? 'Input Title' : null,
                          textInputAction: TextInputAction.next,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: TextFormField(
                      controller: desc,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: barrierColor,
                        hintText: 'Your Todo',
                        hintStyle: textStyle.copyWith(fontWeight: regularText),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Input Description' : null,
                      maxLines: 8,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        if (update) {
                          updateNotes(id!, selected!, title.text, desc.text);

                          title.clear();
                          desc.clear();
                          set();
                          Navigator.pop(context);
                        } else {
                          addNotes(selected!, title.text, desc.text);

                          title.clear();
                          desc.clear();
                          set();
                          Navigator.pop(context);
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(btnSave),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    child: Text(
                      'Save',
                      style: textStyle.copyWith(
                          fontSize: 16,
                          fontWeight: regularText,
                          color: textColorWhite),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }).whenComplete(() {
    title.clear();
    desc.clear();
  });
}

Future addNotes(String prio, String title, String desc) async {
  DateTime date = DateTime.now();

  final notes = Notes(
    priority: prio,
    title: title,
    description: desc,
    createdAt: date,
  );

  await NotesDB.instance.create(notes);
}

Future updateNotes(int id, String prio, String title, String desc) async {
  DateTime date = DateTime.now();

  final notes = Notes(
    id: id,
    priority: prio,
    title: title,
    description: desc,
    createdAt: date,
  );

  await NotesDB.instance.update(notes);
}
