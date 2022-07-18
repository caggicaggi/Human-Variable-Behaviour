// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print

import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/SignUp/sign_up_screen.dart';
import 'package:human_variable_behaviour/Screens/Welcome/components/background.dart';
import 'package:human_variable_behaviour/components/already_have_an_account_check.dart';
import 'package:human_variable_behaviour/components/rounded_button.dart';
import 'package:human_variable_behaviour/components/rounded_input_field.dart';
import 'package:human_variable_behaviour/components/rounded_password_field.dart';

import '../../../mysql/mysql.dart';
import '../../SignUp/components/body.dart';

String email = '';
String password = '';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

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
              'Login Page',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            //Immagine del logo Unicam
            Image.asset(
              'assets/images/logoUnicam.jpg',
              height: size.height * 0.18,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            //Prendo Email
            RoundedInputField(
              icon: Icons.email,
              hintText: "Email",
              onChange: (value) {
                email = value;
              },
            ),
            //Prendo password
            RoundedPasswordField(
              onChange: (value) {
                password = value;
              },
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            RoundedButton(
              text: 'Login',
              press: () {
                //Evento scatenato dal click sul RoundedButton
                //Controllo formato email
                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(email);
                //debugPrint(emailValid.toString());
                if (!emailValid) {
                  //Avviso formato email errato
                }
                //Controllo presenza stessa email nel database
                readEmailFromDb(email);
                //Salvo il check della queri dentro una variabile
                var CheckConnessione = signInToDb(email, password);
                /* inserire controllo (la query funziona): se checkConnessione è null allora bisogna
                reindirizzarlo alla pagina di SignIn se checkConnessione è qualsiasi altro valore 
                allora logga perchè vuol dire che esiste nel db */
              },
            ),
            //Chiamo la classe already_have_an_account_check.dart
            AlreadyHaveAnAccountCheck(
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

  void signInToDb(emailToDb, passwordToDb) {
    //Avvio la connessione al database
    var db = Mysql();
    //Aggiungo i '' a tutte le stringhe passate in input
    emailToDb = strinToDb(emailToDb);
    passwordToDb = strinToDb(passwordToDb);
    //Nome della tabella
    String table = 'utenti';
    //Scrivo la query
    String query = ' SELECT email = " ' +
        email +
        '" , password = " ' +
        password +
        '" FROM ' +
        table;
    db.getConnection().then((connessione) {
      debugPrint(query);
      connessione.query(query);
      connessione.close();
    });
  }
}
