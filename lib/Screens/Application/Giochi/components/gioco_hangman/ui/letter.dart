import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/ui/colors.dart';

// STAMPA LA CASELLA DELLA LETTERA
Widget letter(String character, bool hidden) {
  return Container(
    alignment: Alignment.center,
    height: 65,
    width: 57,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Visibility(
      visible: !hidden,
      child: Text(
        character,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 40.0,
        ),
      ),
    ),
  );
}
