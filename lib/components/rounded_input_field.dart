import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/components/text_field_container.dart';
import 'package:human_variable_behaviour/constant.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChange;

  const RoundedInputField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Occupo tutto lo schermo sia in altezza che in lunghezza
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
      child: TextField(
        style: const TextStyle(color: Colors.white),
        onChanged: onChange,
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.white),
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
