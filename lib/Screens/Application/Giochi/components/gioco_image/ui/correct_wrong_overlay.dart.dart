import 'package:flutter/material.dart';

class CorrectWrongOverlay extends StatefulWidget {
  //si inizializzano le variabili
  final bool isCorrect;
  final VoidCallback _onTap;

  //si crea l'oggetto
  CorrectWrongOverlay(this.isCorrect, this._onTap);

  //si setta lo stato
  @override
  _CorrectWrongOverlayState createState() => _CorrectWrongOverlayState();
}

class _CorrectWrongOverlayState extends State<CorrectWrongOverlay>
    with SingleTickerProviderStateMixin {
  //si inizializzano le variabili
  Animation<double>? _iconAnimation;
  AnimationController? _iconAnimationController;

  @override
  void initState() {
    super.initState();
    //inizializzo l'animation controller
    _iconAnimationController = new AnimationController(
        duration: new Duration(seconds: 2), vsync: this);
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController!, curve: Curves.elasticOut);
    _iconAnimation!.addListener(() => this.setState(() {}));
    _iconAnimationController!.forward();
  }

  @override
  void dispose() {
    _iconAnimationController!.dispose();
    super.dispose();
  }

  // PERMETTE DI VEDERE IL RISULTATO DELLA RISPOSTA
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: InkWell(
        onTap: () => widget._onTap(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: Transform.rotate(
                angle: _iconAnimation!.value * 2 * 3.1416,
                child: Icon(
                  widget.isCorrect ? Icons.done : Icons.clear,
                  size: _iconAnimation!.value * 80.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
            ),
            // testo che appare dopo aver risposto alla domanda
            Text(
              widget.isCorrect ? "Giustooo!" : "No hai sbagliatoo!",
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
            Text(
              "Premi per andare avanti",
              style: TextStyle(color: Colors.white, fontSize: 13.0),
            )
          ],
        ),
      ),
    );
  }
}
