class MyClassModel {
  MyClassModel({
    this.imagePath = '',
    this.titleTxt = '',
    this.dist = 1.8,
    this.reviews = 80,
    this.rating = 4.5,
    this.price = 180,
    this.subTxt = "",
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  double dist;
  double rating;
  int reviews;
  int price;

  static List<MyClassModel> myClassList = <MyClassModel>[
    MyClassModel(
      imagePath: 'assets/images/infra.jpg',
      titleTxt: 'Infraestrutura',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      price: 180,
    ),
    MyClassModel(
      imagePath: 'assets/images/uiux.png',
      titleTxt: 'Ui/UX',
      dist: 4.0,
      reviews: 74,
      rating: 4.5,
      price: 200,
    ),
    MyClassModel(
      imagePath: 'assets/images/programacao.jpg',
      titleTxt: 'Programação',
      dist: 3.0,
      reviews: 62,
      rating: 4.0,
      price: 60,
    ),
    MyClassModel(
      imagePath: 'assets/images/php.jpg',
      titleTxt: 'Curso de PHP',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      price: 170,
    ),
    MyClassModel(
      imagePath: 'assets/images/mktdigital.jpg',
      titleTxt: 'Marketing Digital',
      dist: 2.0,
      reviews: 240,
      rating: 4.5,
      price: 200,
    ),
  ];
}
