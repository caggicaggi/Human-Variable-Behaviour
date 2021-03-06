// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Login/login_screen.dart';
import 'package:human_variable_behaviour/Screens/SignUp/sign_up_screen.dart';
import 'package:human_variable_behaviour/Screens/Welcome/components/background.dart';
import 'package:human_variable_behaviour/components/rounded_button.dart';
import 'package:human_variable_behaviour/constant.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Occupo tutto lo schermo sia in altezza che in lunghezza
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          //Allineo tutto al centro
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Testo della schermata
            const Text(
              'Human Variable Behaviour',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            //Spaziatura
            SizedBox(height: size.height * 0.05),
            //Immagine del logo Unicam
            Image.asset(
              'assets/images/logoUnicam.jpg',
              height: size.height * 0.45,
            ),
            //Spaziatura
            SizedBox(height: size.height * 0.05),
            //Chiamo la class rounded_button.dart
            //Costruttore con Testo sta stampare e Funzione da chiamare
            RoundedButton(
              text: 'LOGIN',
              //Se premuto il pulsante di LOGIN passo alla schermata successiva
              press: () {
                //Passo alla pagina successiva -> return LoginScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: 'SIGN IN',
              color: kPrimaryLightColor,
              press: () {
                //Passo alla pagina successiva -> return LoginScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
