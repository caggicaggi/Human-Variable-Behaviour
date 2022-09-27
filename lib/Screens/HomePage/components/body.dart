// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Diario/dynamic_event.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/giochi_screen.dart';
import 'package:human_variable_behaviour/Screens/Application/Persona/persona_screen.dart';
import 'package:human_variable_behaviour/Screens/Application/SchermataPrincipale/schermata_principale_screen.dart';
import 'package:human_variable_behaviour/Screens/Application/Unicam/unicam_screen.dart';
import 'package:human_variable_behaviour/Screens/HomePage/components/background.dart';
import 'package:human_variable_behaviour/constant.dart';

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
    GiochiScreen(),
    PersonaScreen(),
    //Oggetto Schermata principale
    SchermataPrincipaleScreen(),
    DynamicEvent(),
    UnicamScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    //Occupo tutto lo schermo sia in altezza che in lunghezza
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Scaffold(
      body: Center(
        child: pages[_currentIndex],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: kPrimaryLightColor,
        selectedIndex: _currentIndex,
        onDestinationSelected: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.gamepad),
            icon: Icon(Icons.gamepad_outlined),
            label: 'giochi',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outlined),
            label: 'persona',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.menu_book),
            icon: Icon(Icons.menu_book_outlined),
            label: 'diario',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.school),
            icon: Icon(Icons.school_outlined),
            label: 'informativa',
          ),
        ],
      ),
    ));
  }
}
