import 'dart:async';
import 'package:mysql1/mysql1.dart';

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
  db.getConnection().then((connessione) {
    connessione.query(query);
    connessione.close();
  });
}

//Funzione per controllare l'esistenza della mail
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
  connessione.close();
  //True = Query vuota -> Non ho la mail
  //False = Query con valore di ritorno -> Email già presente
  return result.isEmpty;
}

//Funzione per controllare l'esistenza della mail
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
