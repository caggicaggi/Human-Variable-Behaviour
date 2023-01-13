// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/body.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/hangman_screen.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/utils/quiz.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/components/utils.dart';
import 'package:human_variable_behaviour/Screens/HomePage/homepage_screen.dart';
import 'package:human_variable_behaviour/constant.dart';

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
        body: Container(
      //Immagine di sfondo
      decoration: getBackroundImageHomePage(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 150,
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Center(
                    child: Text('COMPLIMENTI!\n Hai indovinato la parola',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 32,
                            fontStyle: FontStyle.normal)),
                  ),
                ),
              ),
            ),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontStyle: FontStyle.normal),
            ),
            onPressed: () {
              _showAddDialog();
            },
            child: Text('Scopri di più'),
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
            onPressed: () {
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
                  MaterialPageRoute(builder: (context) => HomePageScreen()));
            },
            child: Text('Home Page'),
          ),
        ],
      ),
    ));
  }

  _showAddDialog() async {
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
