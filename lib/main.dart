import 'package:flutter/material.dart';
import 'package:image_loader/features/random_image/ui/random_image_screen.dart';

void main() {
  runApp(const MyApp());
}

///Root app widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const RandomImageScreen(),
    );
  }
}
