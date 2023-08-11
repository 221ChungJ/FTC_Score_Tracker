import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ScoreData extends ChangeNotifier {
  late int numScores;
  late List<List<String>> savedScores;

  ScoreData(){
    _loadScores();
    print('complete initialization');
  }

  _loadScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    numScores = (prefs.getInt('numScores') ?? 0);
    savedScores = [];
    for(int i = 1; i < numScores+1; i++){
      savedScores.add((prefs.getStringList('$i') ?? []));
    }
  }

  Map<String, int> scores = {
  //auto
  'autoDuck' : 0,
  'autoParkRobot1' : 0,
  'autoParkRobot2' : 0,
  'autoParkCompletionRobot1' : 0,
  'autoParkCompletionRobot2' : 0,
  'autoFreightStorage' : 0,
  'autoFreightHub' : 0,
  'autoDetectionRobot1' : 0,
  'autoDetectionRobot2' : 0,
    'autoFreightStorage' : 0,
    'autoFreightHub1' : 0,
    'autoFreightHub2' : 0,
    'autoFreightHub3' : 0,

  //teleop
  'teleopFreightStorage' : 0,
  'teleopFreightHub1' : 0,
  'teleopFreightHub2' : 0,
  'teleopFreightHub3' : 0,
  'teleopFreightShared' : 0,

  //endgame
  'endgameDuck' : 0,
  'endgameHubBalanced' : 0,
  'endgameSharedBalanced' : 0,
  'endgameParkWarehouseRobot1' : 0,
  'endgameParkWarehouseRobot2' : 0,
  'endgameCap' : 0,
  };

  List<String> getSavedScores(int num){
    return savedScores[num];
  }

  int getScore(String s){
    return scores[s]!;
  }

  int getLength(){
    return scores.length;
  }

  void addScore(String s, int n){
    scores[s] = scores[s]! + n;
    notifyListeners();
  }

  void subtractScore(String s, int n){
    if(scores[s]! > 0) {
      scores[s] = scores[s]! - n;
      notifyListeners();
    }
  }

  int getTotalScore(){
    int num = 0;
    for(int i in scores.values){
      num += i;
    }
    return num;
  }

  void resetScores(){
    for(var v in scores.keys){
      scores[v] = 0;
    }
    notifyListeners();
  }

  int getAutoScore(){
    int num = 0;
    num += scores['autoDuck']!;
    num += scores['autoParkRobot1']!;
    num += scores['autoParkRobot2']!;
    num += scores['autoParkCompletionRobot1']!;
    num += scores['autoParkCompletionRobot2']!;
    num += scores['autoFreightStorage']!;
    num += scores['autoFreightHub']!;
    num += scores['autoDetectionRobot1']!;
    num += scores['autoDetectionRobot2']!;
    num += scores['autoFreightHub1']!;
    num += scores['autoFreightHub2']!;
    num += scores['autoFreightHub3']!;
    return num;
  }

  int getTeleopScore(){
    int num = 0;
    num += scores['teleopFreightStorage']!;
    num += scores['teleopFreightHub1']!;
    num += scores['teleopFreightHub2']!;
    num += scores['teleopFreightHub3']!;
    num += scores['teleopFreightShared']!;
    return num;
  }

  int getEndgameScore(){
    int num = 0;
    num += scores['endgameDuck']!;
    num += scores['endgameHubBalanced']!;
    num += scores['endgameSharedBalanced']!;
    num += scores['endgameParkWarehouseRobot1']!;
    num += scores['endgameParkWarehouseRobot2']!;
    num += scores['endgameCap']!;
    return num;
  }

  int? getNumScores(){
    return numScores;
  }

  void saveScoresLocally(String scoreTitle) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    numScores = numScores + 1;
    await prefs.setInt('numScores', numScores);

    int totalScore = getTotalScore();
    int autoScore = getAutoScore();
    int teleopScore = getTeleopScore();
    int endgameScore = getEndgameScore();
    List<String> scoresList = [scoreTitle, '$totalScore', '$autoScore', '$teleopScore', '$endgameScore'];
    savedScores.add(scoresList);
    print(numScores);
    await prefs.setStringList('$numScores', scoresList);
    notifyListeners();
  }

  void removeScore(int key) async{
    print(key);
    print('here');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedScores.removeAt(key);
    await prefs.remove('$key');
    numScores = numScores - 1;
    await prefs.setInt('numScores', numScores);

  }
}