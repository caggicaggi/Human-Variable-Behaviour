// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/pages/score_page.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/ui/answer_button.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/ui/correct_wrong_overlay.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/ui/question_text.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/utils/questions.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/utils/quiz.dart.dart';

class QuizPagina extends StatefulWidget {
  const QuizPagina({Key? key}) : super(key: key);

  //si crea lo stato
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPagina> {
  late Question currentQuestion;
  String pathImmagini = "assets/images/indovina_immagini/";
  //si crea lista delle domande con le relative risposte e immagini
  Quiz quiz = Quiz([
    Question("In foto si nota del Bullismo Fisico?", true,
        "assets/images/bullismo_fisico.png"),
    Question("In foto si nota del Bullismo Verbale?", false,
        "assets/images/bullismo_relazionale.png"),
    Question("In foto si nota del Bullismo Fisico?", false,
        "assets/images/bullismo_verbale.png"),
    Question("In foto si nota un Bullo?", true, "assets/images/bullo.png"),
    Question("In foto foto si notano dei Complici?", true,
        "assets/images/complici.png"),
    Question("In foto foto si notano esempi di Bullismo?", false,
        "assets/images/cyberbullismo.png"),
    Question("In foto foto si nota un caso di Esclusione?", true,
        "assets/images/esclusione.png"),
    Question(
        "In foto foto si nota una vittima?", true, "assets/images/vittima.png"),
  ]);

  //variabile che conterrà la domanda
  late String questionText;
  //variabile che conterrà il path dell'immagine
  late String imageName;
  //variabile che conterrà il numero di domande
  late int questionNumber;
  //variabile che conterrà il check della domanda (se false o true)
  late bool isCorrect;
  //variabile per far apparire se la soluzione è corretta o no
  bool overlayShouldBeVisible = false;

  @override
  void initState() {
    super.initState();
    //si settano le variabili
    currentQuestion = quiz.nextQuestion!;
    questionText = currentQuestion.question;
    imageName = currentQuestion.image;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(bool answer) {
    //controlllo se corretta
    isCorrect = (currentQuestion.answer == answer);
    //metodo per incrementare le risposte corrette
    quiz.answer(isCorrect);
    setState(() {
      overlayShouldBeVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    //si occupa tutto lo schermo sia in lunghezza che altezza
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SizedBox(
            height: 30,
            width: 100,
          ),
          //si imposta immagine sfondo
          Image.asset(
            "assets/images/sfondo_games.png",
            height: size.height,
            width: size.width,
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //This is our main page
            children: <Widget>[
              Padding(
                //distanza dal bordo superiore
                padding: EdgeInsets.all(size.height * 0.11),
              ),
              QuestionTextWithImage("$questionText", imageName),
              Padding(
                //distanza tra immagine e pulsanti
                padding: EdgeInsets.all(size.height * 0.025),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Risposta corretta
                  AnswerButton(true, () => handleAnswer(true)),
                  Padding(
                    //distanza tra i due pulsanti
                    padding: EdgeInsets.all(size.height * 0.02),
                  ),
                  //Risposta errata
                  AnswerButton(false, () => handleAnswer(false)),
                ],
              )
            ],
          ),
          overlayShouldBeVisible == true
              ? CorrectWrongOverlay(isCorrect, () {
                  //se le domande terminano vado alla pagina ScorePage per il risultato
                  //quindi se la lunghezza delle domande è uguale al numero delle domande fatte
                  if (quiz.length == checknumberQuestions) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ScorePage(quiz.score, quiz.length)),
                        (Route route) => route == ScorePage);
                    return;
                  }

                  currentQuestion = quiz.nextQuestion!;
                  setState(() {
                    overlayShouldBeVisible = false;
                    questionText = currentQuestion.question;
                    imageName = currentQuestion.image;
                    questionNumber = quiz.questionNumber;
                  });
                })
              : Container(),
        ],
      ),
    );
  }
}
