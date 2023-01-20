// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';

//Da rivedere

//Variabili per utilizzo del programma
var idUtente = '';
var nome = '';
var cognome = '';
var email = '';
var password = '';
var variabile = 0;
String avatarStr = '';

var IstitutoFrequentato = '';
var Passione = '';
var MusicaPreferita = '';
var SportPreferito = '';
var ArtistaPreferito = '';
var MateriaPreferita = '';
var Eta = '';
var Percentuale_Impiccato = '';
var Percentuale_Quiz = '';
var Percentuale_Immagini = '';

String rispostaCorretta = '';
String rispostaErrata1 = '';
String rispostaErrata2 = '';
String rispostaErrata3 = '';

int newVariabile = 0;

List<String> list = [];

bool check = false;
bool risultatoQueryDomande = true;

//Oggetto Mysql
class Mysql {
  //Costruttore
  Mysql();
  Future<MySqlConnection> getConnection() async {
    //Dati per la connessione al database
    var settings = ConnectionSettings(
        host: '10.0.2.2',
        port: 3306,
        user: 'root',
        password: 'root',
        db: 'databaseappflutter');
    return MySqlConnection.connect(settings);
  }
}

//Funzione per aggiungere i '' alle stringhe passate in input
String stringToDb(stringToConvert) => '"' + stringToConvert + '"';

//Funzione per registrare l'utente nel database (Registrazione classica)
Future signUpToDb(nameToDb, surnameToDb, emailToDb, passwordToDb) async {
  //Aggiungo i '' a tutte le stringhe passate in input
  nameToDb = stringToDb(nameToDb);
  surnameToDb = stringToDb(surnameToDb);
  emailToDb = stringToDb(emailToDb);
  passwordToDb = stringToDb(passwordToDb);

  //Nome della tabella
  String table = 'utenti';
  //Scrivo la query
  String query = 'INSERT INTO ' +
      table +
      ' (nome, cognome, email, password ,variabile, IstitutoFrequentato , Eta, Passione , SportPreferito , MusicaPreferita, ArtistaPreferito, MateriaPreferita,Tentativi_Totali_Impiccato,Tentativi_Riusciti_Impiccato,Tentativi_Totali_Quiz,Tentativi_Riusciti_Quiz,Tentativi_Totali_Immagini,Tentativi_Riusciti_Immagini) VALUES (' +
      nameToDb +
      ',' +
      surnameToDb +
      ',' +
      emailToDb +
      ',' +
      passwordToDb +
      ',' +
      '50' +
      ',' +
      "'Non hai inserito alcuna descrizione'" +
      ',' +
      '1' +
      ',' +
      "'Non hai inserito alcuna descrizione'" +
      ',' +
      "'Non hai inserito alcuna descrizione'" +
      ',' +
      "'Non hai inserito alcuna descrizione'" +
      ',' +
      "'Non hai inserito alcuna descrizione'" +
      ',' +
      "'Non hai inserito alcuna descrizione'" +
      ',' +
      "0" +
      ',' +
      "0" +
      ',' +
      "0" +
      ',' +
      "0" +
      ',' +
      "0" +
      ',' +
      "0" +
      ')';

  //Connessione al database
  var db = Mysql();
  await db.getConnection().then((connessione) async {
    await Future.delayed(const Duration(milliseconds: 1));
    await connessione.query(query).then((result) async {
      //Leggo l'idUtente appena assegnato
      String queryToId =
          'select idUtente FROM ' + table + ' WHERE email = ' + emailToDb;
      await connessione.query(queryToId).then((results) {
        for (var res in results) {
          idUtente = res[0].toString();
        }
        connessione.close();
      });
    });
    connessione.close();
  });
}

