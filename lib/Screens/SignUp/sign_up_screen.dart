// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/SignUp/components/body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
