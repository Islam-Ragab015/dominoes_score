import 'package:flutter/material.dart';
import 'package:dominoes_score_calc/splash.dart';

void main() {
  runApp(const DominoesScoreCalculatorApp());
}

class DominoesScoreCalculatorApp extends StatefulWidget {
  const DominoesScoreCalculatorApp({super.key});

  @override
  _DominoesScoreCalculatorAppState createState() =>
      _DominoesScoreCalculatorAppState();
}

class _DominoesScoreCalculatorAppState
    extends State<DominoesScoreCalculatorApp> {
  bool _isDarkMode = false; // Theme state
  Locale _locale = const Locale('en'); // Language state

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _toggleLanguage() {
    setState(() {
      _locale = _locale.languageCode == 'en'
          ? const Locale('ar')
          : const Locale('en');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      locale: _locale,
      home: const SplashScreen(),
    );
  }
}
