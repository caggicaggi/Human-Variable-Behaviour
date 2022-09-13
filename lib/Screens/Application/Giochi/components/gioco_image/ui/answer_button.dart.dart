import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final bool _answer;
  final VoidCallback _onTap;
  AnswerButton(this._answer, this._onTap);

// PULSANTE RISPOSTA ALLA IMMAGINE

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Material(
        elevation: 20,
        child: RaisedButton(
          color: Colors.blue,
          onPressed: () => _onTap(),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(size.height * 0.01),
              child: Text(
                _answer == true ? "SIII!" : "NOOO!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.w100,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
