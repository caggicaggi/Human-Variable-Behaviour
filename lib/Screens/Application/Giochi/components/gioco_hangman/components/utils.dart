// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/ui/colors.dart';

class Game {
  //Aggiungo il numero di tentativi
  static int tries = 0;
  static List<String> selectedChar = [];
}

//Stampo la parola nascosta
Widget letter(BuildContext context, String character, bool hidden) {
  //Occupo tutto lo schermo sia in altezza che in lunghezza
  Size size = MediaQuery.of(context).size;
  return Container(
    alignment: Alignment.center,
    height: size.height * 0.05,
    width: size.width * 0.05,
    padding: EdgeInsets.all(0),
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Visibility(
      visible: !hidden,
      //Stampo la lettera nel character
      child: Text(
        character,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    ),
  );
}
