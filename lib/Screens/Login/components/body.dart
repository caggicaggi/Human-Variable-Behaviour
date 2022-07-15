import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/SignUp/sign_up_screen.dart';
import 'package:human_variable_behaviour/Screens/Welcome/components/background.dart';
import 'package:human_variable_behaviour/components/already_have_an_account_check.dart';
import 'package:human_variable_behaviour/components/rounded_button.dart';
import 'package:human_variable_behaviour/components/rounded_input_field.dart';
import 'package:human_variable_behaviour/components/rounded_password_field.dart';

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
              height: size.height * 0.02,
            ),
            //Immagine del logo Unicam
            Image.asset(
              'assets/images/logoUnicam.jpg',
              height: size.height * 0.18,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            //Chiamo la classe rounded_input_field.dart
            RoundedInputField(
              icon: Icons.email,
              hintText: 'Your Email',
              onChange: (value) {},
            ),
            //Chiamo la classe rounded_password_field.dart
            RoundedPasswordField(
              onChange: (value) {},
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedButton(text: 'LOGIN', press: () {}),
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
