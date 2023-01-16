// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Diario/dynamic_event.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/giochi_screen.dart';
import 'package:human_variable_behaviour/Screens/Application/Persona/persona_screen.dart';
import 'package:human_variable_behaviour/Screens/Application/SchermataPrincipale/schermata_principale_screen.dart';
import 'package:human_variable_behaviour/Screens/Application/Unicam/unicam_screen.dart';
import 'package:human_variable_behaviour/Screens/HomePage/components/background.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //Parto dalla sezione home
  int _currentIndex = 2;
  //Lista di widget richiamati dal NavigationBar
  //Qui occorre chiamare il construttore di una classe che ritornerà un wiget
  List<Widget> pages = [
    //Oggetto Giochi
    GiochiScreen(),
    //Oggetto Persona
    PersonaScreen(),
    //Oggetto Schermata principale
    SchermataPrincipaleScreen(),
    //Oggetto Diario
    DynamicEvent(),
    //Oggetto Unicam
    UnicamScreen(),
  ];
  @override

  //Creo la bottom navigation bar
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        body: Center(
          child: pages[_currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
          unselectedItemColor: Colors.blueGrey,
          showUnselectedLabels: true,
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            BottomNavigationBarItem(
              backgroundColor: Color.fromARGB(255, 18, 35, 147),
              icon: Icon(Icons.gamepad),
              label: 'Games',
            ),
            BottomNavigationBarItem(
              backgroundColor: Color.fromARGB(255, 18, 35, 147),
              icon: Icon(Icons.person),
              label: 'Profilo',
            ),
            //Home
            BottomNavigationBarItem(
              backgroundColor: Color.fromARGB(255, 18, 35, 147),
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            //Diario
            BottomNavigationBarItem(
              backgroundColor: Color.fromARGB(255, 18, 35, 147),
              icon: Icon(Icons.menu_book),
              label: 'Diario',
            ),
            BottomNavigationBarItem(
              backgroundColor: Color.fromARGB(255, 18, 35, 147),
              icon: Icon(Icons.school),
              label: 'Info',
            )
          ],
        ),
      ),
    );
  }
}
