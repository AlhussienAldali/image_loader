import 'package:flutter/material.dart';

import 'features/image_loader/image_loader_screen.dart';

void main() {
  runApp(const MyApp());
}
///Root app widget
class MyApp extends StatelessWidget {
  ///widget Constructor
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ImageLoader(),
    );
  }
}
