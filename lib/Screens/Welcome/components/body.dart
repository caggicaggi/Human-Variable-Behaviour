import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Login/login_screen.dart';
import 'package:human_variable_behaviour/Screens/SignUp/sign_up_screen.dart';
import 'package:human_variable_behaviour/Screens/Welcome/components/background.dart';
import 'package:human_variable_behaviour/components/rounded_button.dart';

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
            //Immagine del logo Unicam
            Image.asset(
              'assets/images/unicamLogo.png',
              height: size.height * 0.20,
            ),
            //Spaziatura
            SizedBox(height: size.height * 0.45),
            //Login
            RoundedButton(
              text: 'LOGIN',
              //color: ,
              press: () {
                //Pagina di login
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginScreen();
                    },
                  ),
                );
              },
            ),
            //Sign In
            RoundedButton(
              text: 'SIGN IN',
              //color: ,
              press: () {
                //Pagina di Registrazione
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
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
