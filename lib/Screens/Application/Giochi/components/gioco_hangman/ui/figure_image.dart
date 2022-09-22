import 'package:flutter/cupertino.dart';

//stampa l'immagine
Widget figureImage(BuildContext context, bool visible, String path) {
  //si occupa tutto lo schermo in altezza e lunghezza
  Size size = MediaQuery.of(context).size;
  return Visibility(
      visible: visible,
      child: Container(
        width: size.width * 0.4,
        height: size.height * 0.2,
        child: Image.asset(path),
      ));
}
