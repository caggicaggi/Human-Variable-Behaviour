import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/hangman_screen.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/utils/game.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/ui/answer_button.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/utils/quiz.dart.dart';
import 'package:human_variable_behaviour/Screens/HomePage/homepage_screen.dart';

class ScorePageHangManBadQuestion extends StatefulWidget {
  ScorePageHangManBadQuestion();
  @override
  _ScorePageHangManState createState() => _ScorePageHangManState();
}

class _ScorePageHangManState extends State<ScorePageHangManBadQuestion> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/sfondo_games.png",
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              Spacer(flex: 3),
              Text(
                "QUESTA VOLTA NON CI SEI RIUSCITO, TRANQUILLO RIPROVACI!",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.amber),
              ),
              Spacer(flex: 3),
              Image.asset(
                "assets/images/logoUnicam.jpg",
                height: size.height * 0.2,
                width: size.width * 0.7,
                fit: BoxFit.cover,
              ),
              Spacer(flex: 3),
              TextButton(
                onPressed: (() {
                  setState(() {});
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
                child: Text(
                  'TORNA ALLA HOME PAGE',
                  style: TextStyle(
                    backgroundColor: Colors.amber,
                    fontSize: 20,
                    foreground: Paint()
                      ..strokeWidth = 2
                      ..color = Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}