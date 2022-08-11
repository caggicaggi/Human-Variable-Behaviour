import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Unicam/components/body.dart';
import 'package:url_launcher/url_launcher.dart';

class UnicamScreen extends StatelessWidget {
  const UnicamScreen({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('SEZIONE INFORMATIVA UNICAM'),
          centerTitle: true,
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          InkWell(
              child: Text(
                'Sito unicam',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 25,
                    color: Color.fromARGB(255, 18, 18, 192),
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => launch('https://www.unicam.it/')),
          InkWell(
              child: Text(
                'Area Riservata Unicam',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 25,
                    color: Color.fromARGB(255, 18, 18, 192),
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => launch('https://didattica.unicam.it/Home.do')),
          InkWell(
              child: Text(
                'Portale dello studente ',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 25,
                    color: Color.fromARGB(255, 18, 18, 192),
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => launch('https://www.unicam.it/studente')),
          InkWell(
              child: Text(
                'Portale della didattica Unicam',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 25,
                    color: Color.fromARGB(255, 18, 18, 192),
                    fontWeight: FontWeight.bold),
              ),
              onTap: () =>
                  launch('https://www.unicam.it/didattica/portale-didattica')),
        ]),
      ),
    );
  }
}
