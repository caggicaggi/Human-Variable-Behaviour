import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Occupo tutto lo schermo sia in altezza che in lunghezza
    Size size = MediaQuery.of(context).size;
    return Container(
      //decoration: getBackroundImageHomePage(),
      color: Colors.white,
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          child,
        ],
      ),
    );
  }
}
