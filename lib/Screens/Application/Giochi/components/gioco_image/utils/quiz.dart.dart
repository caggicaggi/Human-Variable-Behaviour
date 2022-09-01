import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/utils/questions.dart.dart';

bool b1 = false;

Set<int> setOfInts1 = Set();
int index = 0;
int checknumberQuestions = 0;

class Quiz {
  List<Question> _questions;
  int _currentQuestionIndex = -1;
  int _score = 0;

  Quiz(this._questions);
  //getter function
  int get score => _score;
  List<Question> get questions => _questions;
  int get length => _questions.length;
  int get questionNumber => _currentQuestionIndex + 1;

  Question? get nextQuestion {
    index = setIndex();
    print(setOfInts1);
    _currentQuestionIndex = index;
    checknumberQuestions++;
    print("index");
    print(index);
    print("currentQUestionindex");
    print(_currentQuestionIndex);
    print("checknumberquestions");
    print(checknumberQuestions);
    print("checknumberQuestions > _questions.length");
    print(checknumberQuestions > _questions.length);
    if (checknumberQuestions > _questions.length) {
      return null;
    }

    return _questions[_currentQuestionIndex];
  }

  void answer(bool isCorrect) {
    if (isCorrect) {
      _score++;
    }
  }

//metodo per estrerre indice casuale dalla lista domande senza ripetizione
  int setIndex() {
    //max= numero di domande
    int max = 4;
    int index = 0;
    Random random = new Random();

    if (b1 == false) {
      do {
        setOfInts1.add(Random().nextInt(max) + (0));
      } while (setOfInts1.length < max);
      b1 = true;
    }

    for (var j in setOfInts1) {
      index = setOfInts1.first;
    }

    //print(setOfInts1);
    //print(index);
    setOfInts1.remove(index);
    return index;
  }
}
