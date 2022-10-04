import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/ui/answer_button.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/utils/quiz.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/giochi_screen.dart';
import 'package:human_variable_behaviour/Screens/HomePage/homepage_screen.dart';

class ScorePage extends StatefulWidget {
  // si dichiarano le variabili
  final int score;
  final int totalQuestion;

  // si crea l'oggetto
  ScorePage(this.score, this.totalQuestion);

  // si crea lo state
  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  @override
  Widget build(BuildContext context) {
    addTry('Tentativi_Riusciti_Immagini');
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          //si imposta l'immagine di sfondo
          Image.asset(
            "assets/images/sfondo_games.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              //si inserisce spaziatura
              Spacer(flex: 3),
              Text(
                "Score",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.amber),
              ),
              //si inserisce spaziatura
              Spacer(),
              //si stampa il punteggio ottenuto
              Text(
                "${widget.score.toString()}/${widget.totalQuestion.toString()}",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: Colors.amber),
              ),
              //si inserisce spaziatura
              Spacer(flex: 3),
              //si crea il pulsate per tornare indietro
              TextButton(
                onPressed: (() {
                  //si resetta lo state
                  setState(() {});
                  //si resetta le variabili
                  b1 = false;
                  setOfInts1.clear();
                  checknumberQuestions = 0;
                  //si va alla HomePage
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
