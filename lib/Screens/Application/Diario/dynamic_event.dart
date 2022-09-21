// ignore_for_file: deprecated_member_use, import_of_legacy_library_into_null_safe, override_on_non_overriding_member, prefer_const_constructors

import 'dart:convert';
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:human_variable_behaviour/Screens/HomePage/homepage_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../mysql/mysql.dart';
import '../../HomePage/components/body.dart';

class DynamicEvent extends StatefulWidget {
  @override
  _DynamicEventState createState() => _DynamicEventState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

class _DynamicEventState extends State<DynamicEvent> {
  bool b = false;
  late CalendarController _controller;
  late Map<DateTime, List<dynamic>> _events;
  late List<dynamic> _selectedEvents;
  late TextEditingController _eventController;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    prefsData();
  }

  prefsData() async {
    //calcolo lista
    if (b == false) {
      DateTime dataInizioPosizione = DateTime.now();
      await listaGiornateInserite(dataInizioPosizione, idUtente);
      for (int i = 0; i < list.length; i++) {
        _selectedEvents.add(list[i].toString());
      }
      b == true;
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
    //resetto la Map
    _events.clear();
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/sfondo_games.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            backgroundColor: Colors.blue,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomePageScreen();
                    },
                  ),
                );
              },
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(30.0),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'ECCO IL TUO DIARIO PERSONALE ',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.akayaTelivigala(
                          fontSize: 30, color: Colors.white),
                    ),
                    Text(
                      "Raccontami una tua giornata",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.akayaTelivigala(
                          fontSize: 22, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TableCalendar(
                events: _events,
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
                    todayColor: Colors.blue,
                    selectedColor: Theme.of(context).primaryColor,
                    todayStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19.0,
                        color: Colors.white)),
                headerStyle: HeaderStyle(
                  centerHeaderTitle: true,
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
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                  todayDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10.0)),
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
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          border: Border.all(color: Colors.white)),
                      child: Center(
                          child: Text(
                        event,
                        style: GoogleFonts.akayaTelivigala(fontSize: 23),
                        textAlign: TextAlign.center,
                      )),
                    ),
                  )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(Icons.add_comment_sharp),
          onPressed: _showAddDialog,
        ),
      ),
    );
  }

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
              decoration: new InputDecoration(
                border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: new BorderSide(color: Colors.teal)),
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
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
                FlatButton(
                  child: Text(
                    "Inserisci giornata",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 54, 143, 244),
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                    //update giornata inserita
                    await signDataAndGiornata(idUtente, _controller.selectedDay,
                        _eventController.text);
                    await listaGiornateInserite(
                        _controller.selectedDay, idUtente);
                    if (list.isNotEmpty) {
                      _selectedEvents.clear();
                    }
                    for (int i = 0; i < list.length; i++) {
                      print(list[0]);
                      _selectedEvents.add(list[i].toString());
                    }
                    await _selectedEvents.map((list) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 7,
                            width: MediaQuery.of(context).size.width / 1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                border: Border.all(color: Colors.white)),
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
                  },
                ),
              ],
            )
          ]),
    );
  }
}
