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
          login ? 'Non hai un account? ' : "Hai già un account?",
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? 'Registrati' : 'Accedi',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
