class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question(
      {required this.id,
      required this.question,
      required this.answer,
      required this.options});
}

const List sample_data = [
  {
    "id": 1,
    "question": "Cosa faresti se vedessi un bullo maltrattare un ragazzo?",
    "options": [
      'Ti schieri dalla parte del bullo',
      'Intervieni o chiami qualcuno ',
      'Ignori la situazione',
      'Rimani fermo a guardare'
    ],
    "answer_index": 1,
  },
  {
    "id": 2,
    "question": "Cosa faresti se vedessi una ragazza piangere?",
    "options": [
      'Cerco i miei amici per deriderla',
      'La derido perchè piange',
      'Cerco di capire perchè piange',
      'Faccio finta di niente'
    ],
    "answer_index": 2,
  },
  {
    "id": 3,
    "question": "Cosa faresti se accidentalmente fai male ad un ragazzo?",
    "options": [
      'Mi scuso e vedo se si è fatto male',
      'Comincio a ridere',
      'Me ne vado senza fare nulla',
      'Cerco di fargli ancora male'
    ],
    "answer_index": 0,
  },
  {
    "id": 4,
    "question":
        "A chi chiederesti aiuto se c'è gente che ti da fastidio a scuola?",
    "options": [
      'Alla polizia',
      'Alla bidella',
      'Alla professoressa ',
      'Ai pompieri '
    ],
    "answer_index": 2,
  },
];
