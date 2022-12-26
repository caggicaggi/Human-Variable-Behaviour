// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/sfondo.png"), fit: BoxFit.cover),
      ),
      height: size.height,
      width: size.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          child,
        ],
      ),
    );
  }
}
