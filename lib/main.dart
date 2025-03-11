
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:healthcare/view/main_tab/main_tab_view.dart';
// ignore: unused_import
import 'package:healthcare/view/on_boarding/started_view.dart';


import 'common/color_extension.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'healthcare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: TColor.primaryColor1,
        fontFamily: "Poppins",
      ),
      home: const StartedView(),
    );
  }
}

