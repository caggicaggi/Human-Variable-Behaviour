import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/HomePage/components/body.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
