import 'package:flutter/material.dart';
import 'package:ftc_score_tracker/constants.dart';
import 'package:provider/provider.dart';
import 'package:ftc_score_tracker/score_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentScorePage extends StatefulWidget {
  @override
  _CurrentScorePageState createState() => _CurrentScorePageState();
}

class _CurrentScorePageState extends State<CurrentScorePage> {
  late int numScores;
  late TextEditingController controller;

  Padding makeToggleButton(
      ScoreData scoreData, String scoreTitle,List<String> s, List<int> increment, String key) {
    List<Widget> w = List.generate(
        s.length,
        (int index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            child: Text(s[index], style: kToggleButtonTextStyle)));
    List<bool> tempList = List.generate(w.length, (_) => false);
    if (scoreData.getScore(key) == 0) {
      tempList[0] = true;
    } else if (scoreData.getScore(key) == increment[1]) {
      tempList[1] = true;
    } else if (scoreData.getScore(key) == increment[2]) {
      tempList[2] = true;
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            scoreTitle,
            style: kTileTitleStyle,
          ),
          Container(
            height: 38,
            decoration: BoxDecoration(color: Colors.grey[300]!, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey[300]!, width: 2.5)),
            child: ToggleButtons(
              children: w,
              borderRadius: BorderRadius.circular(15),
              constraints: BoxConstraints(minWidth: 48.0, minHeight: 38.0),
              renderBorder: false,
              isSelected: tempList,
              onPressed: (int index) {
                setState(() {
                  for (int buttonIndex = 0;
                      buttonIndex < tempList.length;
                      buttonIndex++) {
                    if (tempList[buttonIndex] == true) {

                      scoreData.subtractScore(key, increment[buttonIndex]);
                    }
                    if (buttonIndex == index) {
                      scoreData.addScore(key, increment[buttonIndex]);
                    }
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding makeCounterButton(
      ScoreData scoreData, String scoreTitle, String key, int increment) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            scoreTitle,
            style: kTileTitleStyle,
          ),
          Row(
            children: <Widget>[
              Text(
                (scoreData.getScore(key) / increment).round().toString(),
                style: kTileTitleStyle,
              ),
              const SizedBox(
                width: 10
              ),
              Container(
                decoration: BoxDecoration(color: Colors.grey[300]!, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey[300]!, width: 2.5)),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                      constraints: BoxConstraints(),
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          scoreData.subtractScore(key, increment);
                        });
                      },
                    ),
                    IconButton(
                      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                      constraints: BoxConstraints(),
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          scoreData.addScore(key, increment);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    controller = TextEditingController();
    _loadNumScores();
  }

  _loadNumScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      numScores = (prefs.getInt('numScores') ?? 0);
    });
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScoreData>(builder: (context, scoreData, child) {
      return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 15.0, left: 10.0),
                    child: Center(
                        child: Text(
                          'Total Score: ' + scoreData.getTotalScore().toString(),
                          style: kTotalScoreTitleStyle,
                        )),
                  ),
                  IconButton(
                    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                    constraints: BoxConstraints(),
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        scoreData.resetScores();
                      });
                    },
                  ),
                ],
            ),
        Flexible(
          child: ListView(
            children: <Widget>[

              //Auto
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Center(
                    child: Text(
                  'Autonomous: ' + scoreData.getAutoScore().toString(),
                  style: kSectionStyle,
                )),
              ),
              makeToggleButton(
                  scoreData, 'Duck Delivery', ['Not Delivered', 'Delivered'], [0, 10], 'autoDuck'),
              makeToggleButton(scoreData,'Parked Location 1', ['None', 'Storage', 'Warehouse'],
                  [0, 3, 5], 'autoParkRobot1'),
              makeToggleButton(
                  scoreData, 'Park Completion 1', ['Partial', 'Full'], [0, scoreData.getScore('autoParkRobot1')], 'autoParkCompletionRobot1'),
              makeToggleButton(scoreData,'Parked Location 2', ['None', 'Storage', 'Warehouse'],
                  [0, 3, 5], 'autoParkRobot2'),
              makeToggleButton(
                  scoreData, 'Park Completion 2', ['Partial', 'Full'], [0, scoreData.getScore('autoParkRobot2')], 'autoParkCompletionRobot2'),
              makeCounterButton(
                  scoreData, 'Level 1 Freight', 'autoFreightHub1', 2),
              makeCounterButton(
                  scoreData, 'Level 2 Freight', 'autoFreightHub2', 4),
              makeCounterButton(
                  scoreData, 'Level 3 Freight', 'autoFreightHub3', 6),
              makeCounterButton(
                  scoreData, 'Storage Freight', 'autoFreightStorage', 1),
              makeToggleButton(scoreData,'Auto Bonus 1', ['None', 'Duck', 'Team'],
                  [0, 10, 20], 'autoDetectionRobot1'),
              makeToggleButton(scoreData,'Auto Bonus 2', ['None', 'Duck', 'Team'],
                  [0, 10, 20], 'autoDetectionRobot2'),

              //Teleop
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Center(
                    child: Text(
                      'Teleop: ' + scoreData.getTeleopScore().toString(),
                      style: kSectionStyle,
                    )),
              ),
              makeCounterButton(
                  scoreData, 'Level 1 Freight', 'teleopFreightHub1', 2),
              makeCounterButton(
                  scoreData, 'Level 2 Freight', 'teleopFreightHub2', 4),
              makeCounterButton(
                  scoreData, 'Level 3 Freight', 'teleopFreightHub3', 6),
              makeCounterButton(
                  scoreData, 'Shared Hub Freight', 'teleopFreightShared', 4),
              makeCounterButton(
                  scoreData, 'Storage Freight', 'teleopFreightStorage', 1),

              //End Game
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Center(
                    child: Text(
                      'End Game: ' + scoreData.getEndgameScore().toString(),
                      style: kSectionStyle,
                    )),
              ),
              makeCounterButton(
                  scoreData, 'Ducks Delivered', 'endgameDuck', 6),
              makeToggleButton(
                  scoreData, 'Alliance Hub Balanced', ['Unbalanced', 'Balanced'], [0, 10], 'endgameHubBalanced'),
              makeToggleButton(
                  scoreData, 'Shared Hub Tipped', ['Untipped', 'Tipped'], [0, 20], 'endgameSharedBalanced'),
              makeToggleButton(scoreData,'Parked Completion 1', ['None', 'Partial', 'Full'],
                  [0, 3, 6], 'endgameParkWarehouseRobot1'),
              makeToggleButton(scoreData,'Parked Completion 2', ['None', 'Partial', 'Full'],
                  [0, 3, 6], 'endgameParkWarehouseRobot2'),
              makeToggleButton(scoreData,'Capped Hub', ['None', 'One', 'Two'],
                  [0, 15, 30], 'endgameCap'),

              //save score button
              OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey[300]),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
                onPressed: () async{
                  final scoreTitle = await openDialog();
                  if (scoreTitle == null || scoreTitle.isEmpty){return;}
                  else{
                    scoreData.saveScoresLocally(scoreTitle);
                  }
                },
                child: const Text('Save Score', style: kTileTitleStyle),
              ),
            ],
          ),
        ),
      ],
      );
    });
  }
  Future<String?> openDialog() => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Score Title'),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(hintText: 'Enter score title'),
          controller: controller,
          onSubmitted: (_) => submit(),
        ),
        actions: [
          TextButton(
            child: Text('SUBMIT'),
            onPressed: submit,
          ),
        ],
      ),
  );
  void submit(){
    Navigator.of(context).pop(controller.text);
    controller.clear();
  }
}
