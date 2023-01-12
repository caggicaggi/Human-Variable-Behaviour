// ignore_for_file: deprecated_member_use, sort_child_properties_last, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:human_variable_behaviour/Screens/Application/SchermataPrincipale/components/background.dart';
import 'package:human_variable_behaviour/Screens/Application/SchermataPrincipale/widgets/active_project_card.dart';
import 'package:human_variable_behaviour/Screens/Application/SchermataPrincipale/widgets/second_screen.dart';
import 'package:human_variable_behaviour/Screens/Application/Unicam/components/const.dart';
import 'package:human_variable_behaviour/services/local_notification_service.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:random_avatar/random_avatar.dart';

//Variabile per stringa da analizzare
String humanVariableBehaviour = '';

//?
final List<Widget> painters = <Widget>[];

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late final LocalNotificationService service;
  @override
  void initState() {
    service = LocalNotificationService();
    service.intialize();
    //listenToNotification();
    super.initState();
  }

  Text subheading(String title) {
    return Text(title,
        style: const TextStyle(
            color: Color.fromARGB(255, 42, 48, 223),
            fontSize: 25.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2));
  }

  @override
  Widget build(BuildContext context) {
    String svg = randomAvatarString(
      DateTime.now().toIso8601String(),
      trBackground: true,
    );
    //Lo aggiunto alla lista
    painters.add(randomAvatar(
      svg,
      height: 100,
      width: 90,
    ));

    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        children: <Widget>[
          //Spaziatura
          SizedBox(
            height: size.height * 0.05,
          ),
          //Icona avatar
          Container(
            width: size.width,
            color: Colors.transparent,
            child: CircularPercentIndicator(
              radius: 50.0,
              lineWidth: 5.0,
              animation: true,
              percent: 0.5,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.red,
              backgroundColor: Colors.transparent,
              center: painters[0],
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Center(
            child: Text(
              "Progressi applicazioni",
              style: GoogleFonts.lobster(fontSize: 32, color: Colors.white),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            ActiveProjectsCard(
                              cardColor: Colors.orange,
                              loadingPercent: double.parse(Percentuale_Quiz),
                              title: "Percentuale vittoria quiz",
                              //subtitle: '20 hours progress',
                            ),
                            ActiveProjectsCard(
                              cardColor: Colors.red,
                              loadingPercent:
                                  double.parse(Percentuale_Immagini),
                              title:
                                  "Percentuale vittoria gioco delle immagini",
                              //subtitle: '20 hours progress',
                            ),
                            ActiveProjectsCard(
                              cardColor: Colors.green,
                              loadingPercent:
                                  double.parse(Percentuale_Impiccato),
                              title:
                                  "Percentuale vittoria gioco dell'impiccato",
                              //subtitle: '9 hours progress',
                            ),

                            /*
                                ElevatedButton(
                                  onPressed: () async {
                                    await service.showNotification(
                                        id: 0,
                                        title: 'Notification Title',
                                        body: 'Some body');
                                  },
                                  child: const Text('Show Local Notification'),
                                ),
                                
                                ElevatedButton(
                                  onPressed: () async {
                                    await service.showScheduledNotification(
                                      id: 0,
                                      title: 'Notification Title',
                                      body: 'Some body',
                                      seconds: 4,
                                    );
                                  },
                                  child:
                                      const Text('Show Scheduled Notification'),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await service.showNotificationWithPayload(
                                        id: 0,
                                        title: 'Notification Title',
                                        body: 'Some body',
                                        payload: 'payload navigation');
                                  },
                                  child: const Text(
                                      'Show Notification With Payload'),
                                ), */
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Card(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              elevation: 50,
                              shadowColor: Colors.black,
                              color: Colors.greenAccent[100],
                              child: SizedBox(
                                width: size.width * 0.85,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      //CircleAvatar
                                      const SizedBox(
                                        height: 10,
                                      ), //SizedBox
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Human Variable Behaviour',
                                          style: TextStyle(
                                            fontSize: 28,
                                            color: Colors.blue[900],
                                            fontWeight: FontWeight.w500,
                                          ),

                                          //Textstyle
                                        ),
                                      ), //Text
                                      const SizedBox(
                                        height: 5,
                                      ), //SizedBox
                                      const Text(
                                        'Obbiettivo del progetto',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.blue,
                                        ), //Textstyle
                                      ), //Text
                                      const SizedBox(
                                        height: 10,
                                      ), //SizedBox
                                      SizedBox(
                                        width: 100,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SecondRoute()),
                                            );
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.blue)),
                                          child: Center(
                                            child: Row(
                                              children: const [
                                                Icon(Icons.touch_app),
                                                Text('Scopri'),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);

  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => SecondScreen(payload: payload))));
    }
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Human Variable Behaviour'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                obbiettivoProgetto,
                maxLines: 2222,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 14,
                  color: contentTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Torna indietro'),
            ),
          ],
        ),
      ),
    );
  }
}
