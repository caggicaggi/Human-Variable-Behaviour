// ignore_for_file: deprecated_member_use, import_of_legacy_library_into_null_safe, override_on_non_overriding_member, prefer_const_constructors, library_private_types_in_public_api, use_build_context_synchronously, prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:human_variable_behaviour/Screens/HomePage/homepage_screen.dart';
import 'package:human_variable_behaviour/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../mysql/mysql.dart';
import 'package:http/http.dart' as http;
import '../../HomePage/components/body.dart';

var wordToSend = '';

class DynamicEvent extends StatefulWidget {
  const DynamicEvent({Key? key}) : super(key: key);

  //creo un nuovo stato
  @override
  _DynamicEventState createState() => _DynamicEventState();

//richiamo il body
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

class _DynamicEventState extends State<DynamicEvent> {
  //inizializzo variabili che verranno utilizzate
  bool b = false;
  late CalendarController _controller;
  late Map<DateTime, List<dynamic>> _events;
  late List<dynamic> _selectedEvents;
  late TextEditingController _eventController;
  late SharedPreferences prefs;

  //indirizzo per chiamata al sentiment analysis
  final mail = Uri(
      scheme: 'http',
      host: 'humorvarbehaviour.pythonanywhere.com',
      path: '/analysis');

  @override
  void initState() {
    //metodo che viene caricato appena si apre la pagina
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    //richiamo metodo per la lista
    prefsData();
  }

  prefsData() async {
    //calcolo lista eventi inseriti
    if (b == false) {
      DateTime dataInizioPosizione = DateTime.now();
      await listaGiornateInserite(dataInizioPosizione, idUtente);
      for (int i = 0; i < list.length; i++) {
        _selectedEvents.add(list[i].toString());
      }
      b == true;
      //pulisco la lista
      list.clear();
    }
    prefs = await SharedPreferences.getInstance();
    //setto e converto la string inserendola in Map<DateTime, List<dynamic>>
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  //converto da Map<DateTime,dynamic> a Map<String,dynamic>
  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  //converto da Map<String,dynamic> a Map<DateTime,dynamic>
  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  Widget build(BuildContext context) {
    //resetto la Map degli eventi
    _events.clear();
    return Container(
      //imposto lo sfondo della pagina
      decoration: getBackroundImageHomePage(),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  "Diario",
                  
                  style: GoogleFonts.lobster(
                      fontSize: 38,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              

              //Costruisco il calendario
              TableCalendar(
                events: _events,
                //setto il layout iniziale del calendario
                initialCalendarFormat: CalendarFormat.month,
                calendarStyle: CalendarStyle(
                    //giorni in rosso ( cioè weekend)
                    weekendStyle: TextStyle(
                      color: const Color(0xFFF44336),
                      fontSize: 19,
                    ),
                    //tutti gli altri giorni del mese corrente
                    weekdayStyle: TextStyle(
                      fontSize: 19,
                    ),
                    //giorni che si vedono del mese successivo/precedente giorni
                    outsideStyle: TextStyle(
                      color: const Color(0xFF9E9E9E),
                      fontSize: 20,
                    ),
                    //giorni che si vedono del mese successivo/precedente weekend
                    outsideWeekendStyle: TextStyle(
                      color: const Color(0xFFEF9A9A),
                      fontSize: 20,
                    ),
                    canEventMarkersOverflow: false,
                    //giorno corrente
                    todayColor: Colors.blue,
                    selectedColor: Theme.of(context).primaryColor,
                    //dimensione giorno corrente
                    todayStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19.0,
                        color: Colors.white)),
                headerStyle: HeaderStyle(
                  centerHeaderTitle: true,
                  //bottone che appare quando si selezione la data
                  formatButtonDecoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  formatButtonTextStyle:
                      TextStyle(color: Colors.white, fontSize: 18),
                  formatButtonShowsNext: false,
                ),
                startingDayOfWeek: StartingDayOfWeek.monday,
                onDaySelected: (date, events, holidays) async {
                  //pulisco events
                  events.clear();
                  //calcolo lista eventi
                  await listaGiornateInserite(date, idUtente);
                  /* converto la lista della query di formato String
                nella lista in formato dynamic */
                  events = List<dynamic>.from(list);
                  // setto gli eventi per stamparli nella schermata
                  setState(() {
                    _selectedEvents = events;
                  });
                },
                builders: CalendarBuilders(
                  selectedDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(19.0)),
                      //setto la data che si seleziona
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 19),
                      )),
                  todayDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(19.0)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                calendarController: _controller,
              ),
              //stampo valori contenuti in _selectedEvents presi da events
              ..._selectedEvents.map((event) => Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width / 1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                          border: Border.all(color: Colors.white)),
                      child: Center(
                          //stampo descrizione
                          child: Text(
                        event,
                        style: GoogleFonts.akayaTelivigala(fontSize: 18),
                        textAlign: TextAlign.center,
                      )),
                    ),
                  )),
            ],
          ),
        ),
        //pulsante per inserire la descrizione della giornata
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(Icons.add_comment_sharp),
          onPressed: _showAddDialog,
        ),
      ),
    );
  }

