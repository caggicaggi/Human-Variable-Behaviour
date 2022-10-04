// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/hangman_screen.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/pages/landing_page.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/pages/quiz_page.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_memoria/memoria_screen.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_quiz/options_games.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_quiz/questions_controller.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_quiz/quiz_questions.dart';
import 'package:human_variable_behaviour/Screens/HomePage/homepage_screen.dart';
import 'package:human_variable_behaviour/constant.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';

int i = 0;

List<String> listofQuestion = [];
List<int> listofIdQuestions = [];
List<String> listofAnswerQuestions = [];

class GiochiScreen extends StatelessWidget {
  const GiochiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //si occupa tutto lo schermo sia in altezza che in larghezza
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          //si inserisce immagine dello sfondo
          Image.asset(
            "assets/images/sfondo_games.png",
            height: size.height,
            width: size.width,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //si inserisce spaziatura
                  Spacer(flex: 2), //2/6
                  Text(
                    "Ora comincia a giocare!",
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  //si inserisce spaziatura
                  Spacer(
                    flex: 1,
                  ), // 1/6
                  //si crea pulsante per iniziare il gioco del quiz
                  InkWell(
                    onTap: () async {
                      //Incremento il numero di tentativi
                      addTry('Tentativi_Totali_Quiz');
                      //listofAllQuestionsInformations();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuizScreen()));
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
                        "Inizia il quiz",
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                  //si inserisce spaziatura
                  Spacer(
                    flex: 1,
                  ), // 1/6
                  //si crea pulsante per iniziare il gioco dell'indovina l'immagine
                  InkWell(
                    onTap: () {
                      //Incremento il numero di tentativi
                      addTry('Tentativi_Totali_Immagini');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LandingPage()));
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
                        "Indovina l'immagine",
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                  //si inserisce spaziatura
                  Spacer(
                    flex: 1,
                  ),
                  //si crea pulsante per iniziare il gioco dell'impiccato
                  InkWell(
                    onTap: () {
                      //Incremento il numero di tentativi
                      addTry('Tentativi_Totali_Impiccato');
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HangMan()));
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
                        "Inizia il gioco dell'impiccato",
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                  //si inserisce spaziatura
                  Spacer(
                    flex: 1,
                  ),
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
                  //si inserisce spaziatura
                  Spacer(
                    flex: 4,
                  ), // it will take 2/6 spaces
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void addTry(colonna) async {
  String query =
      'select ' + colonna + ' from utenti where idUtente = ' + idUtente;
  debugPrint('Query: ' + query);
  String queryUpdate = '';
  //Connessione al database
  var db = Mysql();
  await db.getConnection().then((connessione) async {
    //delay obbligatorio per Malaccari
    await Future.delayed(const Duration(milliseconds: 1));
    await connessione.query(query).then((result) async {
      for (var res in result) {
        debugPrint('Risultato: ' + res[0].toString());
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
  debugPrint(queryUpdate.toString());
  db = Mysql();
  await db.getConnection().then((connessione) async {
    //delay obbligatorio per Malaccari
    await Future.delayed(const Duration(milliseconds: 1));
    await connessione.query(queryUpdate).then((result) async {
      (value) => connessione.close();
    });
  });
}

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //si occupa tutto lo schermo in lunghezza e larghezza
    Size size = MediaQuery.of(context).size;
    //si cancella l'istanza del controller
    Get.delete<QuestionController>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // nasconde il backButton messo automaticamente da flutter
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: () async {
              //si cancella l'istanza del controller
              Get.delete<QuestionController>();
              //si va alla pagina iniziale dove scelgo i giochi
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GiochiScreen()),
              );
            },
            child: Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                child: Icon(
                  color: Colors.white,
                  Icons.home,
                  size: size.height * 0.04,
                ),
                onPressed: () {
                  //si cancella instanza del controller
                  Get.delete<QuestionController>();
                  //si resetta variabile di controllo
                  b = false;
                  //si ritorna alla HomePage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePageScreen()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: Body(),
    );
  }
}
