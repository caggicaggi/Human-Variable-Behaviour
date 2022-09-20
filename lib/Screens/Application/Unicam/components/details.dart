import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Unicam/components/const.dart';
import 'package:human_variable_behaviour/Screens/Application/Unicam/components/data_link.dart';
import 'package:human_variable_behaviour/Screens/Application/Unicam/unicam_screen.dart';
import 'package:human_variable_behaviour/Screens/HomePage/homepage_screen.dart';

class DetailPage extends StatelessWidget {
  final Infolink link;

  const DetailPage({Key? key, required this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Occupo tutto lo schermo sia in altezza che in lunghezza
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          link.name,
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: size.height * 0.09,
                            color: primaryTextColor,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'SERVIZI UNICAM',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: size.height * 0.03,
                            color: primaryTextColor,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Divider(color: Colors.black38),
                        Text(
                          link.description,
                          maxLines: 2222,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: size.height * 0.02,
                            color: contentTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Divider(color: Colors.black38),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Text(
                      'Gallery',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: size.height * 0.03,
                        color: const Color(0xff47455f),
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    height: size.height * 0.43,
                    padding: const EdgeInsets.only(left: 32),
                    child: ListView.builder(
                        itemCount: link.images.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(size.height * 0.01),
                            ),
                            child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  link.images[index],
                                  fit: BoxFit.cover,
                                )),
                          );
                        }),
                  ),
                ],
              ),
            ),
            /* Positioned(
              top: size.height,
              left: size.width,
              child: Text(
                link.position.toString(),
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 247,
                  color: primaryTextColor.withOpacity(0.08),
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.left,
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
