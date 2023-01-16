// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/body.dart';
import 'package:human_variable_behaviour/Screens/HomePage/homepage_screen.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/background.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';

class ResultPage extends StatelessWidget {
  ResultPage({
    Key? key,
    required this.score,
  }) : super(key: key);

  final int score;

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Column(
          //Allineo tutto al centro
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Center(
                    child: Text('Score: $score/${questions.length}',
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 32,
                            fontStyle: FontStyle.normal)),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),

            //Pulsante per tornare alla home page
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontStyle: FontStyle.normal),
              ),
              onPressed: () async {
                //Aggiorno i tentati riusciti
                if (score > 2) {
                  await addTryCorrect("Tentativi_Riusciti_Quiz");
                }
                await readInformationWithId(idUtente).then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePageScreen()));
                });
              },
              child: Text('Home Page'),
            ),
          ],
        ),
      ),
    );
  }
}
