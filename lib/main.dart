import 'package:dominoes_score_calc/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DominoesScoreCalculatorApp());
}

class DominoesScoreCalculatorApp extends StatelessWidget {
  const DominoesScoreCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const SplashScreen(),
    );
  }
}
