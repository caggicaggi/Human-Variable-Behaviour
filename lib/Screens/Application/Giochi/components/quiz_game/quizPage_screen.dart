import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/quiz_game/data/quizQuestions_list.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/quiz_game/quizScoreScreen.dart';





class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Color mainColor = Colors.blue;
  Color secondColor = Colors.yellow;

  //PageController per il PageView
  PageController? _controller = PageController(initialPage: 0);
  //setto le variabili del gioco
  bool isPressed = false;
  Color isTrue = Colors.green;
  Color isWrong = Colors.red;
  Color btnColor = Colors.yellow;
  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Padding(
        padding: EdgeInsets.all(18.0),
        child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: _controller!,
            onPageChanged: (page) {
              setState(() {
                isPressed = false;
              });
            },
            itemCount: quizQuestions.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Question ${index + 1} / ${quizQuestions.length}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 28.0,
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                    height: 8.0,
                    thickness: 1.0,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  //creaQuizQuestions()
                  //DOMANDA
                  Text(
                    quizQuestions[index].quizQuestion!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  
                  //Lista di button che rappresentano le opzioni di risposta
                  for (int i = 0;
                      i < quizQuestions[index].quizAnswer!.length;
                      i++)
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 12.0),
                      child: MaterialButton(
                        shape: StadiumBorder(),
                        //imposto il colore dei pulsanti
                        color: isPressed
                            ? quizQuestions[index]
                                    .quizAnswer!
                                    .entries
                                    .toList()[i]
                                    .value
                                ? isTrue
                                : isWrong
                            : secondColor,
                        padding: EdgeInsets.symmetric(vertical: 18.0),
                        onPressed: isPressed
                            ? () {}
                            : () {
                                setState(() {
                                  isPressed = true;
                                });
                                //Controllo se domanda è vera
                                if (quizQuestions[index]
                                    .quizAnswer!
                                    .entries
                                    .toList()[i]
                                    .value)
                                //Risposta giusta
                                {
                                  score += 10;
                                  debugPrint(score.toString());
                                }
                              },
                        child: Text(
                          quizQuestions[index].quizAnswer!.keys.toList()[i],
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: isPressed
                            ? index + 1 == quizQuestions.length
                                ? () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                QuizScoreScreen(score)));
                                  }
                                : () {
                                    _controller!.nextPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.linear);
                                    setState(() {
                                      isPressed = false;
                                    });
                                  }
                            : null,
                        style: OutlinedButton.styleFrom(
                            shape: StadiumBorder(),
                            backgroundColor: Color.fromARGB(255, 243, 33, 191),
                            side: BorderSide(
                              color: Color.fromARGB(255, 243, 226, 33),
                              width: 1.0,
                            )),
                        child: Text(
                          index + 1 == quizQuestions.length
                              ? "See result"
                              : "Next Question",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }
}
