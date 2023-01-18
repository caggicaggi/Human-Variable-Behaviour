import 'package:flutter/material.dart';
import 'package:human_variable_behaviour/Screens/Application/Info/article_screen.dart';
import 'package:human_variable_behaviour/Screens/Application/Info/widgets/custom_tag.dart';
import 'package:human_variable_behaviour/Screens/Application/Info/widgets/image_container.dart';
import 'package:human_variable_behaviour/Screens/Application/Info/models/article_model.dart';

class InfoHomeScreen extends StatelessWidget {
  const InfoHomeScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    Article article = Article.articles[0];
    return Scaffold(
      //App bar trasparente con menu ad hamburger
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: Colors.transparent,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _NewsOfTheDay(article: article),
          _BreakingNews(articles: Article.articles)
        ],
      ),
    );
  }
}

//parte superiore della schermata
class _NewsOfTheDay extends StatelessWidget {
  const _NewsOfTheDay({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return ImageContainer(
      height: MediaQuery.of(context).size.height * 0.45,
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      imageUrl: article.imageUrl,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTag(backgroundColor: Colors.grey.withAlpha(150), children: [
              Text(
                'Bullismo',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
              )
            ]),
            const SizedBox(height: 10),
            Text(
              article.title,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.25,
                  color: Colors.white),
            ),
            //tasto learn more
            TextButton(
                //onPressed Learn More per aprire articolo
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    ArticleScreen.routeName,
                    arguments: article,
                  );
                  //Navigator.of(context).push(MaterialPageRoute(
                  //                    builder: (context) => const ArticleScreen()));
                },
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                child: Row(
                  children: [
                    Text(
                      'Scopri di più',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white),
                    ),
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.arrow_right_alt,
                      color: Colors.white,
                    )
                  ],
                ))
          ]),
    );
  }
}

//Parte inferiore della schermata
class _BreakingNews extends StatelessWidget {
  const _BreakingNews({
    Key? key,
    required this.articles,
  }) : super(key: key);

  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Articoli',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              //Text('More news', style: Theme.of(context).textTheme.bodyLarge!),
            ],
          ),
          const SizedBox(height: 20),
          //immagini con titoli a scorrimento orizzontale
          SizedBox(
            height: 250,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      margin: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        //onTap per aprire gli articoli dalle immagini passando l'indice dell'articolo
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ArticleScreen.routeName,
                            arguments: articles[index],
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ImageContainer(
                                width: MediaQuery.of(context).size.width * 0.5,
                                imageUrl: articles[index].imageUrl),
                            const SizedBox(height: 10),
                            Text(
                              articles[index].title,
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.bold, height: 1.5),
                            ),
                            const SizedBox(height: 5),
                            Text(
                                '${DateTime.now().difference(articles[index].createdAt).inHours} hours ago',
                                style: Theme.of(context).textTheme.bodySmall!),
                            const SizedBox(height: 5),
                            Text('by ${articles[index].author}',
                                style: Theme.of(context).textTheme.bodySmall!),
                          ],
                        ),
                      ));
                }),
          ),
        ],
      ),
    );
  }
}
