import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/pages/score_page.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/ui/answer_button.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/ui/correct_wrong_overlay.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/ui/question_text.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/utils/questions.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/utils/quiz.dart.dart';

class QuizPagina extends StatefulWidget {
  //si crea lo stato
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPagina> {
  late Question currentQuestion;
  //si crea lista delle domande, le risposte e le immagini
  Quiz quiz = Quiz([
    Question("Nella foto si può vedere obama?", true, "assets/images/p1.jpeg"),
    Question("Questa è una pizza?", false, "assets/images/p2.jpeg"),
    Question("Questo è bacon", false, "assets/images/p3.jpeg"),
    Question("In foto si può vedere Elon Mask?", true, "assets/images/p4.jpeg"),
  ]);

  //si inizializza le variabili che si useranno
  late String questionText;
  late String imageName;
  late int questionNumber;
  late bool isCorrect;
  bool overlayShouldBeVisible = false;

  @override
  void initState() {
    super.initState();
    //si setta le variabili
    currentQuestion = quiz.nextQuestion!;
    questionText = currentQuestion.question;
    imageName = currentQuestion.image;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(bool answer) {
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState(() {
      overlayShouldBeVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    //si occupa tutto lo schermo sia in lunghezza che altezza
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(" Buon divertimento!"),
        backgroundColor: Colors.blue,
        elevation: 0.5,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
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
                padding: EdgeInsets.all(size.height * 0.02),
              ),
              QuestionTextWithImage("$questionText", imageName),
              Padding(
                padding: EdgeInsets.all(size.height * 0.02),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Risposta corretta
                  AnswerButton(true, () => handleAnswer(true)),
                  Padding(
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
                  this.setState(() {
                    overlayShouldBeVisible = false;
                    questionText = currentQuestion.question;
                    imageName = currentQuestion.image;
                    questionNumber = quiz.questionNumber;
                  });
                })
              : new Container(),
        ],
      ),
    );
  }
}
