import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/hangman_screen.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/components/utils.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/utils/quiz.dart.dart';
import 'package:human_variable_behaviour/Screens/HomePage/homepage_screen.dart';
import 'package:human_variable_behaviour/constant.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';

class ScorePageHangManBadQuestion extends StatefulWidget {
  ScorePageHangManBadQuestion();
  @override
  _ScorePageHangManState createState() => _ScorePageHangManState();
}

class _ScorePageHangManState extends State<ScorePageHangManBadQuestion> {
  @override
  Widget build(BuildContext context) {
    //addTry('Tentativi_Riusciti_Impiccato');
    return Scaffold(
      body: Container(
          //Immagine di sfondo
          decoration: getBackroundImageHomePage(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: SizedBox(
                  height: 150,
                  width: 400,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Card(
                      child: Center(
                        child: Text(
                            'Questa volta non ci sei riuscito!\nRiprovaci!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 32,
                                fontStyle: FontStyle.normal)),
                      ),
                    ),
                  ),
                ),
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
                  await addTry('Tentativi_Totali_Impiccato');
                  await readInformationWithId(idUtente);
                  //si resetta lo state
                  setState(() {});
                  //si inizializzano le variabili e le liste
                  checkQuestion = false;
                  Game.tries = 0;
                  Game.selectedChar.clear();
                  setCorrectQuestions.clear();
                  CorrectQuestions = false;
                  b1 = false;
                  setOfInts1.clear();
                  checknumberQuestions = 0;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HangMan()));
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
                  await readInformationWithId(idUtente);
                  //si resetta lo state
                  setState(() {});
                  //si inizializzano le variabili e le liste
                  checkQuestion = false;
                  Game.tries = 0;
                  Game.selectedChar.clear();
                  setCorrectQuestions.clear();
                  CorrectQuestions = false;
                  b1 = false;
                  setOfInts1.clear();
                  checknumberQuestions = 0;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePageScreen()));
                },
                child: Text('Home Page'),
              ),
            ],
          )),
    );
  }
}
