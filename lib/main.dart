import 'package:flutter/material.dart';
import 'package:language_trf/date.dart';
// import 'package:language_trf/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: dateconverterScreen(),
    );
  }
}
