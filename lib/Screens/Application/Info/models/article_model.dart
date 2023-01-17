import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String body;
  final String author;
  final String authorImageUrl;
  final String category;
  final String imageUrl;
  final int views;
  final DateTime createdAt;

  const Article(    {
    required this.id,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.author,
    required this.authorImageUrl,
    required this.category,
    required this.imageUrl,
    required this.views,
    required this.createdAt,
  });

  static List<Article> articles = [
    Article(
    id: '1',
    title: 'titolo1', 
    subtitle: 'sottotitolo1',     
      body:"Sono poche le vittime di bullismo che riescono a parlare liberamente del loro problema con una persona adulta. Si prova vergogna, si ha paura di non essere creduti o, peggio, si è stati minacciati di non farlo. Il bullismo vive di omertà: non aver mai paura di chiedere auto. Bisogna avere coraggio di denunciare. Chi si fa difendere da un genitore non è uno sfigato. Al contrario è importante poter parlare con genitori e adulti di cui ti fidi delle prepotenze subite. Soprattutto se non si tratta di episodi, ma di situazioni che si ripetono quotidiatitlente. Denunciare un atto di bullismo è il primo passo per far cessare una prepotenza e un monito per chi considera la scuola un gioco, piuttosto che uno spazio di crescita personale. Denunciare non significa fare la spia ma aiutare chi è in difficoltà. La scuola è un logo dove tutti hanno diritto a star bene e sentirsi protetti, sicuri. La classe, come la famiglia, dovrebbe essere un ambiente in cui ciascuno può sentirsi al sicuro, protetto. Avere la possibilità di crescere imparando è un diritto e un dovere. Come un diritto e un dovere è stare bene a scuola. A scuola c'è sempre un professore o una professoressa a cui puoi chiedere aiuto se hai visto o subito atti di prepotenza: in ogni scuola è presente un/a referente su bullismo e cyberbullismo che è preparato/a per affrontare il problema. Grazie alla tua denuncia la scuola può intervenire per interrompere le prepotenze e far intervenire un/a psicologo/a",
      author: 'Autore1',
      authorImageUrl: '',
      category: 'Categoria1',
      views: 100,
      imageUrl:'https://www.casadellostudente.net/wp-content/uploads/2018/08/bullismo-e-genitori-1024x576.jpg',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),        
      ),
  Article(
    id: '2',
    title: 'titolo2', 
    subtitle: 'sottotitolo2',     
    body: 'body2',
    author: 'Autore2',
    authorImageUrl: '',
    category: 'Categoria2',
    views: 100,
    imageUrl:'https://mondoconnessi.it/wp-content/uploads/2017/01/evisserotuttifelicieconnessi.jpg',
    createdAt: DateTime.now().subtract(const Duration(hours: 5)),),
  Article(
    id: '3',
      title: 'titolo3', 
      subtitle: 'sottotitolo3',     
      body: 'body3',
      author: 'Autore3',
      authorImageUrl: '',
      category: 'Categoria3',
      views: 100,
      imageUrl:'https://www.nostrofiglio.it/site_stored/imgs/0004/022/famigliafelice.jpg',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),),
  Article(
    id: '4',
      title: 'titolo4', 
      subtitle: 'sottotitolo4',     
      body:'body4',
      author: 'Autore4',
      authorImageUrl: '',
      category: 'Categoria4',
      views: 100,
      imageUrl:'https://images.agi.it/pictures/agi/agi/2021/03/30/101356689-b97ec7fc-ce0c-4653-bcf4-eab488fe04df.png',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),),
  ];

  @override
  List<Object?> get props => [
    id,
    title,
    subtitle,
    body,
    author,
    authorImageUrl,
    category,
    imageUrl,
    views,
    createdAt,
  ];
}
