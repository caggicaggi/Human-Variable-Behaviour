// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, use_build_context_synchronously, unnecessary_new

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/hangman_screen.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/pages/quiz_page.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_quiz/quizComponents/question.dart';
import 'package:human_variable_behaviour/components/rounded_button.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/background.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';
import 'gioco_quiz/quizComponents/questionsToDisplay.dart';

//Array per lista delle domande
List<String> listofQuestion = [];
//Array per lista delle risposte
List<String> listofAnswerQuestions = [];
//Array per lista id domande
List<int> listofIdQuestions = [];
//Array per lista risposte corrette
//List<String> listofCorrectAnswer = [];
//Array di Domanda
var questions = [];
//Parola che si dovrà indovinare
String word = '';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Occupo tutto lo schermo sia in altezza che in lunghezza
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        //Allineo tutto al centro
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(children: [
            //Widget
            Text(
              "Giocando si impara!",
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            //Spaziatura
            SizedBox(
              height: size.height * 0.02,
            ),
            //Pulsante per QUIZ
            RoundedButton(
              text: 'Inizia il quiz',
              press: () async {
                //Incremento il numero di tentativi
                await addTry('Tentativi_Totali_Quiz');
                //Cancello la lista delle domande
                listofQuestion = [];
                listofAnswerQuestions = [];
                listofIdQuestions = [];
                //listofCorrectAnswer = [];
                //Prendo le domande dal database
                await getIdDomanda();
                await getDomanda();
                await getAnswerQuestion();
                //await getCorrectAnswer();

                //Creo le domande
                questions = [
                  Question(
                    text: listofQuestion[0],
                    options: [
                      Option(text: listofAnswerQuestions[1], isCorrect: false),
                      Option(text: listofAnswerQuestions[0], isCorrect: true),
                      Option(text: listofAnswerQuestions[2], isCorrect: false),
                      Option(text: listofAnswerQuestions[3], isCorrect: false),
                    ],
                  ),
                  Question(
                    text: listofQuestion[1],
                    options: [
                      Option(text: listofAnswerQuestions[4], isCorrect: true),
                      Option(text: listofAnswerQuestions[5], isCorrect: false),
                      Option(text: listofAnswerQuestions[6], isCorrect: false),
                      Option(text: listofAnswerQuestions[7], isCorrect: false),
                    ],
                  ),
                  Question(
                    text: listofQuestion[2],
                    options: [
                      Option(text: listofAnswerQuestions[8], isCorrect: true),
                      Option(text: listofAnswerQuestions[9], isCorrect: false),
                      Option(text: listofAnswerQuestions[10], isCorrect: false),
                      Option(text: listofAnswerQuestions[11], isCorrect: false),
                    ],
                  ),
                  Question(
                    text: listofQuestion[3],
                    options: [
                      Option(text: listofAnswerQuestions[12], isCorrect: true),
                      Option(text: listofAnswerQuestions[13], isCorrect: false),
                      Option(text: listofAnswerQuestions[14], isCorrect: false),
                      Option(text: listofAnswerQuestions[15], isCorrect: false),
                    ],
                  ),
                ];

                //Passo alla schermata del quiz
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionToDisplay(),
                  ),
                );
              },
            ),
            //Spaziatura
            SizedBox(
              height: size.height * 0.02,
            ),
            //Pulsante per indovina l'immagine
            RoundedButton(
              text: 'Indovina l\'immagine',
              press: () async {
                //Incremento il numero di tentativi
                await addTry('Tentativi_Totali_Immagini');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QuizPagina()));
              },
            ),
            //Spaziatura
            SizedBox(
              height: size.height * 0.02,
            ),
            //Pulsante per gioco dell'impiccato
            RoundedButton(
              text: 'Gioco dell\'impiccato',
              press: () async {
                //Incremento il numero di tentativi
                await addTry('Tentativi_Totali_Impiccato');
                //Numero random per acquisizione parola
                Random random = new Random();
                int randomNumber =
                    random.nextInt(10); // from 0 upto 10 included
                await getParole(randomNumber);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HangMan()));
              },
            ),
            //Spaziatura
            SizedBox(
              height: size.height * 0.02,
            ),
          ])
        ],
      ),
    );
  }
}

