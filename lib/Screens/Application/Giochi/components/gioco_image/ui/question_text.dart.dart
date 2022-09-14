import 'package:flutter/material.dart';

class QuestionTextWithImage extends StatefulWidget {
  final String _question;
  final String _img;

  QuestionTextWithImage(this._question, this._img);
  @override
  _QuestionTextWithImageState createState() => _QuestionTextWithImageState();
}

class _QuestionTextWithImageState extends State<QuestionTextWithImage>
    with SingleTickerProviderStateMixin {
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

  //PERMETTE DI POTER VEDERE LA DOMANDA

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1),
        child: Center(
            child: Column(
          children: <Widget>[
            Image.asset(widget._img,
                alignment: Alignment.topCenter, width: size.width * 0.6),
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
