// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_quiz/quizComponents/questionWidget.dart';
import 'package:human_variable_behaviour/constant.dart';

//Stampo le domande
class QuestionToDisplay extends StatefulWidget {
  const QuestionToDisplay({Key? key}) : super(key: key);

  @override
  State<QuestionToDisplay> createState() => _QuestionToDisplayState();
}

class _QuestionToDisplayState extends State<QuestionToDisplay> {
  @override
  Widget build(BuildContext context) {
    //Occupo tutto lo schermo sia in altezza che in lunghezza
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        //Immagine di sfondo
        decoration: getBackroundImageHomePage(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //Inserisco il widget per le domande
          children: [
            Expanded(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: QuestionWidget(),
              ),
            ),
            SizedBox(
              height: size.height * 0.10,
            ),
          ],
        ),
      ),
    );
  }
}
