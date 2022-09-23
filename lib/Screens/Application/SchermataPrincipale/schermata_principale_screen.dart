// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

//Classe richiamata dal HomePage/components/body.dart
class SchermataPrincipaleScreen extends StatelessWidget {
  const SchermataPrincipaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
