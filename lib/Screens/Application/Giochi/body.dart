import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/background.dart';

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
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Widget Giochi'),
          ],
        ),
      ),
    );
  }
}
