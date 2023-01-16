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
import 'package:google_sign_in/google_sign_in.dart';

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

class _BodyState extends State<Body> {
  //Variabili per il login con Google
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isLoggedIn = false;
  late GoogleSignInAccount _userObj;

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
              height: size.height * 0.05,
            ),
            //logo Human Variable
            Image.asset('assets/images/logoH.png', height: size.height * 0.32),
            SizedBox(
              height: size.height * 0.03,
            ),
            //Immagine del logo Unicam
            Image.asset(
              'assets/images/unicamLogo.png',
              height: size.height * 0.1,
            ),
            SizedBox(
              height: size.height * 0.03,
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
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            //Pulsante per loggarsi con Google
            Container(
              child: _isLoggedIn
                  //Se loggato
                  ? Center(
                      child: SignInButton(
                        padding: const EdgeInsets.symmetric(horizontal: 55),
                        Buttons.Google,
                        text: "Disconnetti da Google",
                        onPressed: () {
                          _googleSignIn.signOut().then((value) {
                            setState(() {
                              _isLoggedIn = false;
                            });
                          }).catchError((e) {});
                        },
                      ),
                    )

                  //Se non loggato
                  : Center(
                      child: SignInButton(
                      padding: const EdgeInsets.symmetric(horizontal: 55),
                      Buttons.Google,
                      text: "Accedi con Google",
                      onPressed: () async {
                        _googleSignIn.signIn().then((userData) async {
                          //Login Effettuato
                          _isLoggedIn = true;
                          setState(() {});
                          //Ottengo tutte le infomazioni
                          _userObj = userData!;
                          if (await readEmailFromDb(_userObj.email)) {
                            //debugPrint("Email non presente");
                            //Devo registrarla
                            await signUpToDbGoogle(
                                    _userObj.displayName, _userObj.email)
                                .then(
                              (value) {
                                //Leggo tutte le informazioni dell'utente che si sta loggando e vado alla HomePage
                                readInformationWithId(idUtente).then((value) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const HomePageScreen();
                                      },
                                    ),
                                  );
                                });
                              },
                            );
                          } else {
                            //debugPrint("Email già presente");
                            //Devo leggere le info
                            await readInformationWithId(idUtente).then((value) {
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
                        }).catchError((e) {});
                      },
                    )),
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
