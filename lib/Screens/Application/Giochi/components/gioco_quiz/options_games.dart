import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_quiz/questions_controller.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_quiz/quiz_questions.dart';
import 'package:human_variable_behaviour/constant.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';

//si dichiara variabili che verrano usate
int count = 0;
bool b = false;
Set<int> setOfInts = Set();

bool checkBool = false;

class Option extends StatelessWidget {
  //si crea costruttore
  const Option({
    Key? key,
    required this.text,
    required this.index,
    required this.press,
  }) : super(key: key);
  final String text;
  final int index;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    //si occupa tutto lo schermo sia in larghezza che lunghezza
    Size size = MediaQuery.of(context).size;
    return GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (qnController) {
          //si setta la risposta per far venire il flag verde o rosso
          Color getTheRightColor() {
            if (qnController.isAnswered) {
              if (index == qnController.correctAns) {
                return kGreenColor;
              } else if (index == qnController.selectedAns &&
                  qnController.selectedAns != qnController.correctAns) {
                return kRedColor;
              }
            }
            return kGrayColor;
          }

          IconData getTheRightIcon() {
            return getTheRightColor() == kRedColor ? Icons.close : Icons.done;
          }

          //si stampa totale e domanda corrente e implemento i metodo sopra dichiarati
          return InkWell(
            onTap: press,
            child: Container(
              margin: EdgeInsets.only(top: kDefaultPadding),
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                border: Border.all(color: getTheRightColor()),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${index + 1}. $text",
                    style: TextStyle(
                        color: Colors.black, fontSize: size.height * 0.016),
                  ),
                  Container(
                    height: size.width * 0.062,
                    width: size.height * 0.03,
                    decoration: BoxDecoration(
                      color: getTheRightColor() == kGrayColor
                          ? Colors.transparent
                          : getTheRightColor(),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: getTheRightColor()),
                    ),
                    child: getTheRightColor() == kGrayColor
                        ? null
                        : Icon(getTheRightIcon(), size: size.height * 0.03),
                  )
                ],
              ),
            ),
          );
        });
  }
}

//classe che stampa le domande
class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //si occupa tutto lo schermo sia in larghezza che lungezza
    Size size = MediaQuery.of(context).size;
    //inizializzo controller
    QuestionController _questionController = Get.put(QuestionController());
    //si richiama metodo che resetta il numero di domande dal controller
    _questionController.resetQuestionNumber();
    return Stack(
      children: [
        //si imposta l'immagine di sfondo
        Image.asset(
          "assets/images/sfondo_games.png",
          height: size.height,
          width: size.width,
          fit: BoxFit.cover,
        ),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: ProgressBar(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Obx(
                  () => Text.rich(
                    TextSpan(
                      //visualizzare numero domanda corrente
                      text:
                          "Question ${_questionController.questionNumber.value}",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: kBlackColor),
                      children: [
                        TextSpan(
                          //visualizzare numero domande totali
                          text: "/${_questionController.questions.length}",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: kBlackColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                //dati passati alla QuestionCard per creare domanda
                child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _questionController.pageController,
                  onPageChanged: _questionController.updateTheQnNum,
                  itemCount: _questionController.questions.length,
                  itemBuilder: (context, index) => QuestionCard(
                      //si passa il metodo setIndex per estrarre indice casuale per la domanda
                      question: _questionController.questions[setIndex()]),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

//metodo per estrerre indice casuale dalla lista domande senza ripetizione
int setIndex() {
  //max= numero di domande
  int max = 4;
  int index = 0;
  //si crea lista con numeri casuali
  if (b == false) {
    do {
      setOfInts.add(Random().nextInt(max));
    } while (setOfInts.length < max);
    b = true;
  }

  //si setta l'indice che torna con il primo elemento della lista
  for (var j in setOfInts) {
    index = setOfInts.first;
  }
  return index;
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //si occupa tutto lo schermo sia in lunghezza che altezza
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.05,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF3F4768), width: size.width * 0.01),
        borderRadius: BorderRadius.circular(50),
      ),
      child: GetBuilder<QuestionController>(
        //richiamo il controller
        init: QuestionController(),
        builder: (controller) {
          return Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) => Container(
                  width: constraints.maxWidth * controller.animation.value,
                  decoration: BoxDecoration(
                    gradient: kPrimaryGradient,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // si impostano i secondi della barra di scorrimento
                      Text(
                        "${(controller.animation.value * 20).round()} sec",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  //si crea il  costruttore
  const QuestionCard({
    Key? key,
    required this.question,
  }) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    //si occupa tutto lo schermo sia in altezza che lunghezza
    Size size = MediaQuery.of(context).size;
    //si inizializza il controller
    QuestionController _controller = Get.put(QuestionController());
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.02, vertical: size.width * 0.2),
      padding: EdgeInsets.all(size.height * 0.023),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(55),
      ),
      child: Column(
        children: [
          SizedBox(height: size.height * 0.001),
          //si stampa la domanda corrente
          Text(
            question.question,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: kBlackColor),
          ),
          SizedBox(height: size.height * 0.02),
          //si stampa la lista delle risposte
          ...List.generate(
            question.options.length,
            (index) => Option(
              index: index,
              text: question.options[index],
              //il metodo checkAns controlla la risposta in base all'indice selezionato
              press: () => _controller.checkAns(question, index),
            ),
          ),
        ],
      ),
    );
  }
}
