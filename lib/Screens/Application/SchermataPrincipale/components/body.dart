// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/SchermataPrincipale/components/background.dart';
import 'package:human_variable_behaviour/Screens/HomePage/components/category_card.dart';
import 'package:human_variable_behaviour/Screens/HomePage/search_bar.dart';

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
                        Text(
                          textAlign: TextAlign.center,
                          "Benvenuto campione!",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(fontWeight: FontWeight.w900),
                        ),
                        SearchBar(),
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
