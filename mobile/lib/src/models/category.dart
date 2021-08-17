class Category {
  Category(
      {this.title = '',
      this.imagePath = '',
      this.lessonCount = 0,
      this.money = 0,
      this.rating = 0.0,
      this.price = ''});

  String title;
  int lessonCount;
  int money;
  double rating;
  String imagePath;
  String price;

  static List<Category> categoryList = <Category>[
    Category(
      imagePath: 'assets/images/daytrade.jpg',
      title: 'Curso de Day Trade',
      lessonCount: 24,
      money: 25,
      rating: 4.3,
      price: "R\$197,99",
    ),
    Category(
      imagePath: 'assets/images/devgame.png',
      title: 'Desenvolvimento de jogos',
      lessonCount: 22,
      money: 18,
      rating: 4.6,
      price: "R\$199,99",
    ),
    Category(
      imagePath: 'assets/images/devperso.jpg',
      title: 'Desenvolvimento pessoal',
      lessonCount: 24,
      money: 25,
      rating: 4.3,
      price: "R\$249,99",
    ),
    Category(
      imagePath: 'assets/images/interFace2.png',
      title: 'Curso de como vender curso',
      lessonCount: 22,
      money: 18,
      rating: 4.6,
      price: "R\$197,99",
    ),
  ];

  // static List<Category> popularCourseList = <Category>[
  //   Category(
  //     imagePath: 'assets/images/daytrade.jpg',
  //     title: 'Curso de Day Trade',
  //     lessonCount: 12,
  //     money: 25,
  //     rating: 4.8,
  //     price: "R\$97,99",
  //   ),
  //   Category(
  //     imagePath: 'assets/images/devgame.png',
  //     title: 'Desenvolvimento de jogos',
  //     lessonCount: 28,
  //     money: 208,
  //     rating: 4.9,
  //     price: "R\$17,99",
  //   ),
  //   Category(
  //     imagePath: 'assets/images/redes.jpg',
  //     title: 'Redes de compuradores',
  //     lessonCount: 12,
  //     money: 25,
  //     rating: 4.8,
  //     price: "R\$28,99",
  //   ),
  //   Category(
  //     imagePath: 'assets/images/devperso.jpg',
  //     title: 'Desenvolvimento pessoal',
  //     lessonCount: 28,
  //     money: 208,
  //     rating: 4.9,
  //     price: "R\$197,99",
  //   ),
  // ];
}
