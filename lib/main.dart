import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Info/article_screen.dart';
import 'package:human_variable_behaviour/Screens/Login/login_screen.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';

void main() {
  Mysql();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  //Main widget
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Titolo applicazione
      title: 'Human Variable Behaviour',
      //Disattivo il debug
      debugShowCheckedModeBanner: false,
      routes: {
        ArticleScreen.routeName: (context) => const ArticleScreen(),
      },
      //Pagina di Login
      home: const LoginScreen(),
    );
  }
}