//Schermata per inserire descrizione giornata
  _showAddDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Qui puoi raccontare la tua giornata: "),
          content: SizedBox(
            height: 160,
            width: 400,
            child: TextField(
              maxLines: 20,
              controller: _eventController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.teal)),
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  child: Text(
                    textAlign: TextAlign.left,
                    "Torna Indietro",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 54, 143, 244),
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text(
                    "Inserisci giornata",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 54, 143, 244),
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    //update giornata inserita
                    await signDataAndGiornata(idUtente, _controller.selectedDay,
                        _eventController.text);

                    //salvo la frase da inviare
                    wordToSend = _eventController.text;

                    //ricalcolo lista
                    await listaGiornateInserite(
                        _controller.selectedDay, idUtente);

                    //se la lista non è vuota
                    if (list.isNotEmpty) {
                      _selectedEvents.clear();
                    }
                    //assegno la lista alla variabile _selectedEvents
                    for (int i = 0; i < list.length; i++) {
                      _selectedEvents.add(list[i].toString());
                    }

                    //ristampo la lista aggiornata
                    _selectedEvents.map((list) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 7,
                            width: MediaQuery.of(context).size.width / 1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                border: Border.all(color: Colors.white)),
                            //stampo la lista
                            child: Center(
                                child: Text(
                              list.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )),
                          ),
                        ));

                    //Controllo e salvataggio dati inseriti
                    if (_eventController.text.isEmpty) return;
                    setState(() {
                      if (_events[_controller.selectedDay] != null) {
                        _events[_controller.selectedDay]
                            ?.add(_eventController.text);
                      } else {
                        _events[_controller.selectedDay] = [
                          _eventController.text
                        ];
                      }
                      //aggiungo la stringa a Map<DateTime,List<String>>
                      prefs.setString(
                          "events", json.encode(encodeMap(_events)));

                      _eventController.clear();
                    });

                    //aggiorno rimanendo nell'inserimento della giornata
                    Navigator.of(context).pop();

                    //Invio la frase al sentiment analysis
                    final response = await http.post(mail,
                        body: json.encode({'text': wordToSend}));
                    final decoded =
                        json.decode(response.body) as Map<String, dynamic>;
                    var finalResponse = decoded['sentiment'] +
                        '/' +
                        decoded['emotion'] +
                        decoded['numericResp_sen'];

                    /* Sottraggo o aggiungo il valore alla variabile
                    che corrisponde alla polarità (sentiment) contenuto nella response
                    quindi se +1 sarà positive altrimenti negative*/
                    //  await updateVariable(
                    //      idUtente, int.parse(decoded['numericResp_sen']));

                    /*Controllo che tipo di emozione ho come ritorno e
                    se corrisponde a:
                    joy       aggiungo 2
                    sadness   sottraggo 3
                    anger     sottraggo 2 
                    fear      sottraggo 1 
                    */

                    //splitto le parole e la polarità ottenute
                    List<String> splitted = decoded['emotion'].split('.');
                    List<String> splittedNumber =
                        decoded['numericResp_sen'].split('.');
                    //Prendo la variabile
                    await getVariabile();
                    print("Valore Variabile:  " + variabile.toString());
                    //controllo il ritorno dell'analysis per modificare la variabile
                    for (int i = 0; i < splitted.length; i++) {
                      await getVariabile();
                      print("Frase(" +
                          i.toString() +
                          ") : " +
                          variabile.toString());
                      if (splitted[i] == "joy") {
                        print("Emozione: " + splitted[i]);
                        await updateVariable(
                            idUtente, 2 + int.parse(splittedNumber[i]));
                      }
                      if (splitted[i] == "sadness") {
                        print("Emozione: " + splitted[i]);
                        await updateVariable(
                            idUtente, -3 + int.parse(splittedNumber[i]));
                      }
                      if (splitted[i] == "anger") {
                        print("Emozione: " + splitted[i]);
                        await updateVariable(
                            idUtente, -2 + int.parse(splittedNumber[i]));
                      }
                      if (splitted[i] == "fear") {
                        print("Emozione: " + splitted[i]);
                        await updateVariable(
                            idUtente, -1 + int.parse(splittedNumber[i]));
                      }
                    }
                    await getVariabile();
                    print("Variabile aggiornata: " + variabile.toString());
                    
                  },
                ),
              ],
            )
          ]),
    );
  }
}
