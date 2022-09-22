import 'package:flutter/material.dart';

class QuestionTextWithImage extends StatefulWidget {
  //si inizializzano le variabili
  final String _question;
  final String _img;

  //si crea oggetto
  QuestionTextWithImage(this._question, this._img);

  //si crea lo stato
  @override
  _QuestionTextWithImageState createState() => _QuestionTextWithImageState();
}

class _QuestionTextWithImageState extends State<QuestionTextWithImage>
    with SingleTickerProviderStateMixin {
  //si inizializzano le variabili
  late Animation<double> _fontSizeAnimation;
  late AnimationController _fontSizeAnimationController;

  @override
  void initState() {
    super.initState();
    _fontSizeAnimationController = new AnimationController(
        duration: new Duration(
          milliseconds: 500,
        ),
        vsync: this);
    _fontSizeAnimation = new CurvedAnimation(
        parent: _fontSizeAnimationController, curve: Curves.bounceOut);
    _fontSizeAnimation.addListener(() => this.setState(() {}));
    _fontSizeAnimationController.forward();
  }

  @override
  void dispose() {
    _fontSizeAnimationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(QuestionTextWithImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget._question != widget._question) {
      _fontSizeAnimationController.reset();
      _fontSizeAnimationController.forward();
    }
  }

  //PERMETTE DI POTER STAMPARE LA DOMANDA
  @override
  Widget build(BuildContext context) {
    // si occupa tutto lo schermo in lunghezza e altezza
    Size size = MediaQuery.of(context).size;
    return Material(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1),
        child: Center(
            child: Column(
          //si stampa immagine
          children: <Widget>[
            Image.asset(widget._img,
                alignment: Alignment.topCenter, width: size.width * 0.6),
            //si stampa domanda
            Text(
              "${widget._question}",
              style: TextStyle(
                  fontSize: _fontSizeAnimation.value * 25,
                  fontFamily: "Pacifico"),
            ),
          ],
        )),
      ),
    );
  }
}
