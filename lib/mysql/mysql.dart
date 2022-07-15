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
        // ho una diversa password del db non cancellate grazie gg
        //password: 'rootroot',
        db: 'databaseappflutter');
    return MySqlConnection.connect(settings);
  }
}
