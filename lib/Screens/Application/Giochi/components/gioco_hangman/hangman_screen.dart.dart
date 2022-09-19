import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/score_screen.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/scorebadquestions_screen.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/ui/figure_image.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/ui/letter.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/utils/game.dart';
import 'package:human_variable_behaviour/Screens/HomePage/homepage_screen.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';

bool CorrectQuestions = false;
int x = 0;
Set<String> setCorrectQuestions = Set();
String word = "";
bool checkQuestion = false;

class HangMan extends StatefulWidget {
  const HangMan({Key? key}) : super(key: key);

  @override
  _HangManAppState createState() => _HangManAppState();
}

class _HangManAppState extends State<HangMan> {
  //Creo una lista che contiene l'alfabeto
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
    Size size = MediaQuery.of(context).size;
    if (checkQuestion == false) {
      word = selectStringQuestions(word).toUpperCase();
      checkQuestion = true;
    }
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/sfondo_games.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
                    //a seconda dei tentativi aggiungo un pezzo di immagini
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
              //Now we will build the Hidden word widget
              //now let's go back to the Game class and add
              // a new variable to store the selected character
              /* and check if it's on the word */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: word
                    .split('')
                    .map((e) => letter(context, e.toUpperCase(),
                        !Game.selectedChar.contains(e.toUpperCase())))
                    .toList(),
              ),
              //Now let's build the Game keyboard
              SizedBox(
                width: size.width * 1,
                height: size.height * 0.4,
                child: GridView.count(
                  crossAxisCount: 8,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 1.0,
                  padding: EdgeInsets.all(size.height * 0.01),
                  children: alphabets.map((e) {
                    return RawMaterialButton(
                      onPressed: Game.selectedChar.contains(e)
                          ? null // we first check that we didn't selected the button before
                          : () {
                              setState(() {
                                Game.selectedChar.add(e);
                                print(e);
                                print("@@@@@@@@@@@@@@@@@@@@@@");
                                if (!word.split('').contains(e.toUpperCase())) {
                                  Game.tries++;

                                  if (checkCorrectQuestions() == true) {
                                    Get.to(HomePageScreen());
                                  }
                                }

                                if (checkCorrectQuestions() == true) {
                                  Get.to(ScorePageHangMan());
                                }

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

  String selectStringQuestions(String word) {
    List<String> listofStringQuestions = [];
    //lista parole da indovinare senza doppie
    listofStringQuestions.add("Marrco");
    listofStringQuestions.add("Matteo");

    var index = Random().nextInt(listofStringQuestions.length - 1) + (0);
    ;
    return listofStringQuestions[index];
  }

  String wordToCheck = '';

// il metodo non verifica in tal caso ci siano lettere doppi attaccate
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

      debugPrint(removeDups(word));
      debugPrint(removeDups(wordToCheck));

      if (removeDups(wordToCheck) == removeDups(word)) {
        CorrectQuestions = true;
      } else {
        debugPrint("--------------" + setCorrectQuestions.toString());
      }
    }

    return CorrectQuestions;
  }
}

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