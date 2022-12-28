import 'dart:math';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/utils/questions.dart.dart';

//si dichiara variabili che verranno usate
bool b1 = false;
//lista di indici casuali
Set<int> setOfInts1 = Set();
//indice che ritornerà
int index = 0;
//numero di domande fatte
int checknumberQuestions = 0;
//max= numero di domande da fare
int max = 4;

class Quiz {
  ///si dichiara variabili che verranno usate

  List<Question> _questions;
  int _currentQuestionIndex = -1;
  int _score = 0;

  Quiz(this._questions);
  //si dichiara le funzioni get
  int get score => _score;
  List<Question> get questions => _questions;
  int get length => max;
  int get questionNumber => _currentQuestionIndex + 1;

  Question? get nextQuestion {
    //si setta l'indice casuale
    index = setIndex();
    //lo si assegna alla domanda corrente
    _currentQuestionIndex = index;
    //si incrementa il numero delle domande
    checknumberQuestions++;

    //termino domande
    if (checknumberQuestions > max) {
      return null;
    }

    return _questions[_currentQuestionIndex];
  }

  //conta le risposte corrette
  void answer(bool isCorrect) {
    if (isCorrect) {
      _score++;
    }
  }

//metodo per estrerre indice casuale dalla lista per immagini casuali
  int setIndex() {
    int index = 0;
    //creo oggetto Random per generare l'indice casuale
    Random random = Random();
    //Indice dell'ultima domanda
    int maxIndex = 8;
    if (b1 == false) {
      do {
        //si genera numero casuale da 0 a max che corrisponde al numero delle immagini totali
        setOfInts1.add(Random().nextInt(maxIndex) + (0));
      } while (setOfInts1.length < max);
      b1 = true;
    }
    //si setta l'indice al primo valore della lista
    for (var j in setOfInts1) {
      index = setOfInts1.first;
    }
    // si rimuove il primo indice della lista
    setOfInts1.remove(index);
    return index;
  }
}
