import 'package:carousel_slider/carousel_slider.dart';
import 'package:find_a_tutor/src/models/tabiconData.dart';
import 'package:find_a_tutor/src/ui/theme/theme.dart';
import 'package:find_a_tutor/src/ui/views/course_info/courseInfoPage.dart';
import 'package:find_a_tutor/src/ui/views/home/components/carouselBloc.dart';
import 'package:find_a_tutor/src/ui/views/home/components/popularCourseHomeScreen.dart';
import 'package:find_a_tutor/src/ui/views/home/components/popularCourseListView.dart';
import 'package:find_a_tutor/src/ui/views/home/myHomePage_bloc.dart';
import 'package:find_a_tutor/src/ui/views/seall_categories/categoriesBloc.dart';
import 'package:find_a_tutor/src/ui/views/seall_categories/categoriesScreen.dart';
import 'package:find_a_tutor/src/ui/views/searchResults/searchResultsPage.dart';
import 'package:find_a_tutor/src/ui/views/seeall_courses/coursesHomeScreen.dart';
import 'package:find_a_tutor/src/utils/imageFromS3.dart';
import 'package:find_a_tutor/src/utils/auth_service.dart';
import 'package:flutter/material.dart';
import '../../../../main.dart';
import 'package:getwidget/getwidget.dart';

class MyHomePage extends StatefulWidget {
  final ImageFromS3 imageFromS3;
  final Map carouselData;

  const MyHomePage({Key key, this.imageFromS3, this.carouselData})
      : super(key: key);

  @override
  _MyHomePageState createState() =>
      _MyHomePageState(this.carouselData, this.imageFromS3);
}

class _MyHomePageState extends State<MyHomePage> {
  MyHomePageBloc homepagebloc = MyHomePageBloc();
  PopularCourseScreen popularCourseScreen;
  CategoryType categoryType = CategoryType.ui;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  PopularCourseView callback;
  Widget screenView;
  CarouselBloc carouselBloc = CarouselBloc();
  CategoriesBloc categoriesBloc = CategoriesBloc();

  final Map carouselData;
  final ImageFromS3 imageFromS3;
  List studyngNow;
  List<Widget> mainCategories;
  List<Widget> carouselImages;
  final _searchController = TextEditingController();

  _MyHomePageState(this.carouselData, this.imageFromS3);

  @override
  void initState() {
    AuthService authService = AuthService();
    authService.checkAuthStatus();
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;
    super.initState();
  }

  Future<List> getMainCategories() async {
    mainCategories = [];
    List mainCategoriesData = await categoriesBloc.getMainCategories();
    return mainCategoriesData;
  }

  Future<List<Widget>> getStudyngNow() async {
    carouselImages = [];

    final ImageFromS3 imageFromS3carousel = ImageFromS3();
    studyngNow = await carouselBloc.getCarousel();

    for (var element in studyngNow) {
      carouselImages.add(
        new GestureDetector(
          onTap: () {
            Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) =>
                    CourseInfoScreen(id: element['id']),
              ),
            );
          },
          child: new Container(
            width: 300,
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 20, bottom: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: NetworkImage(await imageFromS3carousel
                      .getDownloadUrlReturn(element['image'])),
                  fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                  color: Colors.black87,
                  blurRadius: 15,
                  offset: Offset(10, 10),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return carouselImages;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: getSearchBarUI(),
        backgroundColor: AppTheme.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: LayoutBuilder(
                    builder: (_, constraints) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight / 3,
                            child: FutureBuilder<List<Widget>>(
                              future: getStudyngNow(),
                              builder: (BuildContext context,
                                  AsyncSnapshot courses) {
                                if (courses.hasData) {
                                  return CarouselSlider(
                                    items: courses.data,
                                    options: CarouselOptions(autoPlay: true),
                                  );
                                } else {
                                  return new Container();
                                }
                              },
                            ),
                          ),
                          Container(
                            width: constraints.maxWidth,
                            height: size.width * 0.4,
                            child: FutureBuilder(
                              future: getMainCategories(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List> categories) {
                                if (categories.hasData) {
                                  return Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 18, right: 16),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Column(
                                                children: <Widget>[
                                                  Text(
                                                    'Categorias',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 22,
                                                      letterSpacing: 0.27,
                                                      color:
                                                          AppTheme.darkerText,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              OutlinedButton(
                                                onPressed: () {
                                                  moveToCateScreen();
                                                },
                                                child: const Text('Veja Mais'),
                                              ),
                                            ]),
                                      ),
                                      const SizedBox(
                                        height: 26,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: SizedBox(
                                          height: 50,
                                          child: ListView.separated(
                                              itemCount: categories.data.length,
                                              separatorBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      const Divider(),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Container(
                                                  margin: EdgeInsets.all(5),
                                                  child: GFButton(
                                                    onPressed: () {
                                                      Navigator.push<dynamic>(
                                                        context,
                                                        MaterialPageRoute<
                                                            dynamic>(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              SearchResultsPage(
                                                                  categoryId: categories
                                                                              .data[
                                                                          index]
                                                                      ['name']),
                                                        ),
                                                      );
                                                    },
                                                    text: categories.data[index]
                                                        ['name'],
                                                    shape: GFButtonShape.pills,
                                                  ),
                                                );
                                              },
                                              scrollDirection: Axis.horizontal),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return new Stack();
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text('Cursos Populares',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 22,
                                          letterSpacing: 0.27,
                                          color: AppTheme.darkerText,
                                        )),
                                  ],
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    moveToSeeAll();
                                  },
                                  child: const Text('Veja Mais'),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height - 450,
                            child: PopularCourseScreen(),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getSearchBarUI() {
    return Container(
      padding: const EdgeInsets.only(left: 45, right: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 2, right: 10),
              width: 5,
              height: 50,
              decoration: BoxDecoration(
                color: HexColor('#f2f1f0'),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(13.0),
                  bottomLeft: Radius.circular(13.0),
                  topLeft: Radius.circular(13.0),
                  topRight: Radius.circular(13.0),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 16, right: 10),
                      child: TextFormField(
                        controller: _searchController,
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppTheme.nearlyBlue,
                        ),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Procurar por curso',
                          border: InputBorder.none,
                          helperStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: HexColor('#B9BABC'),
                          ),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            letterSpacing: 0.2,
                            color: HexColor('#B9BABC'),
                          ),
                        ),
                        onEditingComplete: () {},
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: IconButton(
                      onPressed: () {
                        final searchKeyword = _searchController.text.trim();
                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                SearchResultsPage(searchKeyword: searchKeyword),
                          ),
                        );
                      },
                      icon: Icon(Icons.search),
                      color: HexColor('#B9BABC'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void moveToInfoScreen() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => CourseInfoScreen(),
      ),
    );
  }

  void moveToCateScreen() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => CategoriesScreen(),
      ),
    );
  }

  void moveToSeeAll() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => CoursesHomeScreen(),
      ),
    );
  }
}

enum CategoryType {
  ui,
  coding,
  basic,
}
