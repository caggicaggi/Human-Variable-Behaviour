// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors, unused_local_variable
import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/SchermataPrincipale/components/background.dart';
import 'package:human_variable_behaviour/Screens/Application/SchermataPrincipale/widgets/top_container.dart';
import 'package:human_variable_behaviour/constant.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: kPrimaryColor,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: kPrimaryLightColor,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    //Occupo tutto lo schermo sia in altezza che in lunghezza
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Align(
        alignment: Alignment.topRight,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TopContainer(
                height: size.height * 0.32,
                width: size.width,
                padding: EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            //Avatar
                            CircularPercentIndicator(
                              radius: 80.0,
                              lineWidth: 10.0,
                              animation: true,
                              percent: 0.80,
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: Color.fromARGB(255, 46, 34, 180),
                              backgroundColor: Colors.white,
                              center: CircleAvatar(
                                backgroundColor: kPrimaryLightColor,
                                radius: 50.0,
                                backgroundImage: NetworkImage(
                                    'https://www.woolha.com/media/2020/03/eevee.png'),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                //Scritta benvenuto
                                Container(
                                  child: Text(
                                    'Benvenuto!',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                //Scritta Nome e Cognome
                                Container(
                                  child: Text(
                                    nome + ' ' + cognome,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
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
            ],
          ),
        ),
      ),
    );
  }
}
