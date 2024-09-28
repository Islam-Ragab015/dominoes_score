import 'package:dominoes_score_calc/splash.dart';
import 'package:flutter/material.dart';

// Main function to run the app
void main() {
  runApp(const DominoesScoreCalculatorApp());
}

// Root widget of the app
class DominoesScoreCalculatorApp extends StatelessWidget {
  const DominoesScoreCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner
      title: 'Dominoes Score Calculator',
      theme: ThemeData(
        primarySwatch: Colors.teal, // Primary color for the app
      ),
      home: const SplashScreen(),
    );
  }
}
