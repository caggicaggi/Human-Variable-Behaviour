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

int i = 0;

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
            onPressed: () {
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
