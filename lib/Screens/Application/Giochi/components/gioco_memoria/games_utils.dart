import 'dart:math';

import 'package:flutter/material.dart';

class Game {
  final Color hiddenCard = Colors.red;
  List<Color>? gameColors;
  List<String>? gameImg;

  List<Color> cards = [
    Colors.green,
    Colors.yellow,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.blue
  ];
  final String hiddenCardpath = "assets/images/hidden.png";
  List<String> cards_list = [];

  final int cardCount = 16;
  List<Map<int, String>> matchCheck = [];

  //methods
  void initGame() {
    cards_list = changeList();
    gameColors = List.generate(cardCount, (index) => hiddenCard);
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }

  //trovare un modo per come assegnare le stringhe in modo casuale e dinamico
  List<String> changeList() {
    List<int> lista = [1, 2, 3];
    Random random = new Random();
    int randomNumber = random.nextInt(3) + 0;

    if (randomNumber == 0) {
      List<String> cards_list = [
        "assets/images/circle.png",
        "assets/images/heart.png",
        "assets/images/star.png",
        "assets/images/triangle.png",
        "assets/images/circle.png",
        "assets/images/star.png",
        "assets/images/heart.png",
        "assets/images/triangle.png",
        "assets/images/star.png",
        "assets/images/circle.png",
        "assets/images/heart.png",
        "assets/images/star.png",
        "assets/images/triangle.png",
        "assets/images/heart.png",
        "assets/images/triangle.png",
        "assets/images/circle.png",
      ];
      return cards_list;
    } else if (randomNumber == 1) {
      List<String> cards_list = [
        "assets/images/heart.png",
        "assets/images/star.png",
        "assets/images/triangle.png",
        "assets/images/circle.png",
        "assets/images/triangle.png",
        "assets/images/heart.png",
        "assets/images/star.png",
        "assets/images/triangle.png",
        "assets/images/circle.png",
        "assets/images/star.png",
        "assets/images/heart.png",
        "assets/images/triangle.png",
        "assets/images/star.png",
        "assets/images/circle.png",
        "assets/images/circle.png",
        "assets/images/heart.png",
      ];
      return cards_list;
    } else if (randomNumber == 2) {
      List<String> cards_list = [
        "assets/images/triangle.png",
        "assets/images/circle.png",
        "assets/images/triangle.png",
        "assets/images/circle.png",
        "assets/images/star.png",
        "assets/images/triangle.png",
        "assets/images/star.png",
        "assets/images/circle.png",
        "assets/images/heart.png",
        "assets/images/star.png",
        "assets/images/heart.png",
        "assets/images/circle.png",
        "assets/images/heart.png",
        "assets/images/heart.png",
        "assets/images/star.png",
        "assets/images/triangle.png",
      ];
      return cards_list;
    }

    return cards_list;
  }
}
