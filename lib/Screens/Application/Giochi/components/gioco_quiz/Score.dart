import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_quiz/options_games.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_quiz/questions_controller.dart';
import 'package:human_variable_behaviour/Screens/HomePage/homepage_screen.dart';

import '../../giochi_screen.dart';

class ScoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    addTry('Tentativi_Riusciti_Quiz');
    //inizializzo controller
    QuestionController _qnController = Get.put(QuestionController());
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          //imposto immagine di sfondo
          Image.asset(
            "assets/images/sfondo_games.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              Spacer(flex: 3),
              //stampo titolo pagina
              Text(
                "Score",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.amber),
              ),
              Spacer(),
              //calcolo del punteggio ottenuto moltiplicato per 10
              Text(
                "${_qnController.numOfCorrectAns * 10}/${_qnController.questions.length * 10}",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: Colors.amber),
              ),
              //inserisco distanza
              Spacer(flex: 3),
              //creo pulsante per tornare alla home
              TextButton(
                onPressed: (() {
                  //resetto variabile per lista domande
                  b = false;
                  //resetto variabili
                  _qnController.resetScoreNumber();
                  _qnController.resetQuestionNumber();
                  //cancello instanza controller
                  Get.delete<QuestionController>();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePageScreen()));
                }),
                child: Text(
                  'TORNA ALLA HOME PAGE',
                  style: TextStyle(
                    backgroundColor: Colors.amber,
                    fontSize: 20,
                    foreground: Paint()
                      ..strokeWidth = 2
                      ..color = Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
