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
  //si crea lista delle domande, le risposte e le immagini
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
    debugPrint(imageName.toString());
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