//Funzione per registrare l'utente nel database (Registrazione Google)
Future signUpToDbGoogle(nameSurnameToDb, emailToDb) async {
  //Devo fare lo split, poichè il nome e il cognome sono contenuti nella stessa variabile
  List<String> nameSurnameSplitted = nameSurnameToDb.split(' ');
  //Aggiungo i '' a tutte le stringhe passate in input
  String nameToDb = stringToDb(nameSurnameSplitted[0]);
  String surnameToDb = stringToDb(nameSurnameSplitted[1]);
  emailToDb = stringToDb(emailToDb);
  //Nome della tabella
  String table = 'utenti';
  //Scrivo la query
  String query = 'INSERT INTO ' +
      table +
      ' (nome, cognome, email, variabile, IstitutoFrequentato , Eta, Passione , SportPreferito , MusicaPreferita, ArtistaPreferito, MateriaPreferita,Tentativi_Totali_Impiccato,Tentativi_Riusciti_Impiccato,Tentativi_Totali_Quiz,Tentativi_Riusciti_Quiz,Tentativi_Totali_Immagini,Tentativi_Riusciti_Immagini) VALUES (' +
      nameToDb +
      ',' +
      surnameToDb +
      ',' +
      emailToDb +
      ',' +
      '50' +
      ',' +
      "'Non hai inserito alcuna descrizione'" +
      ',' +
      '1' +
      ',' +
      "'Non hai inserito alcuna descrizione'" +
      ',' +
      "'Non hai inserito alcuna descrizione'" +
      ',' +
      "'Non hai inserito alcuna descrizione'" +
      ',' +
      "'Non hai inserito alcuna descrizione'" +
      ',' +
      "'Non hai inserito alcuna descrizione'" +
      ',' +
      "0" +
      ',' +
      "0" +
      ',' +
      "0" +
      ',' +
      "0" +
      ',' +
      "0" +
      ',' +
      "0" +
      ')';
  //Connessione al database
  var db = Mysql();
  await db.getConnection().then((connessione) async {
    await Future.delayed(const Duration(milliseconds: 1));
    await connessione.query(query).then((result) async {
      //Leggo l'idUtente appena assegnato
      String queryToId =
          'select idUtente FROM ' + table + ' WHERE email = ' + emailToDb;
      await connessione.query(queryToId).then((results) {
        for (var res in results) {
          idUtente = res[0].toString();
        }
        connessione.close();
      });
    });
    connessione.close();
  });
}

//Funzione per controllare l'esistenza della mail e password durante il login
Future<bool> readEmailPasswordFromDb(emailToReadToDb, passwordToDb) async {
  //Aggiungo i '' a tutte le stringhe passate in input
  emailToReadToDb = stringToDb(emailToReadToDb);
  passwordToDb = stringToDb(passwordToDb);
  //Nome della tabella
  String table = 'utenti';
  //Scrivo la query
  String query = 'SELECT distinct email FROM ' +
      table +
      ' where email = ' +
      emailToReadToDb +
      'and password = ' +
      passwordToDb;
  //Connessione al database
  var db = Mysql();
  bool risultatoQuery = true;
  await db.getConnection().then((connessione) async {
    //delay obbligatorio per Malaccari
    await Future.delayed(const Duration(milliseconds: 1));
    await connessione.query(query).then((result) async {
      //Leggo l'idUtente appena assegnato
      String queryToId =
          'select idUtente FROM ' + table + ' WHERE email = ' + emailToReadToDb;
      await connessione.query(queryToId).then((results) {
        for (var res in results) {
          idUtente = res[0].toString();
        }
        connessione.close();
      });
      risultatoQuery = result.isEmpty;
    });
    connessione.close();
  });
  //True = Query vuota -> Non ho la mail
  //False = Query con valore di ritorno -> Email già presente
  return risultatoQuery;
}

//Funzione per controllare l'esistenza della mail durante il login
Future<bool> readEmailFromDb(emailToReadToDb) async {
  //Aggiungo i '' a tutte le stringhe passate in input
  emailToReadToDb = stringToDb(emailToReadToDb);
  //Nome della tabella
  String table = 'utenti';
  //Scrivo la query
  String query = 'SELECT distinct email FROM ' +
      table +
      ' where email = ' +
      emailToReadToDb;
  //Connessione al database
  var db = Mysql();
  bool risultatoQuery = true;
  await db.getConnection().then((connessione) async {
    //delay obbligatorio per Malaccari
    await Future.delayed(const Duration(milliseconds: 1));
    await connessione.query(query).then((result) async {
      //Leggo l'idUtente appena assegnato
      String queryToId =
          'select idUtente FROM ' + table + ' WHERE email = ' + emailToReadToDb;
      await connessione.query(queryToId).then((results) {
        for (var res in results) {
          idUtente = res[0].toString();
        }
        connessione.close();
      });
      risultatoQuery = result.isEmpty;
    });
    connessione.close();
  });
  //True = Query vuota -> Non ho la mail
  //False = Query con valore di ritorno -> Email già presente
  return risultatoQuery;
}

