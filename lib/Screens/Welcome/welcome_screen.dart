import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Welcome/components/body.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Necessario per la chiamata da parte del main.dart
    return Scaffold(
      //Chiamo la classe body.dart
      body: Body(),
    );
  }
}
