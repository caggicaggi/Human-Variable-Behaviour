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
    "question":
        "C'è un alunna molto brava in tutte le materie e la noti mentre deride un alunno che ha preso un voto più basso",
    "options": [
      'Se hai preso di più, ti metti anche te a deriderlo',
      'Intervieni o chiami la professoressa',
      'Ignori la situazione',
      'Ti metti a ridere'
    ],
    "answer_index": 1,
  },
  {
    "id": 2,
    "question": "Cosa faresti se vedessi una ragazza piangere?",
    "options": [
      'Cerco i miei amici per deriderla',
      'Comincio a fargli foto',
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
      'lo minaccio perchè non lo deve dire a nessuno'
    ],
    "answer_index": 0,
  },
  {
    "id": 4,
    "question":
        "A chi chiederesti aiuto se vedi qualcuno che ti da fastidio a scuola?",
    "options": [
      'Alla preside',
      'Alla bidella',
      'Alla professoressa',
      'A chi guida il pulman di scuola'
    ],
    "answer_index": 2,
  },
];


//CLASSE DA LAVORARE PER RENDERLA DINAMICA

/* List<String> listofQuestion = [];
List<int> listofIdQuestions = [];
List<String> listofAnswerQuestions = [];

List sample_data = [
  {
    "id": listofIdQuestions[0],
    "question": listofQuestion[0],
    "options": [
      listofAnswerQuestions[0],
      listofAnswerQuestions[1],
      listofAnswerQuestions[2],
      listofAnswerQuestions[3],
    ],
    "answer_index": 1,
  },
  {
    "id": listofIdQuestions[1],
    "question": listofQuestion[1],
    "options": [
      listofAnswerQuestions[4],
      listofAnswerQuestions[5],
      listofAnswerQuestions[6],
      listofAnswerQuestions[7],
    ],
    "answer_index": 1,
  },
  {
    "id": listofIdQuestions[2],
    "question": listofQuestion[2],
    "options": [
      listofAnswerQuestions[8],
      listofAnswerQuestions[9],
      listofAnswerQuestions[10],
      listofAnswerQuestions[11],
    ],
    "answer_index": 0,
  },
  {
    "id": listofIdQuestions[3],
    "question": listofQuestion[3],
    "options": [
      listofAnswerQuestions[12],
      listofAnswerQuestions[13],
      listofAnswerQuestions[14],
      listofAnswerQuestions[15],
    ],
    "answer_index": 2,
  },
];

String getDomanda(var i) {
  String check = '';
  String table = 'listaDomande';
  //Scrivo la query
  String query =
      'SELECT domanda FROM ' + table + ' WHERE idDom = ' + i.toString();
  var db = Mysql();
  //eseguo querys
  db.getConnection().then((connessione) async {
    //delay obbligatorio per Malaccari
    await Future.delayed(const Duration(milliseconds: 1));
    await connessione.query(query).then((result) async {
      listofQuestion.add(result.toString());
      connessione.close();
    });
  });

  return check;
}

String getIdDomanda(var i) {
  String check = '';
  String table = 'listaDomande';
  //Scrivo la query
  String query =
      'SELECT idDom FROM ' + table + ' WHERE idDom = ' + i.toString();
  var db = Mysql();
  //eseguo querys
  db.getConnection().then((connessione) async {
    //delay obbligatorio per Malaccari
    await Future.delayed(const Duration(milliseconds: 1));
    await connessione.query(query).then((result) async {
      for (var res in result) {
        listofIdQuestions.add(int.parse(res[0].toString()));
        print(listofIdQuestions);
      }
      connessione.close();
    });
  });

  return check;
}

String getAnswerQuestion(var i) {
  String check = '';
  String table = 'listaDomande';
  //Scrivo la query
  String query =
      'SELECT rispostaCorretta,rispostaErrata1,rispostaErrata2,rispostaErrata3 FROM ' +
          table +
          ' WHERE idDom = ' +
          i.toString();
  var db = Mysql();
  //eseguo querys
  db.getConnection().then((connessione) async {
    //delay obbligatorio per Malaccari
    await Future.delayed(const Duration(milliseconds: 1));
    await connessione.query(query).then((result) async {
      for (var res in result) {
        listofAnswerQuestions.add(res[0].toString());
        listofAnswerQuestions.add(res[1].toString());
        listofAnswerQuestions.add(res[2].toString());
        listofAnswerQuestions.add(res[3].toString());

        print(listofIdQuestions);
      }
      connessione.close();
    });
  });

  return check;
}
*/