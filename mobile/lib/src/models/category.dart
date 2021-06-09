class Category {
  Category({
    this.title = '',
    this.imagePath = '',
    this.lessonCount = 0,
    this.money = 0,
    this.rating = 0.0,
  });

  String title;
  int lessonCount;
  int money;
  double rating;
  String imagePath;

  static List<Category> categoryList = <Category>[
    Category(
      imagePath: 'assets/images/daytrade.jpg',
      title: 'Curso de Day Trade',
      lessonCount: 24,
      money: 25,
      rating: 4.3,
    ),
    Category(
      imagePath: 'assets/images/devgame.png',
      title: 'Desenvolvimento de jogos',
      lessonCount: 22,
      money: 18,
      rating: 4.6,
    ),
    Category(
      imagePath: 'assets/images/devperso.jpg',
      title: 'Desenvolvimento pessoal',
      lessonCount: 24,
      money: 25,
      rating: 4.3,
    ),
    Category(
      imagePath: 'assets/images/interFace2.png',
      title: 'Curso de como vender curso',
      lessonCount: 22,
      money: 18,
      rating: 4.6,
    ),
  ];

  static List<Category> popularCourseList = <Category>[
    Category(
      imagePath: 'assets/images/daytrade.jpg',
      title: 'Curso de Day Trade',
      lessonCount: 12,
      money: 25,
      rating: 4.8,
    ),
    Category(
      imagePath: 'assets/images/devgame.png',
      title: 'Desenvolvimento de jogos',
      lessonCount: 28,
      money: 208,
      rating: 4.9,
    ),
    Category(
      imagePath: 'assets/images/cuidarpet.jpg',
      title: 'Adestramento de Cães',
      lessonCount: 12,
      money: 25,
      rating: 4.8,
    ),
    Category(
      imagePath: 'assets/images/devperso.jpg',
      title: 'Desenvolvimento pessoal',
      lessonCount: 28,
      money: 208,
      rating: 4.9,
    ),
  ];
}
