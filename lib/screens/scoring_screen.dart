import 'package:flutter/material.dart';
import 'package:ftc_score_tracker/constants.dart';
import '../pages/current_score_page.dart';
import '../pages/saved_scores_page.dart';

class ScoringScreen extends StatefulWidget {
  static const String id = 'scoring_screen';

  @override
  _ScoringScreenState createState() => _ScoringScreenState();
}

class _ScoringScreenState extends State<ScoringScreen> {
  late TextEditingController _controller;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppbarColor,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            label: 'Current Score',
            backgroundColor: kIconColorGreen,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border_outlined),
            label: 'Saved Scores',
            backgroundColor: kIconColorBlue,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kIconColorOrange,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: IndexedStack(
        children: <Widget>[
          CurrentScorePage(),
          SavedScoresPage(),
        ],
        index: _selectedIndex,
      ),
    );
  }
}
