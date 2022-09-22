import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:human_variable_behaviour/Screens/Welcome/welcome_screen.dart';
import 'package:human_variable_behaviour/constant.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';

void main() {
  Mysql();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Human Variable Behaviour',
      debugShowCheckedModeBanner: false,
      //Stabilisce il tema dell'applicazione
      //Permette di scegliere i colori di tutti i widget che si utilizzeranno nell'app
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: kPrimaryColor,
          //Stabilisco il colore dello Scaffold
          scaffoldBackgroundColor: Colors.white),
      //Schermata inziale
      home: const WelcomeScreen(),
    );
  }
}
