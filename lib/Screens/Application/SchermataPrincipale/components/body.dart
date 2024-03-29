// ignore_for_file: deprecated_member_use, sort_child_properties_last, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/SchermataPrincipale/widgets/top_container.dart';
import 'package:human_variable_behaviour/constant.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

//Variabile per stringa da analizzare
String humanVariableBehaviour = '';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //Formattazione Progressi applicazioni
  Text subheading(String title) {
    return Text(title,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2));
  }
  //List<ResultData> listaRisultatiGiochi = [];

  List<ResultData> listaRisultatiGiochi = [
    ResultData(
      'Quiz',
      int.parse(Tentativi_Totali_Quiz),
      int.parse(Tentativi_Riusciti_Quiz),
    ),
    ResultData(
      'Vero o Falso',
      int.parse(Tentativi_Totali_Immagini),
      int.parse(Tentativi_Riusciti_Immagini),
    ),
    ResultData(
      'Impiccato',
      int.parse(Tentativi_Totali_Impiccato),
      int.parse(Tentativi_Riusciti_Impiccato),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: getBackroundImageHomePage(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              //Container
              TopContainer(
                height: 150,
                width: width,
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            //Avatar
                            CircularPercentIndicator(
                              radius: 60.0,
                              lineWidth: 5.0,
                              animation: true,
                              percent: variabile.toDouble() / 100,
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: Colors.white,
                              backgroundColor: Colors.transparent,
                              center: CircleAvatar(
                                backgroundColor: LightColors.kBlue,
                                radius: 50.0,
                                backgroundImage: NetworkImage(
                                    "https://api.multiavatar.com/$avatarStr.png"),
                              ),
                            ),
                            //Nome e cognome
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "$nome $cognome",
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                //Email
                                Container(
                                  child: Text(
                                    email,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Progressi Applicazioni",
                style: TextStyle(
                  fontSize: 26.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.transparent,
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: listaRisultatiGiochi.length,
                    itemBuilder: ((context, index) {
                      double percGioco = getPercGioco(index);
                      return Container(
                        height: 100,
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 18, 35, 147),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFFA5A5A5),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  listaRisultatiGiochi[index].gioco,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${listaRisultatiGiochi[index].tentativiRiusciti} / ${listaRisultatiGiochi[index].tentativiTotali} ',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          width: 100, //da inserire totalmarks
                                          height: 20,
                                          decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 143, 142, 142),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: double.parse(percGioco
                                              .toString()), // da inserire riusciti
                                          height: 20,

                                          decoration: BoxDecoration(
                                            color: getRightColor(percGioco),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double getPercGioco(int index) {
    double percGioco;
    if (listaRisultatiGiochi[index].tentativiTotali != 0) {
      percGioco = 100 *
          (listaRisultatiGiochi[index].tentativiRiusciti /
              listaRisultatiGiochi[index].tentativiTotali);
    } else {
      percGioco = 0;
    }
    return percGioco;
  }
}

Color getRightColor(double i) {
  if (i >= 0 && i <= 24) return Colors.red;
  if (i >= 25 && i <= 49) return Colors.orange;
  if (i >= 50 && i <= 74) return Colors.white;
  if (i >= 75 && i <= 100) return Colors.green;
  return Colors.white;
}

class ResultData {
  final String gioco;
  final int tentativiTotali;
  final int tentativiRiusciti;

  ResultData(this.gioco, this.tentativiTotali, this.tentativiRiusciti);
}