//DA RIVEDERE

//-----------RICONTROLLARE-----------

//Funzione per ottenere nome e cognome dall'idUtente
//Il metodo va messo Future perchè così se richiamato si può utilizzare l'await
/*Future<void> getNameSurnameFromId() async {
  //Nome della tabella
  String table = 'utenti';
  //Scrivo la query
  String query =
      'SELECT nome, cognome FROM ' + table + ' where idUtente = ' + idUtente;
  //Connessione al database
  var db = Mysql();
  await db.getConnection().then((connessione) async {
    //Delay aggiuntivo
    await Future.delayed(const Duration(milliseconds: 1));
    await connessione.query(query).then((results) async {
      for (var res in results) {
        nome = res[0].toString();
        cognome = res[1].toString();
      }
      connessione.close();
    });
  });
} */

/*
I metodi precedenti sono stati corretti e testati, ho aggiunto:
Future per poter utilizzare l'await quando richiamati nell'app
Così facendo il programma procede solo nel momento in qui il metodo finisce
senza quest'impostazione non saremo mai sincronizzati col databas
*/

//Metodi Malaccari, da rivedere

//FUNZIONE PER INSERIRE LA GIORNATA
Future<void> signDataAndGiornata(
    idutente, dataGiornata, descrizioneGiornata) async {
  dataGiornata = dataGiornata.toLocal();
  dataGiornata = DateFormat('yyyy-MM-dd').format(dataGiornata);
  //Nome della tabella
  String table = 'diarioUtente';
  //Scrivo la query
  String query =
      '${'INSERT INTO ' + table + ' (idUtente,dataGiornata, descrizioneGiornata) VALUES (' + idutente + ',' + "'" + dataGiornata + "'" + ',' + "'" + descrizioneGiornata + "'"})';
  //Connessione al database
  var db = Mysql();
  //eseguo query
  db.getConnection().then((connessione) {
    connessione.query(query);
    connessione.close();
  });
}

// OTTENGO LISTA EVENTI INSERITI
Future<List<String>> listaGiornateInserite(dataGiornata, idUtente) async {
  //dichiaro variabili
  List<String> list1 = [];
  int controllo = 0;
  int parolaDoppia = 0;
  List<String> controlloInserimento = [];
  dataGiornata = dataGiornata.toLocal();
  dataGiornata = DateFormat('yyyy-MM-dd').format(dataGiornata);
  dataGiornata = stringToDb(dataGiornata);
  //nome della tabella
  String table = 'diarioUtente';
  //compongo query
  String query = 'SELECT descrizioneGiornata FROM ' +
      table +
      ' where dataGiornata = ' +
      dataGiornata +
      ' AND idUtente = ' +
      idUtente;
  //connessione al db
  var db = Mysql();
  var connessione = await db.getConnection();
  //delay obbligatorio per Malaccari
  await Future.delayed(const Duration(milliseconds: 2));
  //eseguo query e salvo il risultato in result
  var result = await connessione.query(query);
  if (result.isNotEmpty) {
    controlloInserimento.add(result.toString());
    //controllo per verificare se c'è una parola doppia
    for (int i = 0; i <= list.length - 1; i++) {
      for (int j = 0; j <= controlloInserimento.length - 1; j++) {
        if (controlloInserimento[j] == list[i]) {
          parolaDoppia++;
        }
      }
    }
    if (parolaDoppia > 0) {
      controllo = 2;
    }

    if (controllo == 2) {
      for (int i = 0; i < list.length - 1; i++) {
        list[i] = result.toString();
      }
      connessione.close();
      return list1;
    } else {
      //pulisco lista
      list.clear();
      for (var res in result) {
        //aggiungo elementi alla lista
        list.add(res[0].toString());
        list1.add(result.toString());
      }
      connessione.close();
    }
  } else {
    list.clear();
    list.add("Non hai inserito nessuna descrizione in questa data");
  }
  //chiudo connessione
  connessione.close();
  return list1;
}

//INSERISCO DOMANDA E RISPOSTA UTENTE
Future<void> signDomandaERisposta(
    idutente, domandaUtente, rispostaDomanda) async {
  //Nome della tabella
  String table = 'domandeUtente';
  //Scrivo la query
  String query =
      '${'INSERT INTO ' + table + '(idUtenteDomanda,domandaUtente, rispostaDomanda) VALUES (' + idutente + ',' + "'" + domandaUtente + "'" + ',' + "'" + rispostaDomanda + "'"})';
  var db = Mysql();
  //eseguo query
  await db.getConnection().then((connessione) {
    connessione.query(query);
    connessione.close();
  });
}

//INSERISCO LA DOMANDA
Future<void> updateDomandaCorretta(
    idutente, domandaUtente, rispostaDomanda) async {
  //Nome della tabella
  String table = 'domandeUtente';
  //Scrivo la query
  String query = 'Update ' +
      table +
      ' SET rispostaDomanda = ' +
      "'" +
      rispostaDomanda +
      "'" +
      'WHERE domandaUtente =' +
      "'" +
      domandaUtente +
      "'";
  var db = Mysql();
  //eseguo query
  await db.getConnection().then((connessione) {
    connessione.query(query);
    connessione.close();
  });
}

//Funzione per controllare se la domanda è gia presente
//Il metodo va messo Future perchè così se richiamato si può utilizzare l'await
Future<bool> readQuestions(domandaUtente) async {
  //Aggiungo i '' a tutte le stringhe passate in input
  domandaUtente = stringToDb(domandaUtente);
  //Nome della tabella
  String table = 'domandeUtente';
  //Scrivo la query
  String query = 'SELECT distinct domandaUtente FROM ' +
      table +
      ' where domandaUtente = ' +
      domandaUtente;
  //Connessione al database
  var db = Mysql();
  await db.getConnection().then((connessione) async {
    await Future.delayed(const Duration(milliseconds: 1));
    await connessione.query(query).then((result) async {
      risultatoQueryDomande = result.isEmpty;
      connessione.close();
    });
  });
  //True = Query vuota -> Non ho la domanda inserita e faccio l'insert
  //False = Query con valore di ritorno -> La domanda è gia inserita e faccio update
  return risultatoQueryDomande;
}

//RICHIAMO TUTTE LE INFORMAZIONI DEL PROFILO TRAMITE L'IDUTENTE
Future<void> readInformationWithId(idUtente) async {
  //Nome della tabella
  String table = 'utenti';
  //Scrivo la query
  String query =
      'SELECT nome,cognome,email,password,Eta,MusicaPreferita,IstitutoFrequentato,Passione,SportPreferito,ArtistaPreferito,MateriaPreferita, ' +
          'Tentativi_Totali_Impiccato,Tentativi_Riusciti_Impiccato,Tentativi_Totali_Quiz,Tentativi_Riusciti_Quiz,Tentativi_Totali_Immagini,Tentativi_Riusciti_Immagini,VARIABILE,avatarStr FROM ' +
          table +
          ' where idUtente = ' +
          idUtente;

  //Connessione al database
  var db = Mysql();
  await db.getConnection().then((connessione) async {
    await connessione.query(query).then((result) async {
      for (var res in result) {
        nome = res[0].toString();
        cognome = res[1].toString();
        email = res[2].toString();
        password = res[3].toString();
        Eta = res[4].toString();
        MusicaPreferita = res[5].toString();
        IstitutoFrequentato = res[6].toString();
        Passione = res[7].toString();
        SportPreferito = res[8].toString();
        ArtistaPreferito = res[9].toString();
        MateriaPreferita = res[10].toString();
        //Carico le percentuali dei giochi
        if (res[12] == 0 && res[11] == 0) {
          Percentuale_Impiccato = 0.toString();
        } else {
          Percentuale_Impiccato = (res[12] / res[11]).toString();
        }
        if (res[14] == 0 && res[13] == 0) {
          Percentuale_Quiz = 0.toString();
        } else {
          Percentuale_Quiz = (res[14] / res[13]).toString();
        }
        if (res[16] == 0 && res[15] == 0) {
          Percentuale_Immagini = 0.toString();
        } else {
          Percentuale_Immagini = (res[16] / res[15]).toString();
        }

        variabile = res[17];
        avatarStr = res[18].toString();
      }
      connessione.close();
    });
  });
  return;
}

//RICHIAMO LA RISPOSTA CORRETTA ALLA DOMANDA
String getRispostaCorretta(domanda) {
  domanda = stringToDb(domanda);
  String check = '';
  //Nome della tabella
  String table = 'listaDomande';
  //Scrivo la query
  String query =
      'SELECT rispostaCorretta FROM ' + table + ' where Domanda = ' + domanda;
  //Connessione al database
  var db = Mysql();
  db.getConnection().then((connessione) async {
    //delay obbligatorio per Malaccari
    await Future.delayed(const Duration(milliseconds: 1));
    await connessione.query(query).then((result) async {
      for (var res in result) {
        rispostaCorretta = res[0].toString();
      }
      connessione.close();
    });
  });

  return check;
}

//RICHIAMO LA RISPOSTA ERRATA NUMERO 1
String getRispostaErrata1(domanda) {
  domanda = stringToDb(domanda);
  String check = '';
  //Nome della tabella
  String table = 'listaDomande';
  //Scrivo la query
  String query =
      'SELECT rispostaErrata1 FROM ' + table + ' where Domanda = ' + domanda;
  //Connessione al database
  var db = Mysql();
  db.getConnection().then((connessione) async {
    //delay obbligatorio per Malaccari
    await Future.delayed(const Duration(milliseconds: 1));
    await connessione.query(query).then((result) async {
      for (var res in result) {
        rispostaErrata1 = res[0].toString();
      }
      connessione.close();
    });
  });
  return check;
}

//RICHIAMO LA RISPOSTA ERRATA NUMERO 2
String getRispostaErrata2(domanda) {
  domanda = stringToDb(domanda);
  String check = '';
  //Nome della tabella
  String table = 'listaDomande';
  //Scrivo la query
  String query =
      'SELECT rispostaErrata2 FROM ' + table + ' where Domanda = ' + domanda;
  //Connessione al database
  var db = Mysql();
  db.getConnection().then((connessione) async {
    //delay obbligatorio per Malaccari
    await Future.delayed(const Duration(milliseconds: 1));
    await connessione.query(query).then((result) async {
      for (var res in result) {
        rispostaErrata2 = res[0].toString();
      }
      connessione.close();
    });
  });
  return check;
}

//RICHIAMO LA RISPOSTA ERRATA NUMERO 3
String getRispostaErrata3(domanda) {
  domanda = stringToDb(domanda);
  String check = '';
  //Nome della tabella
  String table = 'listaDomande';
  //Scrivo la query
  String query =
      'SELECT rispostaErrata3 FROM ' + table + ' where Domanda = ' + domanda;
  //Connessione al database
  var db = Mysql();
  db.getConnection().then((connessione) async {
    //delay obbligatorio per Malaccari
    await Future.delayed(const Duration(milliseconds: 1));
    await connessione.query(query).then((result) async {
      for (var res in result) {
        rispostaErrata3 = res[0].toString();
      }
      connessione.close();
    });
  });
  return check;
}

//RICHIAMO LA VARIABILE DELL'UTENTE
Future<void> getVariabile() async {
  //Nome della tabella
  String table = 'utenti';
  //Scrivo la query
  String query =
      'SELECT VARIABILE FROM ' + table + ' where idUtente = ' + idUtente;
  //Connessione al database
  var db = Mysql();

  await db.getConnection().then((connessione) async {
    await connessione.query(query).then((result) async {
      for (var res in result) {
        variabile = res[0];
      }
      connessione.close();
    });
  });
}

//AGGIORNO LA VARIABILE A SECONDA DELLA RISPOSTA (IN QUESTO CASO CORRETTA --> RISPOSTA +4 )
//AGGIORNO LA VARIABILE A SECONDA DELLA RISPOSTA (IN QUESTO CASO -1 --> RISPOSTA 1 )
//AGGIORNA LA VARIABILE A SECONDA DELLA RISPOSTA (IN QUESTO CASO -2 --> RISPOSTA 2 )
//AGGIORNA LA VARIABILE A SECONDA DELLA RISPOSTA (IN QUESTO CASO -3 --> RISPOSTA 3 )
Future<void> updateVariable(idUtente, valoreDaValutare) async {
  //Nome della tabella
  String table = 'utenti';
  var newVariabile = variabile + valoreDaValutare;
  //Il valore della variabile non può superare 100
  if (newVariabile >= 100) {
    newVariabile = 100;
  }
  String query = 'Update ' +
      table +
      ' SET VARIABILE = ' +
      "'" +
      newVariabile.toString() +
      "'" +
      'WHERE idUtente =' +
      "'" +
      idUtente +
      "'";
  var db = Mysql();
  await db.getConnection().then((connessione) async {
    await connessione.query(query).then((value) => connessione.close());
  });
}

//METODO PER INSERIMENTO DATI PERSONALI
Future<void> signUpToDbInf(
    nome,
    cognome,
    email,
    IstitutoFrequentato,
    Eta,
    Passione,
    SportPreferito,
    MusicaPreferita,
    ArtistaPreferito,
    MateriaPreferita) async {
  nome = stringToDb(nome);
  cognome = stringToDb(cognome);
  email = stringToDb(email);
  IstitutoFrequentato = stringToDb(IstitutoFrequentato);
  Eta = stringToDb(Eta);
  Passione = stringToDb(Passione);
  SportPreferito = stringToDb(SportPreferito);
  MusicaPreferita = stringToDb(MusicaPreferita);
  ArtistaPreferito = stringToDb(ArtistaPreferito);
  MateriaPreferita = stringToDb(MateriaPreferita);

  //Nome della tabella
  String table = 'utenti';
  //Scrivo la query
  //UPDATE Users SET weight = 160, desiredWeight = 145 WHERE id = 1;

  String query = 'UPDATE ' +
      table +
      ' SET' +
      " nome = " +
      nome +
      ',' +
      "cognome = " +
      cognome +
      ',' +
      "email = " +
      email +
      ',' +
      "IstitutoFrequentato = " +
      IstitutoFrequentato +
      ',' +
      "Eta = " +
      Eta +
      ',' +
      "Passione = " +
      Passione +
      ',' +
      "SportPreferito = " +
      SportPreferito +
      ',' +
      "MusicaPreferita = " +
      MusicaPreferita +
      ',' +
      "ArtistaPreferito = " +
      ArtistaPreferito +
      ',' +
      "MateriaPreferita = " +
      MateriaPreferita +
      'WHERE idUtente = ' +
      idUtente +
      ";";

  var db = Mysql();
  //eseguo query
  await db.getConnection().then((connessione) {
    connessione.query(query);
    connessione.close();
  });
}

String domanda1 = '';
String domanda2 = '';
String domanda3 = '';
String domanda4 = '';

//Metodo per ottenere la domanda dato l'id
Future<String> getQuestionFromId(int id) async {
  var table = 'listadomande';
  //Connessione al database
  var db = Mysql();
  await db.getConnection().then((connessione) async {
    await Future.delayed(const Duration(milliseconds: 4));
    String query =
        'select domanda FROM ' + table + ' WHERE idDom = ' + id.toString();
    await connessione.query(query).then((result) async {
      //Leggo la domanda
      for (var res in result) {
        domanda1 = res[0].toString();
      }
      connessione.close();
    });
  });
  return '';
}

//METODO PER settare la stringa avatar
Future<void> setAvatarString(String id) async {
  //Nome della tabella
  String table = 'utenti';
  String rndStr = '123';
  //genero un numero casuale tra 0 e 9
  Random random = Random();
  int rndNum = random.nextInt(9) + 1;
  //genero una stringa casuale di lunghezza casuale
  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  rndStr = generateRandomString(rndNum);

  //Scrivo la query
  String query = " UPDATE " +
      table +
      " SET avatarStr = '" +
      rndStr +
      "'  WHERE idUtente = " +
      id.toString() +
      ' ;';

  var db = Mysql();
  //eseguo query
  await db.getConnection().then((connessione) {
    connessione.query(query);
    connessione.close();
  });
}

//Metodo per ottenere la stringa dell'avatar dato l'id
Future<void> getAvatarString(String id) async {
  var table = 'utenti';
  //Connessione al database
  var db = Mysql();
  await db.getConnection().then((connessione) async {
    await Future.delayed(const Duration(milliseconds: 4));
    String query =
        'SELECT avatarStr FROM ' + table + ' WHERE idUtente = ' + id.toString();
    await connessione.query(query).then((result) async {
      for (var res in result) {
        avatarStr = await res[0];
      }
      connessione.close();
    });
  });
}
