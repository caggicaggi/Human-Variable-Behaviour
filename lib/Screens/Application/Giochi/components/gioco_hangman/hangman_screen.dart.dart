// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, unnecessary_new, unused_local_variable, prefer_interpolation_to_compose_strings, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/choice_screen/game_screen.dart';
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomePageScreen()));
                              }
                            }
                            //tentativi esauriti
                            if (checkCorrectQuestions() == true) {
                              showAddDialog();
                              addTryCorrect("Tentativi_Riusciti_Impiccato");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ScorePageHangMan()));
                            }
                            //tentativi esauriti
                            if (Game.tries == 6) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ScorePageHangManBadQuestion()));
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

  showAddDialog() async {
    await _getTitle(word);
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            "Cosa significa " + word + ' ?',
            textAlign: TextAlign.center,
            style: GoogleFonts.aBeeZee(),
          ),
          content: SizedBox(
            height: 160,
            width: 400,
            child: Text(
              significatoParola,
              style: GoogleFonts.aBeeZee(),
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  child: Text(
                    textAlign: TextAlign.center,
                    "Chiudi",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScorePageHangMan()));
                  },
                ),
              ],
            )
          ]),
    );
  }

  Future<void> _getTitle(String parola) async {
    //Nome della tabella
    String table = 'listaparole';
    parola = stringToDb(parola);
    //Scrivo la query
    String query =
        'SELECT significatoParola FROM ' + table + ' WHERE parola = ' + parola;
    //Connessione al database
    var db = Mysql();
    await db.getConnection().then((connessione) async {
      await Future.delayed(const Duration(milliseconds: 10));
      await connessione.query(query).then((result) async {
        for (var res in result) {
          significatoParola = res[0];
        }
        connessione.close();
      });
    });
    return;
  }
}
