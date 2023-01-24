// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/pages/quiz_page.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/utils/quiz.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/quiz_game/quizScoreScreen.dart';
import 'package:human_variable_behaviour/Screens/HomePage/homepage_screen.dart';
import 'package:human_variable_behaviour/constant.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        //Immagine di sfondo
        decoration: getBackroundImageHomePage(),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Center(
                        child: Text(
                            'Score: ${widget.score.toString()}/${max.toString()}',
                            style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 32,
                                fontStyle: FontStyle.normal)),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                //Pulsante Riprova
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontStyle: FontStyle.normal),
                  ),
                  onPressed: () async {
                    await addTry("Tentativi_Totali_Immagini");
                    if (widget.score > 2) {
                      await addTryCorrect("Tentativi_Riusciti_Immagini");
                    }
                    debugPrint("Variabile: $variabile");
                    debugPrint(
                        "Modifica da apportare: ${scoreToAdd(widget.score)}");
                    await updateVariable(idUtente, scoreToAdd(widget.score));
                    await readInformationWithId(idUtente);
                    //si resetta lo state
                    setState(() {});
                    //si resetta le variabili
                    b1 = false;
                    setOfInts1.clear();
                    checknumberQuestions = 0;
                    debugPrint("Variabile aggiornata : $variabile");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => QuizPagina()));
                  },
                  child: Text('Riprova'),
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
                    if (widget.score > 2) {
                      await addTryCorrect("Tentativi_Riusciti_Immagini");
                    }
                    debugPrint("Variabile: $variabile");
                    debugPrint(
                        "Modifica da apportare: ${scoreToAdd(widget.score)}");
                    await updateVariable(idUtente, scoreToAdd(widget.score));
                    await readInformationWithId(idUtente);
                    //si resetta lo state
                    setState(() {});
                    //si resetta le variabili
                    b1 = false;
                    setOfInts1.clear();
                    checknumberQuestions = 0;
                    debugPrint("Variabile aggiornata : $variabile");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePageScreen()));
                  },
                  child: Text('Home Page'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
