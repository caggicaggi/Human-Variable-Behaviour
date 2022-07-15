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

class Body extends StatelessWidget {
  final Widget child;
  const Body({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign Up Page',
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
            RoundedPasswordField(
              onChange: (value) {
                password = value;
              },
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            RoundedButton(
              text: 'SIGN UP',
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
                //Registro il nuovo utente
                //signUpToDb(name, surname, email, password);
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
  //Avvio la connessione al database
  var db = Mysql();
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
      ' (Username, Password) VALUES (' +
      name +
      ',' +
      surname +
      ',' +
      email +
      ',' +
      password +
      ')';

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
