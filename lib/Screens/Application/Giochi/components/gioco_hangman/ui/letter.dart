import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_hangman/ui/colors.dart';

// STAMPA LA CASELLA DELLA LETTERA
Widget letter(BuildContext context, String character, bool hidden) {
  //si occupa tutto lo schermo in altezza e larghezza
  Size size = MediaQuery.of(context).size;
  return Container(
    alignment: Alignment.center,
    height: size.height * 0.1,
    width: size.width * 0.1,
    padding: EdgeInsets.all(0),
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Visibility(
      visible: !hidden,
      //stampa la lettera nel character
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
