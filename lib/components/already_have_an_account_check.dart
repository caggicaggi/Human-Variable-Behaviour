// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      //Allineo tutto al centro
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? 'Non hai un account? ' : "Hai già un account? ",
          style: TextStyle(
            color: Colors.blueGrey,
          ),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? 'Registrati' : 'Accedi',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
        )
      ],
    );
  }
}
