import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/components/text_field_container.dart';

//Oggetto RoundedButton
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
    return TextFieldContainer(
      child: Container(
        padding: const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueGrey, width: 2),
            borderRadius: BorderRadius.circular(50)),
        child: TextField(
          //Colore del testo che si scrive
          style: const TextStyle(color: Colors.blueGrey),
          onChanged: onChange,
          decoration: InputDecoration(
            //Colore del testo che compare inizialmente
            hintStyle: const TextStyle(color: Colors.blueGrey),
            icon: Icon(
              icon,
              //Colore icona
              color: Colors.blueGrey,
            ),
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
