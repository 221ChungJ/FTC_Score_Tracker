import 'package:flutter/material.dart';
import 'package:ftc_score_tracker/constants.dart';
import 'package:provider/provider.dart';
import 'package:ftc_score_tracker/score_data.dart';

class SavedScoresPage extends StatefulWidget {

  @override
  State<SavedScoresPage> createState() => _SavedScoresPageState();
}

class _SavedScoresPageState extends State<SavedScoresPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScoreData>(builder: (context, scoreData, child) {
      print(scoreData.getNumScores());
      return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemCount: scoreData.getNumScores(),
        itemBuilder: (BuildContext context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              border: Border.all(
              color: Colors.grey,
              ),
            ),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onLongPress: (){
                    setState(() {
                      scoreData.removeScore(index);
                    });
                  },
                  child: Padding(padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12), child: Text(scoreData.getSavedScores(index)[0], style: kTileTitleStyle)),
                ),

                Column(
                  children: [
                    Padding(padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12), child: Text('Total Score ' + scoreData.getSavedScores(index)[1], style: kToggleSavedScoreTextStyle)),
                    Padding(padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12), child: Text('Auto Score ' + scoreData.getSavedScores(index)[2], style: kToggleSavedScoreTextStyle)),
                    Padding(padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12), child: Text('Teleop Score ' + scoreData.getSavedScores(index)[3], style: kToggleSavedScoreTextStyle)),
                    Padding(padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12), child: Text('Endgame Score ' + scoreData.getSavedScores(index)[4], style: kToggleSavedScoreTextStyle)),

                  ],
                ),
              ],
            ),
          );
        },
      );
    });
  }
}





