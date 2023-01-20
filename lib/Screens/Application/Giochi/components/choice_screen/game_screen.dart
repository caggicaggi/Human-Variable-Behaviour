// ignore_for_file: use_build_context_synchronously

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/body.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/hangman_screen.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/pages/quiz_page.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_quiz/quizComponents/question.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_quiz/quizComponents/questionsToDisplay.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';

import 'models/games_model.dart';

/////////////
//QUIZ GAME//
/////////////
//Array per lista delle domande
List<String> listofQuestion = [];
//Array per lista delle risposte
List<String> listofAnswerQuestions = [];
//Array per lista id domande
List<int> listofIdQuestions = [];
//Array di Domanda
var questions = [];

class GameScreen extends StatelessWidget {
  final Game game;
  const GameScreen({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          ..._buildBackground(context, game),
          _buildGameInformation(context),
          Positioned(
            bottom: 50,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const SizedBox(width: 10),
                //pulsante Start
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10.0),
                    primary: Colors.white,
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.425,
                      50,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  //OnPressed per far iniziare il gioco
                  onPressed: () async {
                    if (game.name == 'True or False') {
                      //Incremento il numero di tentativi
                      await addTry('Tentativi_Totali_Immagini');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QuizPagina()));
                    }
                    if (game.name == 'HangMan') {
                      //Incremento il numero di tentativi
                      await addTry('Tentativi_Totali_Impiccato');
                      //Numero random per acquisizione parola
                      Random random = new Random();
                      int randomNumber =
                          random.nextInt(10); // from 0 upto 10 included
                      await getParole(randomNumber);
                      debugPrint(word);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HangMan()));
                    }
                    if (game.name == 'Cosa ne sai del bullismo?') {
                      //Incremento il numero di tentativi
                      await addTry('Tentativi_Totali_Quiz');
                      //Cancello la lista delle domande
                      listofQuestion = [];
                      listofAnswerQuestions = [];
                      listofIdQuestions = [];
                      //Prendo le domande dal database
                      await getIdDomanda();
                      await getDomanda();
                      await getAnswerQuestion();
                      //Creo le domande e le relative risposte
                      questions = [
                        Question(
                          text: listofQuestion[0],
                          options: [
                            //Risposte
                            Option(
                                text: listofAnswerQuestions[1],
                                isCorrect: false),
                            Option(
                                text: listofAnswerQuestions[0],
                                isCorrect: true),
                            Option(
                                text: listofAnswerQuestions[2],
                                isCorrect: false),
                            Option(
                                text: listofAnswerQuestions[3],
                                isCorrect: false),
                          ],
                        ),
                        //Domanda
                        Question(
                          text: listofQuestion[1],
                          //Risposte
                          options: [
                            Option(
                                text: listofAnswerQuestions[4],
                                isCorrect: true),
                            Option(
                                text: listofAnswerQuestions[5],
                                isCorrect: false),
                            Option(
                                text: listofAnswerQuestions[6],
                                isCorrect: false),
                            Option(
                                text: listofAnswerQuestions[7],
                                isCorrect: false),
                          ],
                        ),
                        //Domanda
                        Question(
                          text: listofQuestion[2],
                          options: [
                            //Risposte
                            Option(
                                text: listofAnswerQuestions[9],
                                isCorrect: false),
                            Option(
                                text: listofAnswerQuestions[10],
                                isCorrect: false),
                            Option(
                                text: listofAnswerQuestions[8],
                                isCorrect: true),
                            Option(
                                text: listofAnswerQuestions[11],
                                isCorrect: false),
                          ],
                        ),
                        //Domanda
                        Question(
                          text: listofQuestion[3],
                          options: [
                            //Risposte
                            Option(
                                text: listofAnswerQuestions[13],
                                isCorrect: false),
                            Option(
                                text: listofAnswerQuestions[14],
                                isCorrect: false),
                            Option(
                                text: listofAnswerQuestions[15],
                                isCorrect: false),
                            Option(
                                text: listofAnswerQuestions[12],
                                isCorrect: true),
                          ],
                        ),
                      ];

                      //Passo alla schermata del quiz
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuestionToDisplay(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Inizia',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }

  Positioned _buildGameInformation(BuildContext context) {
    return Positioned(
      bottom: 150,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              game.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${game.difficolta} | ${game.category}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              game.descrition,
              maxLines: 8,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(height: 1.75, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBackground(
    context,
    game,
  ) {
    return [
      Container(
        height: double.infinity,
        color: const Color(0xFF122393),
      ),
      Image.network(
        game.imagePath,
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.5,
        fit: BoxFit.cover,
      ),
      const Positioned.fill(
        child: DecoratedBox(
            decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Color(0xFF122393),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.3, 0.5]),
        )),
      ),
    ];
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
}

//Aggiungo un tentativo riuscito alla tabella data in input
Future<void> addTryCorrect(colonna) async {
  String query =
      'select ' + colonna + ' from utenti where idUtente = ' + idUtente;
  String queryUpdate = '';
  //Connessione al database
  var db = Mysql();
  await db.getConnection().then((connessione) async {
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
}

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
