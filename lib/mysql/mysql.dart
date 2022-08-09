// ignore_for_file: prefer_interpolation_to_compose_strings
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';

//Variabili per utilizzo del programma
var idUtente = '';
List<String> list = [];
bool check = false;

class Mysql {
  //Cotruttore
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

//Funzione per registrare l'utente nel database
//Il metodo va messo Future perchè così se richiamato si può utilizzare l'await
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
      ' (nome, cognome, email, password) VALUES (' +
      nameToDb +
      ',' +
      surnameToDb +
      ',' +
      emailToDb +
      ',' +
      passwordToDb +
      ')';
  //Connessione al database
  var db = Mysql();
  await db.getConnection().then((connessione) async {
    //Inserisco le info nel database
    connessione.query(query);
    //Leggo l'idUtente appena assegnato
    String queryToId =
        'select idUtente FROM ' + table + ' WHERE email = ' + emailToDb;
    await Future.delayed(const Duration(milliseconds: 5));
    await connessione.query(queryToId).then((results) {
      for (var res in results) {
        idUtente = res[0].toString();
        //debugPrint(idUtente);
      }
    });
    //debugPrint('Chiudo la connessione');
    connessione.close();
  });
}

//Funzione per controllare l'esistenza della mail e password durante il login
//Il metodo va messo Future perchè così se richiamato si può utilizzare l'await
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
    await Future.delayed(const Duration(milliseconds: 4));
    await connessione.query(query).then((result) async {
      //Leggo l'idUtente appena assegnato
      String queryToId =
          'select idUtente FROM ' + table + ' WHERE email = ' + emailToReadToDb;
      await connessione.query(queryToId).then((results) {
        for (var res in results) {
          idUtente = res[0].toString();
          debugPrint(idUtente);
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

//Funzione per controllare l'esistenza della mail durante la registrazione
//Il metodo va messo Future perchè così se richiamato si può utilizzare l'await
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
      risultatoQuery = result.isEmpty;
      connessione.close();
    });
  });
  //True = Query vuota -> Non ho la mail
  //False = Query con valore di ritorno -> Email già presente
  return risultatoQuery;
}

//Funzione per aggiungere i '' alle stringhe passate in input
String stringToDb(stringToConvert) => '"' + stringToConvert + '"';

/*
I metodi precedenti sono stati corretti e testati, ho aggiunto:
Future per poter utilizzare l'await quando richiamati nell'app
Così facendo il programma procede solo nel momento in qui il metodo finisce
senza quest'impostazione non saremo mai sincronizzati col databas
*/

//Metodi Malaccari, da rivedere

//funzione per inserire evento utente
void signDataAndGiornata(idutente, dataGiornata, descrizioneGiornata) {
  //Aggiungo i '' a tutte le stringhe passate in input
  idutente = idutente;
  descrizioneGiornata = descrizioneGiornata;
  dataGiornata = dataGiornata.toLocal();
  dataGiornata = DateFormat('yyyy-MM-dd').format(dataGiornata);
  //Nome della tabella
  String table = 'diarioUtente';
  //Scrivo la query
  String query =
      '${'INSERT INTO ' + table + ' (idUtente,dataGiornata, descrizioneGiornata) VALUES (' + idutente + ',' + "'" + dataGiornata + "'" + ',' + "'" + descrizioneGiornata + "'"})';
  //Connessione al database
  debugPrint(query);
  var db = Mysql();
  //eseguo query
  db.getConnection().then((connessione) {
    connessione.query(query);
    connessione.close();
  });
}

// metodo invocato per ottenere lista eventi
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
    connessione.close();
    return list1;
  } else {
    //pulisco lista
    list.clear();
    //aggiungo elementi alla lista
    list.add(result.toString());
    list1.add(result.toString());
    connessione.close();
  }
  //chiudo connessione
  connessione.close();
  return list1;
}
