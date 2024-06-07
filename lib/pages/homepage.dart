import 'package:flutter/material.dart';
import 'package:todo_apps/database/note_db.dart';
import 'package:todo_apps/models/notes.dart';
import 'package:todo_apps/themes/theme.dart';
import 'package:todo_apps/widgets/bottomsheet.dart';
import 'package:todo_apps/widgets/staggered_grid.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? selectedPriority;
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController search = TextEditingController();
  final key = GlobalKey<FormState>();

  Future<List<Notes>> getDataNotes() async {
    return await NotesDB.instance.readAllNotes();
  }

  void refresh() {
    setState(() {
      getDataNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bottomSheets(
              context, selectedPriority, 0, false, refresh, title, desc, key);
        },
        backgroundColor: fabColor,
        splashColor: Colors.pink[300],
        shape: const CircleBorder(),
        child: Image.asset(
          'assets/fabIcon.png',
          scale: 3.5,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello there,\nThis is your to-do-list.",
                style: textStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semiBoldText,
                    color: textColorWhite),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  controller: search,
                  decoration: InputDecoration(
                    filled: true,
                    isCollapsed: true,
                    isDense: true,
                    fillColor: barrierColor,
                    hintText: 'Search. . .',
                    hintStyle: textStyle.copyWith(
                        fontWeight: regularText, color: hintColor),
                    contentPadding:
                        const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  style: textStyle.copyWith(
                      fontWeight: regularText, color: textColorBlack),
                  onChanged: (value) {
                    setState(() {
                      search.text = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 15),
              FutureBuilder(
                future: getDataNotes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          'Notes Error',
                          style: textStyle.copyWith(
                              fontSize: 14,
                              fontWeight: semiBoldText,
                              color: Colors.red),
                        ),
                      ),
                    );
                  }
                  if (snapshot.data!.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          'Notes is Empty',
                          style: textStyle.copyWith(
                              fontSize: 14,
                              fontWeight: semiBoldText,
                              color: textColorWhite),
                        ),
                      ),
                    );
                  }
                  final data = snapshot.data!;
                  if (search.text != '') {
                    return Expanded(
                      child: GridViewNotes(
                        notes: data
                            .where((note) => note.title
                                .toLowerCase()
                                .contains(search.text.toLowerCase()))
                            .toList(),
                        func: refresh,
                      ),
                    );
                  }
                  return Expanded(
                    child: GridViewNotes(
                      notes: data,
                      func: refresh,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
