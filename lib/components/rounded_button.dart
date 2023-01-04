import 'package:flutter/material.dart';

//Oggetto RoundedButton
class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = Colors.white,
    this.textColor = Colors.blueGrey,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //Occupo tutto lo schermo sia in altezza che in lunghezza
    Size size = MediaQuery.of(context).size;
    return Container(
      //Margine fra widget precedente e successivo
      margin: const EdgeInsets.symmetric(vertical: 5),
      //Larghezza
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: ElevatedButton(
          onPressed: press,
          //Colore di sfondo e colore quando lo si preme
          style: ElevatedButton.styleFrom(
            primary: Colors.white, // background
            onPrimary: Colors.blueGrey, // foreground
          ),
          //Assegno il testo passato in input
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
