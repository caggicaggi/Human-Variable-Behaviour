// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors, unused_local_variable
import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/SchermataPrincipale/components/background.dart';
import 'package:human_variable_behaviour/Screens/HomePage/components/category_card.dart';
import 'package:human_variable_behaviour/Screens/HomePage/search_bar.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';

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
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Align(
        alignment: Alignment.topRight,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: Color(0xFFF5CEB8)),
              ),
              SafeArea(
                  minimum: const EdgeInsets.all(16.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        //Label per benvenuto
                        Text(
                          textAlign: TextAlign.center,
                          "Bentornato: " + nome + ' ' + cognome,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: size.width * 0.06),
                        ),
                        //Barra di ricerca
                        //SearchBar(),
                        Column(
                          children: <Widget>[
                            CategoryCard(
                                title: "Informazioni 1",
                                svgSrc: "assets/icons/facebook.svg",
                                press: () {}),
                            CategoryCard(
                                title: "Informazoni 2",
                                svgSrc: "assets/icons/facebook.svg",
                                press: () {}),
                            CategoryCard(
                              title: "Informazoni 3",
                              svgSrc: "assets/icons/facebook.svg",
                            ),
                            CategoryCard(
                                title: "Informazoni 4",
                                svgSrc: "assets/icons/facebook.svg",
                                press: () {}),
                            CategoryCard(
                                title: "Informazoni 5",
                                svgSrc: "assets/icons/facebook.svg",
                                press: () {}),
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
