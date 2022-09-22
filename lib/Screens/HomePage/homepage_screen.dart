import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/HomePage/components/body.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //Estraggo tutte le informazioni dell'utente loggato
    readInformationWithId(idUtente);
    return Scaffold(
      body: Body(),
    );
  }
}
