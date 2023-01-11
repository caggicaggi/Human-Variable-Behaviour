// ignore_for_file: deprecated_member_use, sort_child_properties_last, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/SchermataPrincipale/components/background.dart';
import 'package:human_variable_behaviour/Screens/Application/SchermataPrincipale/widgets/active_project_card.dart';
import 'package:human_variable_behaviour/Screens/Application/SchermataPrincipale/widgets/second_screen.dart';
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
              radius: 40.0,
              lineWidth: 5.0,
              animation: true,
              percent: 0.50,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.red,
              backgroundColor: Colors.yellow,
              center: painters[0],
            ),
          ),

          /*
              //Container superiore
              TopContainer(
                height: size.height * 0.10,
                width: size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      
                      Container(
                        color: ,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              //Icona avatar
                              CircularPercentIndicator(
                                radius: 30.0,
                                lineWidth: 5.0,
                                animation: true,
                                percent: 0.50,
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: Colors.red,
                                backgroundColor: Colors.yellow,
                                center: painters[0],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      nome + ' ' + cognome,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                          height: size.height * 0.0002),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ]),
              ),
              */
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
                        subheading('Progressi applicazioni'),
                        Row(
                          children: <Widget>[
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
