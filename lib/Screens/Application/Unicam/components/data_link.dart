class Infolink {
  final int position;
  final String name;
  final String iconImage;
  final String description;
  final List<String> images;

  Infolink(
    this.position, {
    required this.name,
    required this.iconImage,
    required this.description,
    required this.images,
  });
}

List<Infolink> link = [
  Infolink(1,
      name: 'Area dello Studente',
      iconImage: 'assets/images/myUnicamLogo.jpg',
      description: "QUI VA INSERITA UNA DESCRIZIONE",
      images: [
        //Immagini che andranno inserite quando si clicca
        // 'https://cdn.pixabay.com/photo/2013/07/18/10/57/mercury-163610_1280.jpg',
        //'https://cdn.pixabay.com/photo/2014/07/01/11/38/planet-381127_1280.jpg',
        // 'https://cdn.pixabay.com/photo/2015/06/26/18/48/mercury-822825_1280.png',
        // 'https://image.shutterstock.com/image-illustration/mercury-high-resolution-images-presents-600w-367615301.jpg'
      ]),
  Infolink(2,
      name: 'Sito Ufficale Unicam',
      iconImage: 'assets/images/myUnicamLogo.jpg',
      description: "QUI VA INSERITA UNA DESCRIZIONE",
      images: [
        //Immagini che andranno inserite quando si clicca
        //'https://cdn.pixabay.com/photo/2011/12/13/14/39/venus-11022_1280.jpg',
        //'https://image.shutterstock.com/image-photo/solar-system-venus-second-planet-600w-515581927.jpg'
      ]),
  Infolink(3,
      name: 'Portale della Didattica',
      iconImage: 'assets/images/myUnicamLogo.jpg',
      description: "QUI VA INSERITA UNA DESCRIZIONE",
      images: [
        //Immagini da scegliere che andranno inserite quando si clicca
        // 'https://cdn.pixabay.com/photo/2011/12/13/14/31/earth-11015_1280.jpg',
        // 'https://cdn.pixabay.com/photo/2011/12/14/12/11/astronaut-11080_1280.jpg',
        // 'https://cdn.pixabay.com/photo/2016/01/19/17/29/earth-1149733_1280.jpg',
        // 'https://image.shutterstock.com/image-photo/3d-render-planet-earth-viewed-600w-1069251782.jpg'
      ]),
  Infolink(4,
      name: 'Informazioni generali',
      iconImage: 'assets/images/myUnicamLogo.jpg',
      description: "QUI VA INSERITA UNA DESCRIZIONE",
      images: []),
];