//Aggiungo un tentativo alla tabella data in input
Future<void> addTry(colonna) async {
  String query =
      'select ' + colonna + ' from utenti where idUtente = ' + idUtente;
  String queryUpdate = '';
  //Connessione al database
  var db = Mysql();
  await db.getConnection().then((connessione) async {
    //delay obbligatorio per Malaccari
    await Future.delayed(const Duration(milliseconds: 1));
    await connessione.query(query).then((result) async {
      for (var res in result) {
        int value = int.parse(res[0].toString()) + 1;
        queryUpdate = 'UPDATE utenti SET ' +
            colonna +
            ' = ' +
            value.toString() +
            ' where idUtente = ' +
            idUtente;
      }
      connessione.close();
    });
  });
  db = Mysql();
  await db.getConnection().then((connessione) async {
    await Future.delayed(const Duration(milliseconds: 1));
    await connessione.query(queryUpdate).then((result) async {
      (value) => connessione.close();
    });
  });
  debugPrint("Aggiungo i tentativi");
}

///////////////////
//METODI PER QUIZ//
///////////////////

//Prendo le domande dal database
Future<void> getDomanda() async {
  String table = 'listaDomande';
  //Scrivo la query
  String query = 'SELECT domanda FROM ' + table;
  var db = Mysql();
  await db.getConnection().then((connessione) async {
    await connessione.query(query).then((result) {
      for (var res in result) {
        //Aggiungo all'array
        listofQuestion.add(res[0].toString());
      }
    });
  });
}

//Prendo gli id delle domande dal database
Future<void> getIdDomanda() async {
  String table = 'listaDomande';
  //Scrivo la query
  String query = 'SELECT idDom FROM ' + table;
  var db = Mysql();
  await db.getConnection().then((connessione) async {
    await connessione.query(query).then((result) {
      for (var res in result) {
        //Aggiungo all'array
        listofIdQuestions.add(int.parse(res[0].toString()));
      }
    });
  });
}

//Prendo le risposte dal database
Future<void> getAnswerQuestion() async {
  String table = 'listaDomande';
  //Scrivo la query
  String query =
      'SELECT rispostaCorretta,rispostaErrata1,rispostaErrata2,rispostaErrata3 FROM ' +
          table;
  var db = Mysql();
  await db.getConnection().then((connessione) async {
    await connessione.query(query).then((result) {
      for (var res in result) {
        //Aggiungo all'array
        listofAnswerQuestions.add(res[0].toString());
        listofAnswerQuestions.add(res[1].toString());
        listofAnswerQuestions.add(res[2].toString());
        listofAnswerQuestions.add(res[3].toString());
      }
    });
  });
}

/*
Al momento non utilizzato
//Prendo la risposta corretta dal database
Future<void> getCorrectAnswer() async {
  String table = 'listaDomande';
  //Scrivo la query
  String query = 'SELECT rispostaCorretta FROM ' + table;
  var db = Mysql();
  await db.getConnection().then((connessione) async {
    await connessione.query(query).then((result) {
      for (var res in result) {
        //Aggiungo all'array
        listofCorrectAnswer.add(res[0].toString());
      }
    });
  });
}
*/

////////////////////////
//METODI PER IMPICCATO//
////////////////////////

//Prendo le domande dal database
Future<void> getParole(int randomNumber) async {
  String table = 'listaparole';
  //Scrivo la query
  String query = 'SELECT parola FROM ' +
      table +
      ' where idlistaparole = ' +
      randomNumber.toString();
  debugPrint(query);
  var db = Mysql();
  await db.getConnection().then(
    (connessione) async {
      await connessione.query(query).then(
        (result) async {
          for (var res in result) {
            word = res[0].toString();
          }
        },
      );
    },
  );
}


///////////////////////
//METODI PER IMMAGINI//
///////////////////////




/*
//si crea pulsante per iniziare il gioco di memoria
InkWell(
  onTap: () {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MemoriaScreen()));
  },
  child: Container(
    width: double.infinity,
    alignment: Alignment.center,
    padding: EdgeInsets.all(kDefaultPadding * 0.75), // 15
    decoration: BoxDecoration(
      gradient: kPrimaryGradient,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    child: Text(
      "Inizia il gioco di memoria",
      style: Theme.of(context)
          .textTheme
          .button
          ?.copyWith(color: Colors.black),
    ),
  ),
),
*/
