// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  //si inizializzano le variabili
  final bool _answer;
  final VoidCallback _onTap;

  //si crea l'oggetto
  AnswerButton(this._answer, this._onTap);

// PULSANTE RISPOSTA ALLA IMMAGINE
  @override
  Widget build(BuildContext context) {
    //si occupa tutto lo schermo sia in altezza che lunghezza
    Size size = MediaQuery.of(context).size;
    return Container(
      //child: Material(
      //elevation: 20,

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: _answer == true ? Colors.green : Colors.red),
        onPressed: () => _onTap(),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(size.height * 0.01),
            child: Text(
              //testo che si ha sopra al pulsante
              _answer == true ? "Vero" : "Falso",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ),
      //),
    );
  }
}
