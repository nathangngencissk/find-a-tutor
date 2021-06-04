class CategoriesCourses {
  CategoriesCourses({
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

  static List<CategoriesCourses> categorieList = <CategoriesCourses>[
    CategoriesCourses(
      imagePath: 'assets/images/interFace1.png',
      titleTxt: 'Web Design',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      price: 180,
    ),
    CategoriesCourses(
      imagePath: 'assets/images/interFace2.png',
      titleTxt: 'Ui/UX',
      dist: 4.0,
      reviews: 74,
      rating: 4.5,
      price: 200,
    ),
    CategoriesCourses(
      imagePath: 'assets/images/interFace3.png',
      titleTxt: 'Coding',
      dist: 3.0,
      reviews: 62,
      rating: 4.0,
      price: 60,
    ),
    CategoriesCourses(
      imagePath: 'assets/images/interFace4.png',
      titleTxt: 'Programação',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      price: 170,
    ),
    CategoriesCourses(
      imagePath: 'assets/images/interFace4.png',
      titleTxt: 'Marketing Digital',
      dist: 2.0,
      reviews: 240,
      rating: 4.5,
      price: 200,
    ),
  ];
}
