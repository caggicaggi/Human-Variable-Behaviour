// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';
import 'package:mysql1/mysql1.dart';

var idUtente = '';

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
        //Database mala
        //password: 'rootroot',
        db: 'databaseappflutter');
    return MySqlConnection.connect(settings);
  }
}

//Funzione per registrare l'utente nel database
void signUpToDb(nameToDb, surnameToDb, emailToDb, passwordToDb) {
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
  db.getConnection().then((connessione) async {
    //Inserisco le info nel database
    connessione.query(query);
    //Leggo l'idUtente appena assegnato
    String queryToId =
        'select idUtente FROM ' + table + ' WHERE email = ' + emailToDb;
    await connessione.query(queryToId).then((results) {
      for (var res in results) {
        idUtente = res[0].toString();
      }
    });
    connessione.close();
  });
}

//Funzione per controllare l'esistenza della mail e password durante il login
Future<bool> readEmailPasswordFromDb(emailToReadToDb, passwordToDb) async {
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
  var connessione = await db.getConnection();
  //Aggiunti delay
  await Future.delayed(const Duration(milliseconds: 2));
  var result = await connessione.query(query);
  //Leggo l'idUtente ottenuto dal login
  String queryToId =
      'select idUtente FROM ' + table + ' WHERE email = ' + emailToReadToDb;
  await connessione.query(queryToId).then((results) {
    for (var res in results) {
      idUtente = res[0].toString();
    }
  });
  connessione.close();
  //True = Query vuota -> Non ho la mail
  //False = Query con valore di ritorno -> Email già presente
  return result.isEmpty;
}

//Funzione per controllare l'esistenza della mail durante la registrazione
Future<bool> readEmailFromDb(emailToReadToDb) async {
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
  var connessione = await db.getConnection();
  //Aggiunti delay
  await Future.delayed(const Duration(milliseconds: 2));
  var result = await connessione.query(query);
  connessione.close();
  //True = Query vuota -> Non ho la mail
  //False = Query con valore di ritorno -> Email già presente
  return result.isEmpty;
}

//Funzione per aggiungere i '' alle stringhe passate in input
String stringToDb(stringToConvert) => '"' + stringToConvert + '"';
