import 'package:flutter/material.dart';

import 'pages/homepage.dart';
import 'pages/splashscreen.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const Splashscreen(),
      '/home': (context) => const Home()
    },
  ));
}
