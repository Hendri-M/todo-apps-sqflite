import 'package:flutter/material.dart';
import 'package:todo_apps/items/items.dart';
import 'package:todo_apps/themes/theme.dart';
import 'package:todo_apps/widgets/staggered_grid.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? selectedPriority;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
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
                  )),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          filled: true,
                          isCollapsed: true,
                          fillColor: barrierColor,
                          hintText: 'Filter',
                          hintStyle: textStyle.copyWith(
                              fontWeight: regularText, color: hintColor),
                          contentPadding: const EdgeInsets.only(
                              left: 10, top: 5, bottom: 5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        items: priorities
                            .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: textStyle.copyWith(
                                      fontWeight: regularText,
                                      color: textColorBlack),
                                )))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedPriority = value!;
                          });
                        }),
                  )
                ],
              ),
              const SizedBox(height: 15),
              const Expanded(
                child: GridViewNotes(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
