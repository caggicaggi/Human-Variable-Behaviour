// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/body.dart';
import 'package:human_variable_behaviour/Screens/HomePage/homepage_screen.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/background.dart';

class ResultPage extends StatelessWidget {
  ResultPage({
    Key? key,
    required this.score,
  }) : super(key: key);

  final int score;

  @override
  Widget build(BuildContext context) {
    //Occupo tutto lo schermo sia in altezza che in lunghezza
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          //Allineo tutto al centro
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Spaziatura
            SizedBox(
              height: size.height * 0.05,
            ),
            Text(
              'Hai ottenuto un punteggio pari a : $score/${questions.length}',
              style: TextStyle(
                backgroundColor: Colors.blueAccent,
                fontSize: 15,
                foreground: Paint()
                  ..strokeWidth = 2
                  ..color = Colors.white,
              ),
            ),
            //Pulsante per tornare alla home page
            TextButton(
              onPressed: (() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePageScreen()));
              }),
              child: Text(
                'Home Page',
                style: TextStyle(
                  backgroundColor: Colors.blue,
                  fontSize: 20,
                  foreground: Paint()
                    ..strokeWidth = 2
                    ..color = Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
