import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ftc_score_tracker/constants.dart';
import '../screens/scoring_screen.dart';


class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset('images/FREIGHTFRENZY_LOGO.png', width: 400),
              height: 150.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Image.asset('images/FIRST_Tech_challenge_logo.png'),
                  height: 150.0,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      '15118',
                      style: kTeamTextStyle,
                    ),
                    Text(
                      'Score',
                      style: kTeamTextStyle,
                    ),
                    Text(
                      'Tracker',
                      style: kTeamTextStyle,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 100.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: kButtonColorOrange,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ScoringScreen.id);
                  },
                  minWidth: 370.0,
                  height: 20.0,
                  child: const Text(
                    'Start',
                    style: kButtonTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
