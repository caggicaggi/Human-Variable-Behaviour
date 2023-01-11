import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/constant.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //si occupa tutto lo schermo sia in altezza che in lunghezza
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: getBackroundImageHomePage(),
      //Definisco altezza e larghezza del Container
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
