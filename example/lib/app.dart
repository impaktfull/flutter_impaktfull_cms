import 'package:flutter/material.dart';
import 'package:impaktfull_cms_example/screen/home_screen.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ImpaktfullUiApp(
      title: 'impaktful',
      home: HomeScreen(),
    );
  }
}
