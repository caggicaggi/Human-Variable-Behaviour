import 'package:flutter/material.dart';

import 'package:human_variable_behaviour/Screens/Application/Giochi/components/quiz_game/data/quizQuestions_list.dart';
import 'package:human_variable_behaviour/Screens/HomePage/homepage_screen.dart';
import 'package:human_variable_behaviour/constant.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';

class QuizScoreScreen extends StatefulWidget {
  final int score;
  const QuizScoreScreen(this.score, {super.key});

  @override
  State<QuizScoreScreen> createState() => _QuizScoreScreenState();
}

class _QuizScoreScreenState extends State<QuizScoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getBackroundImageHomePage(),
      child: Column(
        //Allineo tutto al centro
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 150,
            width: 400,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Center(
                  child: Text(
                      'Score: ${widget.score} / ${quizQuestions.length}',
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 32,
                          fontStyle: FontStyle.normal)),
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          //Pulsante per tornare alla home page
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontStyle: FontStyle.normal),
            ),
            onPressed: () async {
              //Aggiorno i tentati riusciti
              if (widget.score > 20) {
                await addTryCorrect("Tentativi_Riusciti_Quiz");
              }
              debugPrint("Variabile: $variabile");
              debugPrint("Modifica da apportare: ${scoreToAdd(widget.score)}");
              await updateVariable(idUtente, scoreToAdd(widget.score));
              await readInformationWithId(idUtente);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomePageScreen()));
              debugPrint("Variabile aggiornata : $variabile");
            },
            child: Text('Home Page'),
          ),
        ],
      ),
    );
  }
}

int scoreToAdd(int score) {
  int i = 0;
  if (score == 0) {
    i = -5;
  }
  if (score == 1) {
    i = -3;
  }
  if (score == 2) {
    i = 1;
  }
  if (score == 3) {
    i = 3;
  }
  if (score == 4) {
    i = 5;
  }
  return i;
}
