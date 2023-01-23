import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/choice_screen/game_screen.dart';
import '../choice_screen/models/games_model.dart';
import 'widgets/games_list_item.dart';

class HomeScreenChoiceGames extends StatelessWidget {
  const HomeScreenChoiceGames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Game> games = Game.games;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: Colors.transparent,
          ),
        ),
        flexibleSpace: ClipPath(
          clipper: _CustomClipper(),
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFF122393),
            child: Center(
              child: Text(
                'Giochi',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 120.0,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            for (final game in games)
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GameScreen(game: game)));
                },
                child: GameListItem(
                  imageUrl: game.imagePath,
                  name: game.name,
                  information: '${game.difficolta} | ${game.category} ',
                ),
              ),
          ]),
        ),
      ),
    );
  }
}

class _CustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var path = Path();
    //from the bottom left to the bottom appBar
    path.lineTo(0, height - 50);
    //create the curved line in the appBar
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    throw UnimplementedError();
  }
}
