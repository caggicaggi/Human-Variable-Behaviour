import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/pages/quiz_page.dart.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_image/pages/score_page.dart.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "INDOVINA LE IMMAGINI",
          style: TextStyle(fontFamily: "Pacifico", fontSize: 20),
        ),
        backgroundColor: Colors.blue,
        elevation: 0.1,
        centerTitle: true,
      ),
      backgroundColor: Colors.blue,
      body: InkWell(
        onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => QuizPagina())),
        child: Stack(
          children: <Widget>[
            Image.asset(
              "assets/images/sfondo_games.png",
              fit: BoxFit.fitHeight,
              width: size.width,
              height: size.height,
            ),
            Image.asset(
              "assets/images/logoUnicam.jpg",
              fit: BoxFit.fitHeight,
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => QuizPagina()));
                      },
                      child: Text(
                        "PREMI OVUNQUE PER INIZIARE",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      )),
                  Padding(padding: EdgeInsets.all(size.height * 0.029)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
