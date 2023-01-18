import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String body;
  final String author;
  final String authorImageUrl;
  final String category;
  final String imageUrl;
  final String secondImageUrl;
  final DateTime createdAt;

  const Article({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.author,
    required this.authorImageUrl,
    required this.category,
    required this.imageUrl,
    required this.secondImageUrl,
    required this.createdAt,
  });

  static List<Article> articles = [
    Article(
      id: '1',
      title: 'A chi posso chiedere aiuto contro il bullismo?',
      subtitle: '',
      body:
          "Sono poche le vittime di bullismo che riescono a parlare liberamente del loro problema con una persona adulta. Si prova vergogna, si ha paura di non essere creduti o, peggio, si è stati minacciati di non farlo. Il bullismo vive di omertà: non aver mai paura di chiedere auto. Bisogna avere coraggio di denunciare. Chi si fa difendere da un genitore non è uno sfigato. Al contrario è importante poter parlare con genitori e adulti di cui ti fidi delle prepotenze subite. Soprattutto se non si tratta di episodi, ma di situazioni che si ripetono quotidiatitlente. Denunciare un atto di bullismo è il primo passo per far cessare una prepotenza e un monito per chi considera la scuola un gioco, piuttosto che uno spazio di crescita personale. Denunciare non significa fare la spia ma aiutare chi è in difficoltà. La scuola è un logo dove tutti hanno diritto a star bene e sentirsi protetti, sicuri. La classe, come la famiglia, dovrebbe essere un ambiente in cui ciascuno può sentirsi al sicuro, protetto. Avere la possibilità di crescere imparando è un diritto e un dovere. Come un diritto e un dovere è stare bene a scuola. A scuola c'è sempre un professore o una professoressa a cui puoi chiedere aiuto se hai visto o subito atti di prepotenza: in ogni scuola è presente un/a referente su bullismo e cyberbullismo che è preparato/a per affrontare il problema. Grazie alla tua denuncia la scuola può intervenire per interrompere le prepotenze e far intervenire un/a psicologo/a",
      author: 'Sigmund Freud',
      authorImageUrl:
          'https://www.studiarapido.it/wp-content/uploads/2014/09/freud.jpeg',
      category: 'Bullismo',
      secondImageUrl:
          'https://media.istockphoto.com/id/1315459620/it/vettoriale/smettila-di-firmare-il-bullismo-stop-al-bullismo-e-agli-abusi-sui-minori-nella-scuola.jpg?s=612x612&w=0&k=20&c=LxA5K3UdiNOnsAAFhs-YqimlVGm69bp8BSyftEbAcjc=',
      imageUrl:
          'https://www.loris-pinzani.it/wp-content/uploads/2021/02/bullismo_scuola_famiglia.jpg',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Article(
      id: '2',
      title: 'Consigli pratici per evitare i rischi dei social network',
      subtitle: '',
      body:
          'Poiché in ambito di sicurezza informatica, l anello debole della catena è sempre l uomo a tutela della propria persona e dei minori si consiglia di: non pubblicare foto altrui senza il consenso dell interessato o dei genitori in caso si vogliano pubblicare foto di minori; non pubblicare dati personali quali: numeri di telefono, indirizzi di residenza o foto che potrebbero adattarsi ed essere utilizzate per un documento di identità; cambiare spesso la password (che deve avere caratteristiche precise – n. 8 caratteri alfanumerici, caratteri speciali, lettera maiuscola) e non utilizzare la stessa password per diversi account; modificare le impostazioni privacy dei social e renderle più restrittive (controllare chi ci può contattare, chi può leggere quello che scriviamo, chi può condividere post sul nostro diario chi può condividere i nostri post), soprattutto se, benché sconsigliabile, si intende accettare l amicizia di persone non conosciute realmente; non accedere ai profili social, non effettuare acquisti online o operazioni bancarie utilizzando Wi-Fi pubblici e aperti; se si accede al proprio profilo social o all account della nostra banca, da un pc pubblico od utilizzato da altri non salvare mai la password ed effettuare sempre il logout; attivare il tutti gli strumenti messi a disposizione per effettuare il parental control (ad esempio: Safe Search di Google Chrome, Safety Family di Microsoft e software appositamente creati) al fine di controllare le attività al cellulare o al computer dei minori.',
      author: 'Daniela Di Leo',
      authorImageUrl:
          'https://www.tramefestival.it/trame/wp-content/uploads/2018/06/foto.de-leo-759x500.jpg',
      category: 'Privacy e Dati Personali',
      secondImageUrl:
          'https://sites.imsa.edu/acronym/files/2021/11/social_media_mental_health-777x437.png',
      imageUrl:
          'https://khn.org/wp-content/uploads/sites/2/2019/08/GettyImages-928088582.jpg',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Article(
      id: '3',
      title: 'I rischi dei social network',
      subtitle: 'Dal phishing al cyberbullismo',
      body:
          'In considerazione della sempre più precoce età di utilizzo dei social è necessario non sottovalutare i potenziali rischi. Ciò che si scrive e le immagini che si pubblicano sui social network hanno quasi sempre un impatto a breve ed a lungo termine sulla vita reale quotidiana e nei rapporti con le persone con le quali si interagisce ogni giorno. Bisogna tenere presente che ogni volta che si inseriscono i nostri dati personali su un sito su un social network se ne perde il controllo, spesso si concede automaticamente al fornitore del servizio la licenza di utilizzare il materiale che si inserisce foto, chat, opinioni. Ogni volta che si utilizza una carta di credito/debito, che si inserisce una password per accedere a determinati servizi, che si utilizza una carta fedeltà o una tessera di sconto messa a disposizione dalle grandi catene commerciali, che si fa un acquisto online o una ricerca tramite un qualsiasi browser, si compie inevitabilmente una piccola cessione di sovranità. Stessa cosa avviene quando si installano sul nostro smartphone o sul nostro tablet delle app, i programmi di queste applicazioni a volte possono richiedere l accesso alla nostra rubrica, alle nostre foto o contenuti multimediali che nulla hanno a che vedere con la funzionalità della APP stessa. Inoltre, ciò che si inserisce può essere copiato e registrato dagli altri utenti del social e non sempre per fini leciti. Tutto ciò che si scrive e posta, poi, contribuisce a rivelare a terzi chi siamo, cosa facciamo, le nostre abitudini, le nostre condizioni di salute, il nostro tenore di vita, i nostri interessi, le nostre opinioni politiche, religiose, il nostro orientamento sessuale: insomma, tutte informazioni che consentono di creare un nostro profilo che servirà alle aziende commerciali per un marketing più mirato (basta cliccare un “mi piace” su una pagina di un social o su un commento per essere analizzati e etichettati). Ogni volta che condividiamo qualcosa, dobbiamo pensare a chi potrà leggere (datore di lavoro o potenziale datore di lavoro, insegnante dei nostri figli, vicino di casa, conoscente) e dobbiamo valutarne l opportunità chiedendoci, anche, se ciò che pubblichiamo ci potrà piacere tra qualche anno. È notizia recente, a tal proposito, l obbligo per i richiedenti un visto per entrare negli Stati Uniti a fornire i dettagli dei profili social utilizzati in modo da permettere i controlli da parte delle Autorità. Benché la diminuzione della privacy sia insita nell uso di Internet e dei social network vi sono rischi ben più gravi, dal punto di vista delle conseguenze che possono causare ad esempio: furto di identità; diffusione illecita di immagini; pedopornografia, sextortion, sexting e grooming; cyberbullismo; dipendenza da Internet (IAD – Internet Addiction Disorder).',
      author: 'Daniela Di Leo',
      authorImageUrl:
          'https://www.tramefestival.it/trame/wp-content/uploads/2018/06/foto.de-leo-759x500.jpg',
      category: 'Privacy e Dati personali',
      secondImageUrl:
          'https://www.sofarmamorra.it/wp-content/uploads/2015/12/Socialmedia.png',
      imageUrl:
          'https://psicoterapeuta-psicologo.com/wp-content/uploads/2020/11/social.jpg',
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    Article(
      id: '4',
      title: 'Bullismo e cyberbullismo',
      subtitle: 'Un emergenza sociale',
      body:
          'A marzo 2017 il padre di un tredicenne aggredito in strada dai bulli pubblica su Facebook le immagini del figlio con il volto tumefatto. “Vi mostro che cosa sta diventando il mondo - scrive come commento alle foto - e ve lo mostro nel modo più vero e crudo, attraverso quello che si chiama bullismo”. Interrogato sul motivo della scelta, il padre del ragazzo spiega che con quelle immagini vuole “suscitare sdegno per accendere un faro su un problema sociale” che coinvolge adulti e bambini. Poi l appello a denunciare “perché gli autori di tali soprusi non devono passarla liscia”. In breve il post riceve decine di migliaia di condivisioni, con commenti di genitori e ragazzi che esprimono solidarietà alla famiglia del tredicenne. Sulla vicenda intervengono anche il sindaco di Mugnano, comune alle porte di Napoli in cui è avvenuta l aggressione, e altri politici locali. Pochi giorni dopo persino Papa Francesco spende alcune parole contro i bulli. “Ragazzi – dice chiudendo la giornata milanese a San Siro insieme ai giovani cresimati – promettete a Dio e al Papa: mai bullismo”. E ai genitori: “Giocate di più con i vostri figli”. Ma che cosa si intende per bullismo? E, soprattutto, è davvero una piaga sociale? Il bullismo consiste in una serie di comportamenti aggressivi, fisici e psicologici, nei confronti di soggetti che non sono in grado di difendersi. Si basa su tre presupposti: intenzionalità, persistenza nel tempo e asimmetria nella relazione. I ruoli del bullismo sono ben definiti: da una parte ci sono i bulli, coloro che attuano comportamenti violenti, e dall altra ci sono le vittime, coloro che invece subiscono tali atteggiamenti. I comportamenti violenti consistono quasi sempre in offese, insulti, derisione per l aspetto fisico, diffamazione, esclusione per le proprie opinioni fino a vere aggressioni fisiche. Secondo uno studio pubblicato sul Journal of Educational Psychology, il bullismo può accompagnare tutto il percorso scolastico di un bambino: dall asilo al liceo. In alcuni casi si manifesta in Rete, attraverso atteggiamenti aggressivi che vengono messi in atto sui social network, dove il bullo può mantenere l anonimato, ha un pubblico più vasto e può controllare le informazioni personali della vittima. Due ragazzi su tre dichiarano di aver avuto esperienza diretta o indiretta di cyberbullismo (dati della polizia di Stato). Ecco perché a maggio 2017 la Camera ha approvato all unanimità una legge sul cyberbullismo, i cui «cardini» sono una stretta sul web e il coinvolgimento delle scuole nel contrasto delle molestie online. Il professor Luca Bernardo, direttore della Casa Pediatrica dell Ospedale Fatebenefratelli di Milano, l unico centro in Italia che si occupa a livello multidisciplinare di bullismo, cyberbullismo e altre forme di violenza sul web, spiega a La Stampa che “il bullismo è ormai una malattia cronica del nostro Paese, e i social network sono uno dei fattori principali dei fenomeni di violenza e presa in giro nei confronti dei giovanissimi”. I numeri gli danno ragione: sui 1112 pazienti arrivati nel 2016 al centro multidisciplinare, con una crescita dell 8% sull anno precedente, 888 avevano avuto a che fare con il cyberbullismo. “Avevo provato a iscrivermi a Facebook e Instagram ma poi mi sono cancellato perché non mi sentivo sicuro”, confida un ragazzo. “Servono regole e controlli - dice ancora il dottor Bernardo -. Sotto i 14 anni nessuno dovrebbe usare WhatsApp. E  una realtà pericolosa che i giovani non sanno affrontare da soli. Hanno bisogno di una rete composta soprattutto dalla famiglia e dagli insegnanti”. Ma che cosa induce un giovane a comportarsi da bullo? E, di contro, come si diventa vittima? In entrambi i casi incide l autostima. Il bullo mostra un alta opinione di sé, combinata a narcisismo e manie di grandezza, ma spesso non si sente realmente così e usa l aggressività per emergere nel gruppo. In genere ha una bassa tolleranza delle frustrazioni. “Le storie dei bullizzati - scrive invece Camilla Colombo su La Stampa -, si somigliano un po  tutte. Zero fiducia negli amici, pochi, pochissimi quelli veri, scarsa autostima e difficoltà a esprimere le emozioni. C è chi si nasconde in casa, chi rifiuta i contatti, chi mangia di tutto, chi diventa anoressico e chi si fa male da solo. Nei casi più estremi si arriva fino al suicido». Diversi studi hanno inoltre dimostrato che nel passaggio dall adolescenza all età adulta le vittime di bullismo possono presentare disturbi quali agorafobia, ansia, attacchi di panico, psicosi e depressione. In alcuni casi gli stessi disturbi colpiscono anche chi è stato bullo. Ma è possibile prevenire? “Certamente sì - dice la psicoterapeuta Maura Manca - il ruolo educativo di insegnanti e genitori può fare la differenza”. Le terapie per recuperare bulli e bullizzati le spiega il professor Bernardo: “Fondamentale - dice - è far comprendere come gestire le emozioni. Rari i casi in cui si interviene a livello farmacologico: la relazione umana è il punto di partenza. Il cammino che i ragazzi affrontano una volta arrivati nel nostro centro, o perché costretti dalle forze dell ordine o perché aiutati da genitori e insegnanti, è sempre lo stesso, e varia nella sua durata a seconda dei casi. Prima uno screening del pediatra, poi 6/12 mesi di percorso psicologico, quindi attività che insegnino ai giovani a stare insieme parlando. Il nuovo progetto consiste in un uscita in barca, ma organizziamo anche corsi di musica, pittura e autodifesa. La terapia dura da sei mesi a un anno. La differenza di percorso terapeutico tra chi è un bullo e chi è una vittima sta da un altra parte, in quello che si deve imparare a gestire. Nel caso di chi commette violenza è necessario capire come incanalare la rabbia e apprendere il rispetto degli altri. Per chi è stato preso di mira dalla violenza altrui il compito è superare l infinito senso di colpa, difficile da esprimere a parole”.',
      author: 'Enrico Caporale',
      authorImageUrl:
          'https://blog.geografia.deascuola.it/uploads/2016/02/Enrico.Caporale_ae1b7def40a1336cf07247b43d7ca1d9.jpeg',
      category: 'Bullismo',
      secondImageUrl:
          'https://www.focus.it/site_stored/imgs/0006/013/shutterstock_309238307.1020x680.jpg',
      imageUrl:
          'https://psicologinews.it/wp-content/uploads/2021/04/rsz_computer-5777377_1280.png',
      createdAt: DateTime.now().subtract(const Duration(hours: 7)),
    ),
    Article(
      id: '5',
      title: 'Flaming',
      subtitle: 'Storie di bullismo on line',
      body:
          "'Il Flaming è l offesa, pura e semplice, fatta sui social pubblici e spesso volgare, magari scritta tra i commenti del tuo diario di Facebook o in un forum, un gruppo di discussione online. Il cyberbullo, in questo caso, cerca di tapparti la bocca ricoprendoti di insulti, magari per far ridere… gli altri. La seguente storia prende spunto dal libro Cyberbulli al tappeto, dove Teo Benedetti e Davide Morosinotto trattano il tema del cyberbullismo rivolgendosi direttamente ai ragazzi. Flaming, Harassment, Denigration, Impersonation, Outing, Trickery, Exclusion e Cyberstalking: dietro a questi nomi altisonanti si celano situazioni quotidiane molto diffuse che potrebbero capitare a qualsiasi ragazzo di oggi. La storia Paolo è molto sensibile alle tematiche per la salvaguardia dell'ambiente. Da tempo, sulla sua pagina Facebook condivide articoli, foto e filmati che, a suo parere, dovrebbero scuotere la coscienza di tutti. E, a modo suo, qualche effetto lo ottiene. I compagni di scuola ogni tanto ironizzano, ma il più delle volte si limitano a commentare con un 'Bravo! Così si fa!''. Lo stesso vale per gli amici di famiglia, che apprezzano il suo impegno. Paolo ha scelto inoltre di condividere tutti i post in forma pubblica per attirare più gente, ma nessun contatto sconosciuto ha mai commentato. Una sera, però, sotto un nuovo articolo anti-inquinamento, si presenta a sorpresa un utente chiamato Max Turbo. Il primo commento è una lunga sequenza di offese che niente hanno a che vedere con l'articolo. Paolo decide di non rispondere: lo farà qualcuno dei suoi contatti per lui. Nessuno invece interviene, e Max Turbo continua a commentare aumentando la creatività delle sue offese. A peggiorare le cose, un paio di suoi compagni di scuola commentano divertiti per lo 'stile' dello sconosciuto attaccabrighe. A quel punto, Paolo decide di rispondere e lo fa in un primo momento con calma e diplomazia, invitando l'utente a non dire parolacce. E ottiene l'effetto contrario: Max Turbo ora se la prende direttamente con Paolo. E il ragazzo perde la pazienza e inizia a rispondergli per le rime. I commenti diventano decine e decine. Talvolta qualcuno prova a intervenire per riportare la calma, ma inutilmente, e intanto aumentano i tifosi di entrambi i contendenti. C'è chi li sprona a osare di più e chi si schiera da una delle due parti. Il giorno dopo, il post contiene oltre settecento commenti. Paolo li rilegge tutti con una punta di rabbia e si promette solennemente che d'ora in avanti non posterà mai più nulla sui social, nemmeno quei bellissimi post per la salvaguardia della Terra per cui aveva speso tante energie.'",
      author: 'Davide Morosinotto',
      authorImageUrl:
          'https://maredilibri.it/festival//immagini/davide_morosinotto.jpg',
      category: 'Cyberbullismo',
      secondImageUrl:
          'https://www.editorialescienza.it/images/gge-images/cyberbulli/cyberbulli-flaming-1200x600.jpg',
      imageUrl:
          'https://icgonars.edu.it/wp-content/uploads/sites/282/cyberbull.jpg',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
  ];

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        body,
        author,
        authorImageUrl,
        category,
        imageUrl,
        secondImageUrl,
        createdAt,
      ];
}
