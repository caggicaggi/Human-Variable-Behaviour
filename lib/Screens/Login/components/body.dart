// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print

//import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_quiz/quiz_questions.dart';
import 'package:human_variable_behaviour/Screens/HomePage/homepage_screen.dart';
import 'package:human_variable_behaviour/Screens/SignUp/sign_up_screen.dart';
import 'package:human_variable_behaviour/Screens/Welcome/components/background.dart';
import 'package:human_variable_behaviour/components/already_have_an_account_check.dart';
import 'package:human_variable_behaviour/components/rounded_button.dart';
import 'package:human_variable_behaviour/components/rounded_input_field.dart';
import 'package:human_variable_behaviour/components/rounded_password_field.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';

String password = '';
//Variabili per avviso visivo
bool emailValidation = true;
bool emailPresence = true;

bool checkScaffold = false;

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
            SizedBox(
              height: size.height * 0.01,
            ),
            //Immagine del logo Unicam
            Image.asset(
              'assets/images/logoUnicam.jpg',
              height: size.height * 0.15,
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
            if (!emailValidation)
              Text(
                'Formato email non corretto',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
            if (!emailPresence)
              Text(
                'Id o password errati, controlla e riprova',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
            //Prendo password
            RoundedPasswordField(
              onChange: (value) {
                password = value;
              },
            ),
            SizedBox(
              height: size.height * 0.04,
            ),

            RoundedButton(
              text: 'Login',
              press: () async {
                //Controllo formato email
                emailValidation = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(email);
                //Refresh della pagina per visualizzare o cancellare l'avviso del formato errato
                setState(() {});
                if (emailValidation) {
                  //Verifico se email già registrata
                  //debugPrint('Prima della query');
                  if (await readEmailPasswordFromDb(email, password)) {
                    emailPresence = false;
                    //Refresh della pagina per visualizzare o cancellare l'avviso del formato errato
                    setState(() {});
                  } else {
                    await readInformationWithId(idUtente);
                    await checkForNotification();
                    if (checkScaffold == true) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Container(
                            height: 90,
                            decoration: BoxDecoration(color: Colors.blue),
                            child: Text(
                              "RICORDA DI COMPILARE I TUOI DATI NELLA SEZIONE 'PERSONA'",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 22, color: Colors.white),
                            ),
                          )));
                    }
                    //debugPrint('Dopo della query');
                    emailPresence = true;
                    setState(() {});
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return HomePageScreen();
                        },
                      ),
                    );
                  }
                }
              },
            ),
            SignInButton(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              Buttons.Google,
              text: "Sign up with Google",
              onPressed: () {},
            ),

            SignInButton(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              Buttons.Facebook,
              text: "Sign up with Facebook",
              onPressed: () {},
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
}

//metodo per fare il check se i campi personali sono compilati
bool checkForNotification() {
  if (IstitutoFrequentato == "Non hai inserito alcuna descrizione" ||
      Eta == '1' ||
      Passione == "Non hai inserito alcuna descrizione" ||
      SportPreferito == "Non hai inserito alcuna descrizione" ||
      MusicaPreferita == "Non hai inserito alcuna descrizione" ||
      ArtistaPreferito == "Non hai inserito alcuna descrizione" ||
      MateriaPreferita == "Non hai inserito alcuna descrizione") {
    return checkScaffold = true;
  }
  return checkScaffold = false;
}
