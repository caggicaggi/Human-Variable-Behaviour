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
    //si occupa tutto lo spazio in altezza e larghezza
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              //si imposta l'immagine di sfondo
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/sfondo_games.png"),
                    fit: BoxFit.cover),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(size.height * 0.001),
                      child: Column(
                        children: <Widget>[
                          Text(
                            textAlign: TextAlign.center,
                            'Quale argomento vogliamo approfondire?',
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: size.height * 0.05,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            'SERVIZI UNICAM',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: size.height * 0.04,
                              color: const Color(0x7cdbf1ff),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          SizedBox(
                            height: size.height * 0.63,
                            child: Swiper(
                              itemCount: link.length,
                              itemWidth: MediaQuery.of(context).size.width,
                              itemHeight:
                                  MediaQuery.of(context).size.height - 2,
                              layout: SwiperLayout.STACK,
                              pagination: const SwiperPagination(
                                builder: DotSwiperPaginationBuilder(
                                    activeSize: 20,
                                    space: 10,
                                    color: Colors.blue),
                              ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, a, b) =>
                                            DetailPage(
                                          link: link[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Stack(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Card(
                                            elevation: 20,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                            ),
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.all(40),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    link[index].name,
                                                    style: TextStyle(
                                                      fontFamily: 'Avenir',
                                                      fontSize:
                                                          size.height * 0.05,
                                                      color: const Color(
                                                          0xff47455f),
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    "UNIVERSITA' CAMERINO\n",
                                                    style: TextStyle(
                                                      fontFamily: 'Avenir',
                                                      fontSize:
                                                          size.height * 0.02,
                                                      color: primaryTextColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        'Leggi di piu',
                                                        style: TextStyle(
                                                          fontFamily: 'Avenir',
                                                          fontSize:
                                                              size.height *
                                                                  0.02,
                                                          color:
                                                              secondaryTextColor,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                      Icon(
                                                        Icons.arrow_forward,
                                                        color:
                                                            secondaryTextColor,
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
                                        left: size.height * 0.38,
                                        top: size.width * 0.15,
                                        child: Text(
                                          link[index].position.toString(),
                                          style: TextStyle(
                                            fontFamily: 'Avenir',
                                            fontSize: size.height * 0.2,
                                            color:
                                                primaryTextColor.withOpacity(1),
                                            fontWeight: FontWeight.w700,
                                          ),
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
