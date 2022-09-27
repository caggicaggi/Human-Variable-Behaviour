import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/gioco_memoria/memoria_screen.dart';
import 'package:human_variable_behaviour/Screens/Application/Persona/components/background.dart';
import 'package:human_variable_behaviour/Screens/Application/Persona/components/settings_page.dart';
import 'package:human_variable_behaviour/Screens/Application/Persona/persona_screen.dart';
import 'package:human_variable_behaviour/Screens/Application/SchermataPrincipale/components/body.dart';
import 'package:human_variable_behaviour/Screens/HomePage/homepage_screen.dart';
import 'package:human_variable_behaviour/Screens/Login/components/body.dart';
import 'package:human_variable_behaviour/components/rounded_input_field.dart';
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
    checkForNotification();
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
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          //si crea pulsante per tornare alla home
          leading: IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            onPressed: () {
              checkforModifica = false;
              checkScaffold = false;
              Get.to(HomePageScreen());
            },
          ),
          //si crea pulsante per andare alle impostazioni
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
          //si inserisce l'immagine di sfondo
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
                                width: 4,
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
                //si crea la sezione per inserire il nome
                RoundedInputField(
                  icon: Icons.person,
                  hintText: "Nome ",
                  onChange: (value) {
                    nome = value;
                  },
                ),
                //si crea la sezione per inserire il cognome
                RoundedInputField(
                  icon: Icons.person,
                  hintText: "Cognome ",
                  onChange: (value) {
                    cognome = value;
                  },
                ),
                //si crea la sezione per inserire l'email
                RoundedInputField(
                  icon: Icons.email,
                  hintText: "Email ",
                  onChange: (value) {
                    email = value;
                  },
                ),
                //si crea la sezione per inserire l Istituto Frequentato
                RoundedInputField(
                  icon: Icons.school,
                  hintText: "Istituto Frequentato ",
                  onChange: (value) {
                    IstitutoFrequentato = value;
                  },
                ),
                //si crea la sezione per inserire l' Età
                RoundedInputField(
                  icon: Icons.person,
                  hintText: "Età ",
                  onChange: (value) {
                    Eta = value;
                  },
                ),
                //si crea la sezione per inserire la passione
                RoundedInputField(
                  icon: Icons.heart_broken_outlined,
                  hintText: "Passione ",
                  onChange: (value) {
                    Passione = value;
                  },
                ),
                //si crea la sezione per inserire lo Sport Preferito
                RoundedInputField(
                  icon: Icons.heart_broken_outlined,
                  hintText: "Sport Preferito ",
                  onChange: (value) {
                    SportPreferito = value;
                  },
                ), //si crea la sezione per inserire la musica preferita
                RoundedInputField(
                  icon: Icons.hearing_outlined,
                  hintText: "Musica preferita ",
                  onChange: (value) {
                    MusicaPreferita = value;
                  },
                ),
                //si crea la sezione per inserire l'Artista preferito
                RoundedInputField(
                  icon: Icons.hearing_outlined,
                  hintText: "Artista preferito ",
                  onChange: (value) {
                    ArtistaPreferito = value;
                  },
                ),
                //si crea la sezione per inserire la materia preferita
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
                        //notifica di avvenuta modifica informazioni
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
                        //si rimanda all'homepage
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
          //si crea il pulsante per tornare alla home
          leading: IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            onPressed: () {
              Get.to(HomePageScreen());
            },
          ),
          //si crea il pulsante per andare alle impostazioni
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
          //si setta l'immagine di sofndo
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
                      painters[0],
                      /*Container(
                        _painters[0],
                        
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
                            //immagine visibile nella sezione informazioni
                            shape: BoxShape.circle,
                            image: _painters[0].t),
                          
                      ),
                      */
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                //pulsante per stampare sezione nome
                buildTextField("Nome: ", nome, false),
                //pulsante per stampare sezione cognome
                buildTextField("Cognome: ", cognome, false),
                //pulsante per stampare sezione email
                buildTextField("E-mail: ", email, false),
                //pulsante per stampare sezione IstitutoFrequentato
                buildTextField(
                    "Istituto frequentato", IstitutoFrequentato, false),
                //pulsante per stampare sezione Eta, si usa il metodo per stampare
                //una stringa dato che è un intero
                buildTextField("Età: ", checkEta(), false),
                //pulsante per stampare sezione Passione
                buildTextField("Passione: ", Passione, false),
                //pulsante per stampare sezione SportPreferito
                buildTextField("Sport preferito: ", SportPreferito, false),
                //pulsante per stampare sezione MusicaPreferita
                buildTextField("Musica preferita: ", MusicaPreferita, false),
                //pulsante per stampare sezione ArtistaPreferito
                buildTextField("Artista preferito: ", ArtistaPreferito, false),
                //pulsante per stampare sezione MateriaPreferita
                buildTextField("Materia preferita: ", MateriaPreferita, false),
                SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        //si setta variabile
                        checkforModifica = true;
                        //si riporta alla sezione informazioni personali
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
      return Eta = "non hai inserito aluna descrizione";
    } else {
      return Eta = Eta.toString();
    }
  }
}
