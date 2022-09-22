import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/score_screen.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/scorebadquestions_screen.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/ui/figure_image.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/ui/letter.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/utils/game.dart';
import 'package:human_variable_behaviour/Screens/HomePage/homepage_screen.dart';

//si inizializzano le variabili che si andranno a usare
bool CorrectQuestions = false;
int x = 0;
Set<String> setCorrectQuestions = Set();
String word = "";
bool checkQuestion = false;

class HangMan extends StatefulWidget {
  //si crea il costruttore
  const HangMan({Key? key}) : super(key: key);

//si crea lo state
  @override
  _HangManAppState createState() => _HangManAppState();
}

class _HangManAppState extends State<HangMan> {
  //si crea una lista che contiene l'alfabeto
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
    //si occupa tutto lo schermo in altezza e larghezza
    Size size = MediaQuery.of(context).size;
    if (checkQuestion == false) {
      word = selectStringQuestions(word).toUpperCase();
      checkQuestion = true;
    }
    return Stack(
      children: <Widget>[
        //si imposta l'immagine di sfondo
        Image.asset(
          "assets/images/sfondo_games.png",
          height: size.height,
          width: size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Ora prova a indovinare"),
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.blue,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Stack(
                  children: <Widget>[
                    //a seconda dei tentativi si aggiunge un'immagine
                    figureImage(
                        context, Game.tries >= 0, "assets/images/hang.png"),
                    figureImage(
                        context, Game.tries >= 1, "assets/images/head.png"),
                    figureImage(
                        context, Game.tries >= 2, "assets/images/body.png"),
                    figureImage(
                        context, Game.tries >= 3, "assets/images/ra.png"),
                    figureImage(
                        context, Game.tries >= 4, "assets/images/la.png"),
                    figureImage(
                        context, Game.tries >= 5, "assets/images/rl.png"),
                    figureImage(
                        context, Game.tries >= 6, "assets/images/ll.png"),
                  ],
                ),
              ),
              //Ora si creerà il widget Parola nascosta
              //poi si torna alla classe Game e si aggiunge
              // una nuova variabile per memorizzare il carattere selezionato
              /* e si controlla se è sulla parola */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: word
                    .split('')
                    .map((e) => letter(context, e.toUpperCase(),
                        !Game.selectedChar.contains(e.toUpperCase())))
                    .toList(),
              ),
              //si crea la tastiera per il gioco
              SizedBox(
                width: size.width * 1,
                height: size.height * 0.4,
                child: GridView.count(
                  crossAxisCount: 8,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 1.0,
                  padding: EdgeInsets.all(size.height * 0.01),
                  //stampa tutte le lettere
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
              )
            ],
          ),
        )
      ],
    );
  }

//metodo per passare la parola da indovinare
  String selectStringQuestions(String word) {
    //inizializzo lista parole da indovinare
    List<String> listofStringQuestions = [];
    //si aggiungono parole alla lista
    listofStringQuestions.add("Bullismo");
    listofStringQuestions.add("Unicam");
    listofStringQuestions.add("Scuola");
    listofStringQuestions.add("Studiare");
    listofStringQuestions.add("Universita");

    //si genera un indice casuale
    var index = Random().nextInt(listofStringQuestions.length - 1) + (0);

    return listofStringQuestions[index];
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
