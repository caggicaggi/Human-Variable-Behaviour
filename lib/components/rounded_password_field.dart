import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/components/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChange;

  const RoundedPasswordField({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Occupo tutto lo schermo sia in altezza che in lunghezza
    Size size = MediaQuery.of(context).size;
    var white = Colors.white;
    return TextFieldContainer(
      child: TextField(
        style: TextStyle(color: Colors.white),
        obscureText: true,
        onChanged: onChange,
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.white),
          hintText: 'Password',
          icon: Icon(Icons.lock, color: white),
          suffixIcon: Icon(
            Icons.visibility,
            color: white,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
