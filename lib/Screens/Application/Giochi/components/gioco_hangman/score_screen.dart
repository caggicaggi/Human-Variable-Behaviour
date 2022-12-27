// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/body.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/hangman_screen.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/utils/quiz.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/components/utils.dart';
import 'package:human_variable_behaviour/Screens/HomePage/homepage_screen.dart';

import '../../../../../mysql/mysql.dart';

String significatoParola = "";

class ScorePageHangMan extends StatefulWidget {
  ScorePageHangMan();
  @override
  _ScorePageHangManState createState() => _ScorePageHangManState();
}

class _ScorePageHangManState extends State<ScorePageHangMan> {
  @override
  Widget build(BuildContext context) {
    //addTry('Tentativi_Riusciti_Impiccato');
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
                child: Container(
                  height: 100.0,
                  width: 100.0,
                  child: FittedBox(
                    child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      // ignore: sort_child_properties_last
                      child: Text(
                        "Scopri di più!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.pink,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: _showAddDialog,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _showAddDialog() async {
    await _getTitle(word);
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            "Ecco il singificato della parola che hai indovinato: ",
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
                FlatButton(
                  child: Text(
                    textAlign: TextAlign.center,
                    "Torna alla home page",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 212, 8, 174),
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePageScreen()));
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
