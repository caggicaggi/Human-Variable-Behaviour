// ignore_for_file: deprecated_member_use, sort_child_properties_last, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:human_variable_behaviour/Screens/Application/SchermataPrincipale/components/background.dart';
import 'package:human_variable_behaviour/Screens/Application/SchermataPrincipale/widgets/active_project_card.dart';
import 'package:human_variable_behaviour/Screens/Application/SchermataPrincipale/widgets/second_screen.dart';
import 'package:human_variable_behaviour/services/local_notification_service.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

//Variabile per stringa da analizzare
String humanVariableBehaviour = '';

//Lista per salvare gli avatar randomici
final List<Widget> painters = <Widget>[];

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //Notifiche
  late final LocalNotificationService service;
  @override
  void initState() {
    service = LocalNotificationService();
    service.intialize();
    //listenToNotification();
    super.initState();
  }

  //Formattazione Progressi applicazioni
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
              radius: 60.0,
              lineWidth: 5.0,
              animation: true,
              percent: variabile.toDouble() / 100,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.red,
              backgroundColor: Colors.transparent,
              center: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      "https://api.multiavatar.com/$avatarStr.png")),
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Center(
            child: Text(
              "Progressi applicazioni",
              style: GoogleFonts.montserrat(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
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
                              title: "Quiz GAME",
                            ),
                            ActiveProjectsCard(
                              cardColor: Colors.red,
                              loadingPercent:
                                  double.parse(Percentuale_Immagini),
                              title: "True or False GAME",
                            ),
                            ActiveProjectsCard(
                              cardColor: Colors.green,
                              loadingPercent:
                                  double.parse(Percentuale_Impiccato),
                              title: " Gioco dell'Impiccato",
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
