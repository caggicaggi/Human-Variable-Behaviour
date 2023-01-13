// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, unnecessary_new, unused_local_variable, prefer_interpolation_to_compose_strings, sort_child_properties_last, prefer_const_constructors

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/body.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/score_screen.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/scorebadquestions_screen.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/ui/figure_image.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/components/utils.dart';
import 'package:human_variable_behaviour/Screens/HomePage/homepage_screen.dart';
import 'package:human_variable_behaviour/constant.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';

//Variabile per verificare se la parola è stata indovinata
bool CorrectQuestions = false;
//Array per il salvataggio di tutte le parole del database
List<String> listofStringQuestions = [];
//Indice per passare alle variabili successive
int nextParola = 0;
int x = 0;
Set<String> setCorrectQuestions = Set();

bool checkQuestion = false;

class HangMan extends StatefulWidget {
  const HangMan({Key? key}) : super(key: key);

  @override
  _HangManAppState createState() => _HangManAppState();
}

class _HangManAppState extends State<HangMan> {
  //Lista contentente l'afabeto 
  
  List<String> alphabets = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];

  @override
  Widget build(BuildContext context) {
    //Occupo tutto lo schermo sia in altezza che in lunghezza
    Size size = MediaQuery.of(context).size;
    
    return Scaffold(
        body: Container(
      //Immagine di sfondo
      decoration: getBackroundImageHomePage(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Spaziatura
          SizedBox(
            height: size.height * 0.02,
          ),
          Center(
            child: Stack(
              children: <Widget>[
                //Aggiungo una parte del corpo a seconda delle lettere indovinate
                figureImage(context, Game.tries >= 0, "assets/images/hang.png"),
                figureImage(context, Game.tries >= 1, "assets/images/head.png"),
                figureImage(context, Game.tries >= 2, "assets/images/body.png"),
                figureImage(context, Game.tries >= 3, "assets/images/ra.png"),
                figureImage(context, Game.tries >= 4, "assets/images/la.png"),
                figureImage(context, Game.tries >= 5, "assets/images/rl.png"),
                figureImage(context, Game.tries >= 6, "assets/images/ll.png"),
              ],
            ),
          ),

          //Creo il widget letter e prendo con il selectedChar controllo se presente
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: word
                .split('')
                .map((e) => letter(context, e.toUpperCase(),
                    !Game.selectedChar.contains(e.toUpperCase())))
                .toList(),
          ),

          //Tastiera
          SizedBox(
            width: size.width * 1,
            height: size.height * 0.4,
            child: GridView.count(
              crossAxisCount: 8,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 1.0,
              padding: EdgeInsets.all(size.height * 0.01),
              //Lettere
              children: alphabets.map((e) {
                return RawMaterialButton(
                  onPressed: Game.selectedChar.contains(e)
                      ? null //per prima cosa si controlla di non aver selezionato il pulsante prima
                      : () {
                          setState(() {
                            //aggiungo lettera
                            Game.selectedChar.add(e);
                            //caso lettera errata
                            if (!word.split('').contains(e.toUpperCase())) {
                              Game.tries++;
                              //tentativi esauriti
                              if (checkCorrectQuestions() == true) {
                                Get.to(HomePageScreen());
                              }
                            }
                            //tentativi esauriti
                            if (checkCorrectQuestions() == true) {
                              Get.to(ScorePageHangMan());
                            }
                            //tentativi esauriti
                            if (Game.tries == 6) {
                              Get.to(ScorePageHangManBadQuestion());
                            }
                          });
                        },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    e,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  fillColor: Game.selectedChar.contains(e)
                      ? Colors.blueGrey
                      : Colors.blue,
                );
              }).toList(),
            ),
          ), //Spaziatura
          SizedBox(
            height: size.height * 0.02,
          ),
        ],
      ),
    ));
  }

  String wordToCheck = '';

// metodo per il controllo della parola corretta che include il metodo per
// cancellare le lettere doppie
  bool checkCorrectQuestions() {
    var arrayOfWord = word.split('');
    var correctAnswer = [];
    

    for (var e in Game.selectedChar) {
      if ((!word.split('').contains(e)) == false) correctAnswer.add(e);
    }

    if (correctAnswer.toString() == arrayOfWord.toString()) {
      CorrectQuestions = true;
    }

    for (var e in correctAnswer) {
      for (int j = 0; j < word.length; j++) {
        if (word[j] == e) {
          setCorrectQuestions.add(word[j]);
          wordToCheck += e;
        }
      }

      if (removeDups(wordToCheck).length == removeDups(word).length) {
        CorrectQuestions = true;
      }
    }

    return CorrectQuestions;
  }
}

//metodo che toglie le lettere doppie
String removeDups(String s) {
  var arr = new List.filled(256, 0);
  String l = '';
  int i = 0;
  for (i = 0; i < s.length; i++) {
    if (arr[s.codeUnitAt(i)] == 0) {
      l += s[i];
      arr[s.codeUnitAt(i)]++;
    }
  }
  return l;
}
