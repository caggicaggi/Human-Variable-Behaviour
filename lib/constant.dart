import 'package:flutter/material.dart';

//Immagine di sfondo dell'app
BoxDecoration getBackroundImage() {
  return const BoxDecoration(
    image: DecorationImage(
        image: AssetImage("assets/images/sfondo.png"), fit: BoxFit.cover),
  );
}

//Immagine di sfondo della schermata principale
BoxDecoration getBackroundImageHomePage() {
  return const BoxDecoration(
    image: DecorationImage(
        image: AssetImage("assets/images/sfondoSchermataPrincipale.png"),
        fit: BoxFit.cover),
  );
}
//Da rivedere

class LightColors {
  static const Color kLightYellow = Color(0xFFFFF9EC);
  static const Color kLightYellow2 = Color(0xFFFFE4C7);
  static const Color kDarkYellow = Color(0xFFF9BE7C);
  static const Color kPalePink = Color(0xFFFED4D6);

  static const Color kRed = Color(0xFFE46472);
  static const Color kLavender = Color(0xFFD5E4FE);
  static const Color kBlue = Color(0xFF6488E4);
  static const Color kLightGreen = Color(0xFFD9E6DC);
  static const Color kGreen = Color(0xFF309397);

  static const Color kDarkBlue = Color(0xFF0D253F);
}
/*
//Colori costanti utilizzati nell'applicazione
const kPrimaryColor = Color.fromARGB(255, 10, 152, 235);
const kPrimaryLightColor = Color.fromARGB(255, 10, 152, 235);
const kBackgroundColor = Color(0xFFF8F8F8);
const kActiveIconColor = Color(0xFFE68342);
const kTextColor = Color(0xFF222B45);
const kBlueLightColor = Color(0xFFC7B8F5);
const kBlueColor = Color(0xFF817DC0);
const kShadowColor = Color(0xFFE6E6E6);
const kSecondaryColor = Color(0xFF8B94BC);
const kGreenColor = Color(0xFF6AC259);
const kRedColor = Color(0xFFE92E30);
const kGrayColor = Color(0xFFC1C1C1);
const kBlackColor = Color(0xFF101010);
const kPrimaryGradient = LinearGradient(
  colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const double kDefaultPadding = 20.0 * 0.6;
*/