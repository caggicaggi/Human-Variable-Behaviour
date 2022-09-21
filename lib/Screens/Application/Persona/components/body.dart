import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_memoria/memoria_screen.dart';
import 'package:human_variable_behaviour/Screens/Application/Persona/components/background.dart';
import 'package:human_variable_behaviour/Screens/Application/Persona/components/settings_page.dart';
import 'package:human_variable_behaviour/Screens/Application/Persona/persona_screen.dart';
import 'package:human_variable_behaviour/Screens/HomePage/homepage_screen.dart';
import 'package:human_variable_behaviour/Screens/Login/components/body.dart';
import 'package:human_variable_behaviour/components/rounded_input_field.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

bool showPassword = false;
bool checkforModifica = false;

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    checkForNotification();
    Size size = MediaQuery.of(context).size;

    if (checkforModifica == true) {
      checkScaffold = true;
    } else {
      checkScaffold = false;
    }
    if (checkScaffold == true) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            onPressed: () {
              Get.to(HomePageScreen());
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.blue,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => SettingsPage()));
              },
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/sfondo_games.png"),
                fit: BoxFit.cover),
          ),
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Text(
                  "Aggiorna qui il tuo Profilo!",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                                ))),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: Colors.blue,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                RoundedInputField(
                  icon: Icons.person,
                  hintText: "Nome ",
                  onChange: (value) {
                    nome = value;
                  },
                ),
                RoundedInputField(
                  icon: Icons.person,
                  hintText: "Cognome ",
                  onChange: (value) {
                    cognome = value;
                  },
                ),
                RoundedInputField(
                  icon: Icons.email,
                  hintText: "Email ",
                  onChange: (value) {
                    email = value;
                  },
                ),
                RoundedInputField(
                  icon: Icons.school,
                  hintText: "Istituto Frequentato ",
                  onChange: (value) {
                    IstitutoFrequentato = value;
                  },
                ),
                RoundedInputField(
                  icon: Icons.person,
                  hintText: "Età ",
                  onChange: (value) {
                    Eta = value;
                  },
                ),
                RoundedInputField(
                  icon: Icons.heart_broken_outlined,
                  hintText: "Passione ",
                  onChange: (value) {
                    Passione = value;
                  },
                ),
                RoundedInputField(
                  icon: Icons.heart_broken_outlined,
                  hintText: "Sport Preferito ",
                  onChange: (value) {
                    SportPreferito = value;
                  },
                ),
                RoundedInputField(
                  icon: Icons.hearing_outlined,
                  hintText: "Musica preferita ",
                  onChange: (value) {
                    MusicaPreferita = value;
                  },
                ),
                RoundedInputField(
                  icon: Icons.hearing_outlined,
                  hintText: "Artista preferito ",
                  onChange: (value) {
                    ArtistaPreferito = value;
                  },
                ),
                RoundedInputField(
                  icon: Icons.school,
                  hintText: "Materia preferita ",
                  onChange: (value) {
                    MateriaPreferita = value;
                  },
                ),
                SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        signUpToDbInf(
                            nome,
                            cognome,
                            email,
                            IstitutoFrequentato,
                            Eta,
                            Passione,
                            SportPreferito,
                            MusicaPreferita,
                            ArtistaPreferito,
                            MateriaPreferita);
                        checkforModifica = false;
                        checkScaffold = false;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Container(
                              height: 40,
                              decoration: BoxDecoration(color: Colors.blue),
                              child: Text(
                                "Dati aggiornati, Buon divertimento!",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 22, color: Colors.white),
                              ),
                            )));
                        Get.to(HomePageScreen());
                      },
                      color: Colors.blue,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "SALVA",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            onPressed: () {
              Get.to(HomePageScreen());
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.blue,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => SettingsPage()));
              },
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/sfondo_games.png"),
                fit: BoxFit.cover),
          ),
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Text(
                  "Ecco il tuo Profilo",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                                ))),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: Colors.blue,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                buildTextField("Nome: ", nome, false),
                buildTextField("Cognome: ", cognome, false),
                buildTextField("E-mail: ", email, false),
                buildTextField(
                    "Istituto frequentato", IstitutoFrequentato, false),
                buildTextField("Età: ", checkEta(), false),
                buildTextField("Passione: ", Passione, false),
                buildTextField("Sport preferito: ", SportPreferito, false),
                buildTextField("Musica preferita: ", MusicaPreferita, false),
                buildTextField("Artista preferito: ", ArtistaPreferito, false),
                buildTextField("Materia preferita: ", MateriaPreferita, false),
                SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        checkforModifica = true;
                        Get.to(PersonaScreen());
                      },
                      color: Colors.blue,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "MODIFICA",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: Text(
        labelText + "\n" + placeholder,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  //Controllo per stampare Stringa sulla variabile età
  String checkEta() {
    if (Eta == "1") {
      return Eta = "non hai inserito aluna descrizione";
    } else {
      return Eta = Eta.toString();
    }
  }
}
