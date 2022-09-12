import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:human_variable_behaviour/Screens/Application/Unicam/components/background.dart';
import 'package:human_variable_behaviour/Screens/Application/Unicam/components/const.dart';
import 'package:human_variable_behaviour/Screens/Application/Unicam/components/data_link.dart';
import 'package:human_variable_behaviour/Screens/Application/Unicam/components/details.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/sfondo_games.png"),
                      fit: BoxFit.cover),
                  gradient: LinearGradient(
                      colors: [gradientStartColor, gradientEndColor],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.9, 1.1])),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            textAlign: TextAlign.center,
                            'SCEGLI COSA VUOI VEDERE',
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: 44,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            'SERVIZI UNICAM',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: 25,
                              color: const Color(0x7cdbf1ff),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 610,
                      padding: const EdgeInsets.only(),
                      child: Swiper(
                        itemCount: link.length,
                        itemWidth: MediaQuery.of(context).size.width - 2 * 64,
                        layout: SwiperLayout.STACK,
                        pagination: SwiperPagination(
                          builder: DotSwiperPaginationBuilder(
                              activeSize: 20, space: 10, color: Colors.blue),
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, a, b) => DetailPage(
                                    link: link[index],
                                  ),
                                ),
                              );
                            },
                            child: Stack(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    SizedBox(height: 100),
                                    Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(32.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 200,
                                              height: 20,
                                            ),
                                            Text(
                                              link[index].name,
                                              style: TextStyle(
                                                fontFamily: 'Avenir',
                                                fontSize: 40,
                                                color: const Color(0xff47455f),
                                                fontWeight: FontWeight.w900,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(
                                              "UNIVERSITA' CAMERINO",
                                              style: TextStyle(
                                                fontFamily: 'Avenir',
                                                fontSize: 23,
                                                color: primaryTextColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            SizedBox(height: 20),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  'Leggi di piu',
                                                  style: TextStyle(
                                                    fontFamily: 'Avenir',
                                                    fontSize: 18,
                                                    color: secondaryTextColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward,
                                                  color: secondaryTextColor,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //Qui si possono inserire le immagini
                                /*Hero(
                              tag: planets[index].position,
                              child: Image.asset(
                                planets[index].iconImage,
                                height: 120,
                                width: 400,
                              )),*/
                                //POSIZIONE NUMERO SULLO SFONDO
                                Positioned(
                                  right: 0,
                                  left: 180,
                                  top: 190,
                                  bottom: 60,
                                  child: Text(
                                    link[index].position.toString(),
                                    style: TextStyle(
                                      fontFamily: 'Avenir',
                                      fontSize: 200,
                                      color: primaryTextColor.withOpacity(0.5),
                                      fontWeight: FontWeight.w900,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
