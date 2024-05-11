import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_apps/themes/theme.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    });

    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(color: background),
      child: Center(
        child: Image.asset(
          'assets/Icon.png',
          width: 120,
          height: 120,
        ),
      ),
    );
  }
}
