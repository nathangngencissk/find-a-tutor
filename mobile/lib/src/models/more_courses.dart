class CategoriesCourses {
  CategoriesCourses({
    this.imagePath = '',
    this.titleTxt = '',
    this.dist = 1.8,
    this.reviews = 80,
    this.rating = 4.5,
    this.price = "",
    this.subTxt = "",
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  double dist;
  double rating;
  int reviews;
  String price;

  static List<CategoriesCourses> categorieList = <CategoriesCourses>[
    CategoriesCourses(
      imagePath: 'assets/images/webdesign.jpg',
      titleTxt: 'Web Design',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      price: "R\$197,99",
    ),
    CategoriesCourses(
      imagePath: 'assets/images/uiux.png',
      titleTxt: 'Ui/UX',
      dist: 4.0,
      reviews: 74,
      rating: 4.5,
      price: "R\$200,00",
    ),
    CategoriesCourses(
      imagePath: 'assets/images/devgame.png',
      titleTxt: 'Desenv. de jogos',
      dist: 3.0,
      reviews: 62,
      rating: 4.0,
      price: "R\$99,99",
    ),
    CategoriesCourses(
      imagePath: 'assets/images/python.jpg',
      titleTxt: 'Programação',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      price: "R\$20,99",
    ),
    CategoriesCourses(
      imagePath: 'assets/images/mktdigital.jpg',
      titleTxt: 'Marketing Digital',
      dist: 2.0,
      reviews: 240,
      rating: 4.5,
      price: "R\$30,99",
    ),
  ];
}
