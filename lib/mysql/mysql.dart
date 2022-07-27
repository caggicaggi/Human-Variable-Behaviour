// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Diario/components/MyEvents.dart';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';

<<<<<<< HEAD
import '../Screens/Login/components/body.dart';

=======
>>>>>>> 1a79610d046acd415481c368f2bbde31779e1350
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
        //password: 'root',
        //Database mala
        password: 'rootroot',
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
<<<<<<< HEAD

  db.getConnection().then((connessione) async {
    await Future.delayed(const Duration(seconds: 2));
=======
  db.getConnection().then((connessione) async {
>>>>>>> 1a79610d046acd415481c368f2bbde31779e1350
    //Inserisco le info nel database
    connessione.query(query);
    //Leggo l'idUtente appena assegnato
    String queryToId =
<<<<<<< HEAD
        'select idutente FROM ' + table + ' WHERE email = ' + emailToDb;
    print(queryToId);
    await connessione.query(queryToId).then((results) {
      for (var res in results) {
        idUtente = res[0].toString();
        debugPrint(idUtente);
      }
    });
    await Future.delayed(const Duration(seconds: 2));
=======
        'select idUtente FROM ' + table + ' WHERE email = ' + emailToDb;
    await connessione.query(queryToId).then((results) {
      for (var res in results) {
        idUtente = res[0].toString();
      }
    });
>>>>>>> 1a79610d046acd415481c368f2bbde31779e1350
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
<<<<<<< HEAD
  db.getConnection().then((connessione) async {
    await Future.delayed(const Duration(seconds: 2));
    //Inserisco le info nel database
    connessione.query(query);
    //Leggo l'idUtente appena assegnato
    String queryToId =
        'select idutente FROM ' + table + ' WHERE email = ' + emailToReadToDb;
    print(queryToId);
    await connessione.query(queryToId).then((results) {
      for (var res in results) {
        idUtente = res[0].toString();
        debugPrint(idUtente);
      }
    });
    await Future.delayed(const Duration(seconds: 2));
    connessione.close();
=======
  //Leggo l'idUtente ottenuto dal login
  String queryToId =
      'select idUtente FROM ' + table + ' WHERE email = ' + emailToReadToDb;
  await connessione.query(queryToId).then((results) {
    for (var res in results) {
      idUtente = res[0].toString();
    }
>>>>>>> 1a79610d046acd415481c368f2bbde31779e1350
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

//funzione per inserire giornata utente
void signDataAndGiornata(
    idutente, dataGiornata, titoloGiornata, descrizioneGiornata) {
  //Aggiungo i '' a tutte le stringhe passate in input
  idutente = idutente;
  titoloGiornata = stringToDb(titoloGiornata);
  descrizioneGiornata = stringToDb(descrizioneGiornata);
  dataGiornata = dataGiornata.toLocal();
  dataGiornata = DateFormat('yyyy-MM-dd').format(dataGiornata);
  print(dataGiornata);
  //Nome della tabella
  String table = 'diarioUtente';
  //Scrivo la query
  // ignore: prefer_interpolation_to_compose_strings
  String query =
      '${'INSERT INTO ' + table + ' (idutente,dataGiornata, titoloGiornata, descrizioneGiornata) VALUES (' + idutente + ',' + "'" + dataGiornata + "'" + ',' + titoloGiornata + ',' + descrizioneGiornata})';
  //Connessione al database
  debugPrint(query);
  var db = Mysql();
  db.getConnection().then((connessione) {
    connessione.query(query);
    connessione.close();
  });
}

// metodo invocato quando si clicca sulla data del calendario
List<MyEvents> listaGiornateInserite(DateTime? selectedCalendarDate, idutente) {
  List<MyEvents> list = [];
  //print("VARIABILI:::::::::::::::::::");
  //print(selectedCalendarDate?.toLocal());
  // FARE QUERY PER IDUTENTE E ORARIO CHE RITORNA LISTA
// Here the List should be returned, but after my Function fills it.
  return list;
}

//Funzione per aggiungere i '' alle stringhe passate in input
String stringToDb(stringToConvert) => '"' + stringToConvert + '"';
