import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:human_variable_behaviour/Screens/HomePage/homepage_screen.dart';
import 'package:human_variable_behaviour/Screens/Login/components/background.dart';
import 'package:human_variable_behaviour/Screens/SignUp/sign_up_screen.dart';
import 'package:human_variable_behaviour/components/already_have_an_account_check.dart';
import 'package:human_variable_behaviour/components/rounded_button.dart';
import 'package:human_variable_behaviour/components/rounded_input_field.dart';
import 'package:human_variable_behaviour/components/rounded_password_field.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';

//Variabili per avviso visivo
String password = '';
bool emailValidation = true;
bool emailPresence = true;

//Non ho ben capito a cosa serve
bool checkScaffold = false;

//Widget dinamico, aggiornabile
class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);
  @override
  State<Body> createState() => _BodyState();
}

//Widget
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
              'assets/images/unicamLogo.png',
              height: size.height * 0.20,
            ),
            SizedBox(
              height: size.height * 0.26,
            ),
            //Input email
            RoundedInputField(
              icon: Icons.email,
              hintText: "Email",
              onChange: (value) {
                email = value;
              },
            ),
            //Avvisi che compariranno se ci si prova a loggare e si fallisce il test
            if (!emailValidation)
              const Text(
                'Formato email non corretto',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            if (!emailPresence)
              const Text(
                'Id o password errati, controlla e riprova',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            //Prendo password
            RoundedPasswordField(
              onChange: (value) {
                password = value;
              },
            ), //Pulsante per loggarsi con Google
            SignInButton(
              padding: const EdgeInsets.symmetric(horizontal: 55),
              Buttons.Google,
              text: "Registrati con Google",
              onPressed: () {},
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            RoundedButton(
              text: 'Accedi',
              press: () async {
                //Controllo formato email
                emailValidation = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(email);
                //Refresh della pagina per visualizzare o cancellare l'avviso del formato errato
                setState(() {});
                if (emailValidation) {
                  //Verifico se email già registrata
                  if (await readEmailPasswordFromDb(email, password)) {
                    emailPresence = false;
                    //Refresh della pagina per visualizzare o cancellare l'avviso del formato errato
                    setState(() {});
                  } else {
                    //Leggo tutte le informazioni dell'utente che si sta loggando e vado alla HomePage
                    await readInformationWithId(idUtente).then((value) {
                      //Cancello precedenti avvisi di errore
                      emailPresence = true;
                      setState(() {});
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const HomePageScreen();
                          },
                        ),
                      );
                    });
                  }
                }
              },
              color: Colors.white,
            ),
            //Pulsante per registrarsi nel caso non si avesse un account
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      //Pagina di SignUp
                      return const SignUpScreen();
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
