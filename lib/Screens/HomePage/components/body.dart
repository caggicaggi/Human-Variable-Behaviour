// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/HomePage/components/background.dart';

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
            Text('Benvenuto nella homepage'),
          ],
        ),
      ),
    );
  }
}
