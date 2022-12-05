// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/HomePage/homepage_screen.dart';
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
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
            //Immagine del logo Unicam
            Image.asset(
              'assets/images/logoUnicam.jpg',
              height: size.height * 0.15,
            ),
            //Spaziatura
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
            if (!emailDuplicated)
              Text(
                'Email già registrata, prego effettuare login',
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
              press: () async {
                //Evento scatenato dal click sul RoundedButton
                //Controllo formato email
                emailValidation = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(email);
                //Email valida
                if (emailValidation) {
                  //Chiamo la query per verificare se email già inserita
                  if (await readEmailFromDb(email)) {
                    //Cancello  avvisi di errore
                    emailDuplicated = true;
                    setState(() {});
                    //Con l'await aspetto che il metodo finisca, prima di procedere
                    await signUpToDb(name, surname, email, password).then(
                      (value) {
                        //Leggo tutte le informazioni dell'utente che si sta loggando e vado alla HomePage
                        readInformationWithId(idUtente).then((value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomePageScreen();
                              },
                            ),
                          );
                        });
                      },
                    );
                  } else {
                    //debugPrint('Email registrata, effettuare login');
                    setState(() {
                      emailDuplicated = false;
                    });
                  }
                  //Email non valida
                } else {
                  setState(() {});
                }
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
            //---------OR---------
            OrDivider(),
            //Registrati con i social
            //To do
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
