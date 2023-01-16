// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/body.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_quiz/quizComponents/optionWidget.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_quiz/quizComponents/question.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_quiz/quizComponents/resultPage.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  //Variabile per pagina da visualizzare
  late PageController _controller;
  //Numero della domanda che si sta facendo
  int _questionNumber = 1;
  //Punteggio ottenuto
  int _score = 0;

  bool _isLocked = false;

  @override
  void initState() {
    super.initState();
    //Parto dalla prima pagina
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            //Mostra le domande una alla volta
            child: PageView.builder(
              itemCount: questions.length,
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final _question = questions[index];
                return buildQuestion(_question);
              },
            ),
          ),
          _isLocked ? buildElevatedButton() : SizedBox.shrink(),
        ],
      ),
    );
  }

  Column buildQuestion(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Spaziatura
        SizedBox(
          height: 30,
        ),
        Text(
          question.text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        //Spaziatura
        SizedBox(
          height: 5,
        ),
        Center(
          child: Expanded(
            child: OptionsWidget(
              question: question,
              onClickedOption: (option) {
                if (question.isLocked) {
                  return;
                } else {
                  setState(() {
                    question.isLocked = true;
                    question.selectedOption = option;
                  });
                  _isLocked = question.isLocked;
                  if (question.selectedOption!.isCorrect) {
                    _score++;
                  }
                }
              },
            ),
          ),
        )
      ],
    );
  }

  ElevatedButton buildElevatedButton() {
    return ElevatedButton(
      onPressed: () {
        if (_questionNumber < questions.length) {
          _controller.nextPage(
            duration: Duration(milliseconds: 250),
            curve: Curves.easeInExpo,
          );
          setState(() {
            _questionNumber++;
            _isLocked = false;
          });
        } else {
          //Vado alla pagina dello score
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              //Passo lo score ottenuto
              builder: (context) => ResultPage(score: _score),
            ),
          );
        }
      },
      child: Text(_questionNumber < questions.length
          ? 'Prossima domanda'
          : 'Vedi il risultato'),
    );
  }
}
