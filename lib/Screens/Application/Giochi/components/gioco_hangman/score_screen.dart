// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/hangman_screen.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/utils/game.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/utils/quiz.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/giochi_screen.dart';
import 'package:human_variable_behaviour/Screens/HomePage/homepage_screen.dart';

class ScorePageHangMan extends StatefulWidget {
  ScorePageHangMan();
  @override
  _ScorePageHangManState createState() => _ScorePageHangManState();
}

class _ScorePageHangManState extends State<ScorePageHangMan> {
  @override
  Widget build(BuildContext context) {
    addTry('Tentativi_Riusciti_Impiccato');
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          //si imposta l'immagine di sfondo
          Image.asset(
            "assets/images/sfondo_games.png",
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              //si inserisce la spaziatura
              Spacer(flex: 3),
              //si stampa testo tentativo andato bene
              Text(
                "COMPLIMENTI HAI INDOVINATO LA PAROLA!",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.amber),
              ),
              //si inserisce la spaziatura
              Spacer(flex: 3),
              //si inserisce immagine
              Image.asset(
                "assets/images/logoUnicam.jpg",
                height: 200,
                width: 400,
                fit: BoxFit.cover,
              ),
              //si inserisce la spaziatura
              Spacer(flex: 3),
              // si crea pulsante per tornare alla home
              TextButton(
                onPressed: (() {
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
