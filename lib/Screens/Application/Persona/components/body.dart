// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:human_variable_behaviour/Screens/Application/Persona/persona_screen.dart';
import 'package:human_variable_behaviour/Screens/Application/SchermataPrincipale/components/body.dart';
import 'package:human_variable_behaviour/Screens/HomePage/homepage_screen.dart';
import 'package:human_variable_behaviour/Screens/Login/components/body.dart';
import 'package:human_variable_behaviour/components/rounded_input_field.dart';
import 'package:human_variable_behaviour/constant.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';
import 'package:random_avatar/random_avatar.dart';

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
    //si setta la variabile per vedere cosa far visualizzare all'utente
    //checkForNotification();
    //si occupata tutto lo schermo sia in larghezza che altezza
    Size size = MediaQuery.of(context).size;

    if (checkforModifica == true) {
      //si fa vedere la schermata per la modifica
      checkScaffold = true;
    } else {
      //si fa vedere la schermata per la visualizzazione
      checkScaffold = false;
    }
    if (checkScaffold == true) {
      //SCAFFOLD per la modifica dei dati
      return Scaffold(
        body: Container(
          //Immagine di sfondo
          decoration: getBackroundImageHomePage(),
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Stack(
                    children: [
                      painters[0],
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 3,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: Colors.blue,
                            ),
                            child: //Pulsante per la creazione dell'avatar
                                FloatingActionButton(
                              onPressed: () {
                                //Se premuto creo l'avatar
                                String svg = randomAvatarString(
                                  DateTime.now().toIso8601String(),
                                  trBackground: true,
                                );
                                debugPrint('Avatar creato: ' + svg);
                                //Lo aggiunto alla lista
                                painters[0] = (randomAvatar(
                                  svg,
                                  height: 100,
                                  width: 90,
                                ));
                                //_controller.text = svg;
                                setState(() {});
                              },
                              child: const Icon(Icons.account_circle_sharp),
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),

                //DATI ANAGRAFICI
                Center(
                  child: Text(
                    "Dati anagrafici",
                    style:
                        GoogleFonts.lobster(fontSize: 22, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),

                Center(
                  child: SizedBox(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Column(
                        children: [
                          //nome
                          RoundedInputField(
                            icon: Icons.person_outline_sharp,
                            hintText: nome,
                            onChange: (value) {
                              nome = value;
                            },
                          ),
                          const Divider(thickness: 1.5),
                          //cognome
                          RoundedInputField(
                            icon: Icons.person_outline_sharp,
                            hintText: cognome,
                            onChange: (value) {
                              cognome = value;
                            },
                          ),
                          const Divider(thickness: 1.5),
                          //eta
                          RoundedInputField(
                            icon: Icons.person_outline_sharp,
                            hintText: Eta,
                            onChange: (value) {
                              Eta = value;
                            },
                          ),
                          const Divider(thickness: 1.5),
                          //email
                          RoundedInputField(
                            icon: Icons.contact_mail,
                            hintText: email,
                            onChange: (value) {
                              email = value;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //Informazioni sulla scuola
                Center(
                  child: Text(
                    "Istruzione",
                    style:
                        GoogleFonts.lobster(fontSize: 22, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),

                Center(
                  child: SizedBox(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Column(
                        children: [
                          //istituo frequentato
                          RoundedInputField(
                            icon: Icons.school,
                            hintText: IstitutoFrequentato,
                            onChange: (value) {
                              IstitutoFrequentato = value;
                            },
                          ),
                          const Divider(thickness: 1.5),
                          //Materia preferita
                          RoundedInputField(
                            icon: Icons.subject,
                            hintText: MateriaPreferita,
                            onChange: (value) {
                              MateriaPreferita = value;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //Su di te
                Center(
                  child: Text(
                    "Su di te",
                    style:
                        GoogleFonts.lobster(fontSize: 22, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),

                Center(
                  child: SizedBox(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Column(
                        children: [
                          //Passione
                          RoundedInputField(
                            icon: Icons.star_border,
                            hintText: Passione,
                            onChange: (value) {
                              Passione = value;
                            },
                          ),
                          const Divider(thickness: 1.5),
                          //Sport prefertio
                          RoundedInputField(
                            icon: Icons.sports_basketball_rounded,
                            hintText: SportPreferito,
                            onChange: (value) {
                              SportPreferito = value;
                            },
                          ),
                          const Divider(thickness: 1.5),
                          //Musica preferita
                          RoundedInputField(
                            icon: Icons.music_note,
                            hintText: MusicaPreferita,
                            onChange: (value) {
                              MusicaPreferita = value;
                            },
                          ),
                          const Divider(thickness: 1.5),
                          //Artista preferito
                          RoundedInputField(
                            icon: Icons.mic_rounded,
                            hintText: ArtistaPreferito,
                            onChange: (value) {
                              ArtistaPreferito = value;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        //metodo per caricare le modifiche nel db
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
                        //inizializzo variabili
                        checkforModifica = false;
                        checkScaffold = false;
                        //si rimanda all'homepage
                        Get.to(HomePageScreen());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:Color.fromARGB(255, 31, 56, 221)),
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
        body: Container(
          //si setta l'immagine di sofndo
          decoration: getBackroundImageHomePage(),
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Stack(
                    children: [
                      painters[0],
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),

                //DATI ANAGRAFICI
                Center(
                  child: Text(
                    "Dati anagrafici",
                    style:
                        GoogleFonts.lobster(fontSize: 22, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),

                Center(
                  child: SizedBox(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Column(
                        children: [
                          //nome
                          ListTile(    
                            visualDensity: VisualDensity(vertical: -4),                        
                            leading: Icon(
                              Icons.person_outline_sharp,
                              color: Colors.teal,
                            ),
                            title: Text(
                              nome,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.teal.shade900),
                            ),
                            subtitle: Text("Nome"),
                          ),

                          const Divider(thickness: 1.5),
                          //cognome
                          ListTile(
                            visualDensity: VisualDensity(vertical: -4), 
                            leading: Icon(
                              Icons.person_outline_sharp,
                              color: Colors.teal,
                            ),
                            title: Text(
                              cognome,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.teal.shade900),
                            ),
                            subtitle: Text("Cognome"),
                          ),

                          const Divider(thickness: 1.5),
                          //eta
                          ListTile(
                            visualDensity: VisualDensity(vertical: -4), 
                            leading: Icon(
                              Icons.person_outline_sharp,
                              color: Colors.teal,
                            ),
                            title: Text(
                              Eta,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.teal.shade900),
                            ),
                            subtitle: Text("Età"),
                          ),

                          const Divider(thickness: 1.5),
                          //email
                          ListTile(
                            visualDensity: VisualDensity(vertical: -2), 
                            leading: Icon(
                              Icons.contact_mail,
                              color: Colors.teal,
                            ),
                            title: Text(
                              email,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.teal.shade900),
                            ),
                            subtitle: Text("Email"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //Informazioni sulla scuola
                Center(
                  child: Text(
                    "Istruzione",
                    style:
                        GoogleFonts.lobster(fontSize: 22, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),

                Center(
                  child: SizedBox(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Column(
                        children: [
                          //istituo frequentato
                          ListTile(
                            visualDensity: VisualDensity(vertical: -4), 
                            leading: Icon(
                              Icons.school,
                              color: Colors.teal,
                            ),
                            title: Text(
                              IstitutoFrequentato,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.teal.shade900),
                            ),
                            subtitle: Text("Istituto"),
                          ),
                          const Divider(thickness: 1.5),
                          //Materia preferita
                          ListTile(
                            visualDensity: VisualDensity(vertical: -2), 
                            leading: Icon(
                              Icons.subject,
                              color: Colors.teal,
                            ),
                            title: Text(
                              MateriaPreferita,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.teal.shade900),
                            ),
                            subtitle: Text("Materia preferita"),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                //Su di te
                Center(
                  child: Text(
                    "Su di te",
                    style:
                        GoogleFonts.lobster(fontSize: 22, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),

                Center(
                  child: SizedBox(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Column(
                        children: [
                          //Passione
                          ListTile(
                            visualDensity: VisualDensity(vertical: -4), 
                            leading: Icon(
                              Icons.star_border,
                              color: Colors.teal,
                            ),
                            title: Text(
                              Passione,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.teal.shade900),
                            ),
                            subtitle: Text("Passione"),
                          ),
                          const Divider(thickness: 1.5),
                          //Sport prefertio
                          ListTile(
                            visualDensity: VisualDensity(vertical: -4), 
                            leading: Icon(
                              Icons.sports_basketball_rounded,
                              color: Colors.teal,
                            ),
                            title: Text(
                              SportPreferito,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.teal.shade900),
                            ),
                            subtitle: Text("Sport preferito"),
                          ),
                          const Divider(thickness: 1.5),
                          //Musica preferita
                          ListTile(
                            visualDensity: VisualDensity(vertical: -4), 
                            leading: Icon(
                              Icons.music_note,
                              color: Colors.teal,
                            ),
                            title: Text(
                              MusicaPreferita,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.teal.shade900),
                            ),
                            subtitle: Text("Musica preferita"),
                          ),

                          const Divider(thickness: 1.5),
                          //Artista preferito
                          ListTile(
                            visualDensity: VisualDensity(vertical: -2), 
                            leading: Icon(
                              Icons.mic_rounded,
                              color: Colors.teal,
                            ),
                            title: Text(
                              ArtistaPreferito,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.teal.shade900),
                            ),
                            subtitle: Text("Artista preferito"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        //si setta variabile
                        checkforModifica = true;
                        //si riporta alla sezione informazioni personali
                        Get.to(PersonaScreen());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 31, 56, 221)),
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

  //widget per la stampa delle informazioni
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
      return Eta = "non hai inserito alcuna descrizione";
    } else {
      return Eta = Eta.toString();
    }
  }
}
