import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/ui/answer_button.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/utils/quiz.dart.dart';
import 'package:human_variable_behaviour/Screens/HomePage/homepage_screen.dart';

class ScorePage extends StatefulWidget {
  final int score;
  final int totalQuestion;

  ScorePage(this.score, this.totalQuestion);
  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/sfondo_games.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              Spacer(flex: 3),
              Text(
                "Score",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.amber),
              ),
              Spacer(),
              Text(
                "${widget.score.toString()}/${widget.totalQuestion.toString()}",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: Colors.amber),
              ),
              Spacer(flex: 3),
              TextButton(
                onPressed: (() {
                  setState(() {});

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
