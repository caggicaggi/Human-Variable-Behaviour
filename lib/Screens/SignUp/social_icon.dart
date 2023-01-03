// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/constant.dart';

class SocialIcon extends StatelessWidget {
  final String scrIcon;
  final VoidCallback press;
  const SocialIcon({
    Key? key,
    required this.scrIcon,
    required this.press,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: kPrimaryLightColor,
          ),
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          scrIcon,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}
