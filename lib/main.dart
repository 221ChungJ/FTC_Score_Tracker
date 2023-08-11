import 'package:flutter/material.dart';
import 'package:ftc_score_tracker/score_data.dart';
import 'package:provider/provider.dart';
import '../screens/welcome_screen.dart';
import '../screens/scoring_screen.dart';

void main() {
  runApp(FTCScoreTracker());
}

class FTCScoreTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ScoreData>(
      lazy: false,
      create: (context) => ScoreData(),
      child: MaterialApp(initialRoute: WelcomeScreen.id, routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        ScoringScreen.id: (context) => ScoringScreen(),
      }),
    );
  }
}

