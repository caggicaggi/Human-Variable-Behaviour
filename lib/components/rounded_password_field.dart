import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/components/text_field_container.dart';

//Oggetto RoundedPasswordField
class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChange;
  const RoundedPasswordField({
    Key? key,
    required this.onChange,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        //Colore del testo che si scrive
        style: const TextStyle(color: Colors.blueGrey),
        obscureText: true,
        onChanged: onChange,
        decoration: const InputDecoration(
          //Colore del testo che compare inizialmente
          hintStyle: TextStyle(color: Colors.blueGrey),
          hintText: 'Password',
          icon: Icon(Icons.lock, color: Colors.blueGrey),
          suffixIcon: Icon(
            Icons.visibility,
            //Colore icona
            color: Colors.blueGrey,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
