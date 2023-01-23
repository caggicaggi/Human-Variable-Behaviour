class Game {
  final String name;
  final String imagePath;
  final String descrition;
  final String category;
  final String difficolta;
  final Duration duration;

  const Game(
      {required this.name,
      required this.imagePath,
      required this.descrition,
      required this.category,
      required this.difficolta,
      required this.duration});

  static const List<Game> games = [
    Game(
      name: 'Cosa ne sai del bullismo?',
      imagePath:
          'https://www.tecnodigitalacademy.it/wp-content/uploads/2022/07/quizzone-simulazione-ecdl.jpg',
      descrition:
          'Approfondisci le tematiche del bullismo attraverso un facile Quiz con risposta multipla. Impegnati per rispondere correttamente alle 4 domande che ti verrano mostrate e per imparare qualcosa di nuovo sul bullismo',
      category: 'Quiz',
      difficolta: 'Facile',
      duration: Duration(hours: 2, minutes: 9),
    ),
    Game(
      name: 'True or False',
      imagePath:
          'https://i0.wp.com/immobiliarebaiesi.net/wp-content/uploads/2018/02/veroofalso.jpg?fit=629%2C250&ssl=1',
      descrition:
          'Mettiti alla prova attraverso un facile indovinello Vero o Falso, ti verrano mostrate delle immagini riguardanti il tema del bullismo e dovrai eseere in grado di decidere se quello che vedi è vero o si tratta di un falso',
      category: 'Vero o Falso',
      difficolta: 'Facile',
      duration: Duration(hours: 3, minutes: 22),
    ),
    Game(
      name: 'HangMan',
      imagePath:
          'https://www.noinonni.it/wp-content/uploads/2019/11/gioco-impiccato.jpg',
      descrition:
          'Prova ad indovinare la parola nascosta per imparare qualcosa di nuovo sul bullismo e sulle altre forme di violenza. Tenta di indovinare la parola cliccando su una lettera e scoprire se fa parte della parola.',
      category: 'Gioco dell impiccato',
      difficolta: 'Facile',
      duration: Duration(hours: 42, minutes: 24),
    )
  ];
}
