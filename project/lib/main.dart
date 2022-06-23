//import 'dart:html';
//import 'package:mysql1/mysql1.dart';

import 'package:flutter/material.dart';

import 'package:mysql_flutter/logic/models/mysql.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progetto Flutter',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Provo a stampare e-mail utente'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var db = new Mysql();
  var EmailUtente = '';
  var NomeUtente = '';
  var PasswordUtente = '';
  Future<void> _getCustomer() async {
    db.getConnection().then((conn) {
      String sql =
          'SELECT NomeUtente,PasswordUtente,EmailUtente FROM databaseappflutter.utenti;';
      conn.query(sql).then((results) {
        for (var row in results) {
          setState(() {
            EmailUtente = row[2];
            NomeUtente = row[0];
            PasswordUtente = row[1];
          });
        }
      });
      conn.close();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Questi sono i tuoi dati :',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              'Email: '
              '$EmailUtente',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              'Password: '
              '$PasswordUtente',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              'Utente: '
              '$NomeUtente',
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCustomer,
        tooltip: 'Visualizza Dati',
        child: Icon(Icons.add),
      ),
    );
  }
}
