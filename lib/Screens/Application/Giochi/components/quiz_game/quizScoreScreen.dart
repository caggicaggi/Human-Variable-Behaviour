import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/body.dart';
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
                  child: Text('Score: ${widget.score} / ${quizQuestions.length * 10}',
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
              addTry("Tentativi_Totali_Quiz");
              //Aggiorno i tentati riusciti
              if (widget.score > 20) {
                await addTryCorrect("Tentativi_Riusciti_Quiz");
              }
              await readInformationWithId(idUtente).then((value) {
                
              });

              Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePageScreen()));
            },
            child: Text('Home Page'),
          ),
        ],
      ),
    );
  }
}
