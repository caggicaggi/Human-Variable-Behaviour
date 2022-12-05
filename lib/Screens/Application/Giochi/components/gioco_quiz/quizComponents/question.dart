//Definisce l'oggetto Question
class Question {
  //Domanda da fare
  late final String text;
  //Risposta disponibile
  late final List<Option> options;
  late bool isLocked;
  Option? selectedOption;

  Question({
    required this.text,
    required this.options,
    this.isLocked = false,
    this.selectedOption,
  });
}

//Definisco l'oggetto Option
class Option {
  //Risposta
  final String text;
  //Boolean per verificare se corretta o no
  final bool isCorrect;

  const Option({
    required this.text,
    required this.isCorrect,
  });
}
