import 'package:flutter/material.dart';
import 'package:todo_apps/items/items.dart';
import 'package:todo_apps/themes/theme.dart';

void bottomSheets(BuildContext context, String? selected,
    TextEditingController? title, TextEditingController? desc) {
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
                  style: textStyle.copyWith(fontSize: 20, fontWeight: boldText),
                ),
                const SizedBox(height: 17),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: DropdownButtonFormField(
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
                          }),
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
                        contentPadding:
                            const EdgeInsets.only(left: 5, top: 2, bottom: 5),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ))
                  ],
                ),
                const SizedBox(height: 15),
                TextFormField(
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
                  maxLines: 8,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      title!.clear();
                      desc!.clear();
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(btnSave),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ))),
                    child: Text(
                      'Save',
                      style: textStyle.copyWith(
                          fontSize: 16,
                          fontWeight: regularText,
                          color: textColorWhite),
                    ))
              ],
            ),
          ),
        );
      });
}
