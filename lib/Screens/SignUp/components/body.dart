// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Login/login_screen.dart';
import 'package:human_variable_behaviour/Screens/SignUp/components/background.dart';
import 'package:human_variable_behaviour/Screens/SignUp/components/or_divider.dart';
import 'package:human_variable_behaviour/Screens/SignUp/social_icon.dart';
import 'package:human_variable_behaviour/components/already_have_an_account_check.dart';
import 'package:human_variable_behaviour/components/rounded_button.dart';
import 'package:human_variable_behaviour/components/rounded_input_field.dart';
import 'package:human_variable_behaviour/components/rounded_password_field.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';

String name = '';
String surname = '';
String email = '';
String password = '';
//Variabili per avviso visivo
bool emailValidation = true;
bool emailDuplicated = true;

class Body extends StatefulWidget {
  final Widget child;
  const Body({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Immagine del logo Unicam
            Image.asset(
              'assets/images/logoUnicam.jpg',
              height: size.height * 0.15,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            RoundedInputField(
              icon: Icons.person,
              hintText: "Nome",
              onChange: (value) {
                name = value;
              },
            ),
            RoundedInputField(
              icon: Icons.person,
              hintText: "Cognome",
              onChange: (value) {
                surname = value;
              },
            ),
            RoundedInputField(
              icon: Icons.email,
              hintText: "Email",
              onChange: (value) {
                email = value;
              },
            ),
            if (!emailValidation)
              Text(
                'Formato email non corretto',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
            RoundedPasswordField(
              onChange: (value) {
                password = value;
              },
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            //Avviso email già registrata
            RoundedButton(
              text: 'SIGN UP',
              press: () {
                //Evento scatenato dal click sul RoundedButton
                //Controllo formato email
                emailValidation = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(email);
                debugPrint(emailValidation.toString());
                setState(() {});
                //Controllo presenza stessa email nel database
                readEmailFromDb(email);

                //Registro il nuovo utente
                signUpToDb(name, surname, email, password);
              },
            ),
            AlreadyHaveAnAccountCheck(
              login: false,
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
            OrDivider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialIcon(
                  scrIcon: 'assets/images/google.jpg',
                  press: () {},
                ),
                SocialIcon(
                  scrIcon: 'assets/images/instagram.jpg',
                  press: () {},
                ),
                SocialIcon(
                  scrIcon: 'assets/images/facebook.jpg',
                  press: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//Funzione per registrare l'utente nel database
void signUpToDb(nameToDb, surnameToDb, emailToDb, passwordToDb) {
  //Aggiungo i '' a tutte le stringhe passate in input
  nameToDb = strinToDb(nameToDb);
  surnameToDb = strinToDb(surnameToDb);
  emailToDb = strinToDb(emailToDb);
  passwordToDb = strinToDb(passwordToDb);
  //Nome della tabella
  String table = 'utenti';
  //Scrivo la query
  String query = 'INSERT INTO ' +
      table +
      ' (nome, cognome, email, password) VALUES (' +
      name +
      '","' +
      surname +
      '","' +
      email +
      '","' +
      password +
      '")';

  //Connessione al database
  var db = Mysql();
  db.getConnection().then((connessione) {
    debugPrint(query);
    connessione.query(query);
    connessione.close();
  });
}

//Funzione per controllare l'esistenza della mail
bool readEmailFromDb(emailToRead) {
  return true;
}

//Funzione per aggiungere i '' alle stringhe passate in input
String strinToDb(stringToConvert) => '\'' + stringToConvert + '\'';