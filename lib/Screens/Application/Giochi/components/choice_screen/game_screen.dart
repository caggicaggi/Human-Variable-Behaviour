// ignore_for_file: use_build_context_synchronously

import 'dart:math';
import 'package:flutter/material.dart';

import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/hangman_screen.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/pages/quiz_page.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/quiz_game/quizPage_screen.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';

import 'models/games_model.dart';

/////////////
//QUIZ GAME//
/////////////
/////Metodi per caricare domande da DB
//Array per lista delle domande
List<String> listofQuestion = [];
//Array per lista delle risposte
List<String> listofAnswerQuestions = [];
//Array per lista id domande
List<int> listofIdQuestions = [];
 Set<int> rndNum = {}  ;

//Array di Domanda
var questions = [];

//Parola che si dovrà indovinare
String word = '';

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
                      rndNum.clear();
                      do {
                        Random random = Random();
                      rndNum.add(random.nextInt(17)+1) ;
                      } while (rndNum.length <4);
                      debugPrint(rndNum.toString());
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

                      //Passo alla schermata del quiz
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuizPage(),
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
              textAlign: TextAlign.center,
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

