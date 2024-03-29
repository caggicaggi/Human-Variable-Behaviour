import 'package:flutter/material.dart';

class TopContainer extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final EdgeInsets padding;

  const TopContainer(
      {super.key,
      required this.height,
      required this.width,
      required this.child,
      required this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 18, 35, 147),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
          )),
      height: height,
      width: width,
      child: child,
    );
  }
}
