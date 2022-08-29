import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_quiz/Score.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_quiz/options_games.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_quiz/quiz_questions.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';

// We use get package for our state management

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  // Lets animated our progress bar

  late AnimationController _animationController;
  late Animation _animation;
  // so that we can access our animation outside
  Animation get animation => this._animation;

  late PageController _pageController;
  PageController get pageController => this._pageController;

  List<Question> _questions = sample_data
      .map(
        (question) => Question(
            id: question['id'],
            question: question['question'],
            options: question['options'],
            answer: question['answer_index']),
      )
      .toList();

  List<Question> get questions => this._questions;

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  late int _correctAns;
  int get correctAns => this._correctAns;

  late int _selectedAns;
  int get selectedAns => this._selectedAns;

  // for more about obs please check documentation
  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => this._numOfCorrectAns;
  int get __numOfCorrectAns => this.__numOfCorrectAns;
  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    // Our animation duration is 60 s
    // so our plan is to fill the progress bar within 60s
    _animationController =
        AnimationController(duration: Duration(seconds: 10), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        update();
      });

    // start our animation
    // Once 60s is completed go to the next qn
    _animationController.forward().whenComplete(nextQuestion);
    _pageController = new PageController();
    super.onInit();
  }

  void resetScoreNumber() => _numOfCorrectAns = 0;
  void resetQuestionNumber() => _questionNumber.value = 1;
  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

//controllo risposta
  void checkAns(Question question, int selectedIndex) async {
    // because once user press any option then it will run
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) {
      // conto risposte corrette
      _numOfCorrectAns++;
      //controllo se la domanda è gia presente
      await readQuestions(question.question);
      //non è presente quindi faccio l'insert
      if (risultatoQueryDomande) {
        await signDomandaERisposta(
            idUtente, question.question, question.options[_selectedAns]);
      }
      //è presente quindi faccio l'update
      await updateDomandaCorretta(
          idUtente, question.question, question.options[_selectedAns]);
    } else {
      //controllo se la domanda è gia presente
      await readQuestions(question.question);
      //non è presente quindi faccio l'insert
      if (risultatoQueryDomande) {
        //non è presente quindi faccio l'insert
        await signDomandaERisposta(
            idUtente, question.question, question.options[_selectedAns]);
      }
      await updateDomandaCorretta(
          //è presente quindi faccio l'update
          idUtente,
          question.question,
          question.options[_selectedAns]);
    }

    // It will stop the counter
    _animationController.reset();
    update();

    // Once user select an ans after 3s it will go to the next qn
    await Future.delayed(Duration(seconds: 1), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);

      // Reset the counter
      _animationController.reset();

      setOfInts.remove(setOfInts.first);
      // Then start it again
      // Once timer is finish go to the next qn
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      // Reset the counter
      _animationController.reset();
      _questionNumber = 1.obs;
      _isAnswered = false;
      onInit();

      update();
      // Get package provide us simple way to naviigate another page
      Get.to(ScoreScreen());
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
