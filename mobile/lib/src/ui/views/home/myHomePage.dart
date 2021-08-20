import 'package:carousel_slider/carousel_slider.dart';
import 'package:find_a_tutor/src/models/popularCourse.dart';
import 'package:find_a_tutor/src/models/tabicon_data.dart';
import 'package:find_a_tutor/src/ui/theme/theme.dart';
import 'package:find_a_tutor/src/ui/views/course_info/course_info_page.dart';
import 'package:find_a_tutor/src/ui/views/home/components/popularCourseHomeScreen.dart';
import 'package:find_a_tutor/src/ui/views/home/components/popularCourseListView.dart';

import 'package:find_a_tutor/src/ui/views/seall_categories/categoriesScreen.dart';
import 'package:find_a_tutor/src/ui/views/seeall_courses/coursesHomeScreen.dart';
import 'package:flutter/material.dart';
import '../../../../main.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PopularCourseScreen popularCourseScreen;
  CategoryType categoryType = CategoryType.ui;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  Widget screenView;

  @override
  void initState() {
    super.initState();

    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;
    super.initState();
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
                            child: carouselUi(),
                          ),
                          Container(
                            width: constraints.maxWidth,
                            height: size.width * 0.4,
                            child: getCategoryUI(),
                          ),
                          Container(
                            width: constraints.maxWidth,
                            height: size.width * 0.9,
                            child: getPopularCourseUI(),
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

  Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
    String txt = '';
    var icon;
    if (CategoryType.ui == categoryTypeData) {
      txt = 'Ui/Ux';
    } else if (CategoryType.coding == categoryTypeData) {
      txt = 'Codar';
    } else if (CategoryType.basic == categoryTypeData) {
      txt = 'Web Design';
    }

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? AppTheme.nearlyBlue : AppTheme.nearlyWhite,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: AppTheme.nearlyBlue)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {
              setState(() {
                categoryType = categoryTypeData;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 18, right: 18),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.25,
                    color:
                        isSelected ? AppTheme.nearlyWhite : AppTheme.nearlyBlue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getCategoryUI() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 18, right: 16),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'Categorias',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        letterSpacing: 0.27,
                        color: AppTheme.darkerText,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                    child: Text(
                      'Veja mais',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      moveToCateScreen();
                    }),
              ]),
        ),
        const SizedBox(
          height: 26,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: <Widget>[
              getButtonUI(CategoryType.ui, categoryType == CategoryType.ui),
              const SizedBox(
                width: 17,
              ),
              getButtonUI(
                  CategoryType.coding, categoryType == CategoryType.coding),
              const SizedBox(
                width: 17,
              ),
              getButtonUI(
                  CategoryType.basic, categoryType == CategoryType.basic),
            ],
          ),
        ),
        // PopularCourseListView()(
        //   callBack: () {
        //     moveToInfoScreen();
        //   },
        // ),
      ],
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
                        moveToSeeAll();
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

  Widget carouselUi() {
    var size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 25),
      child: Column(
        children: <Widget>[
          CarouselSlider(
            items: <Widget>[
              Container(
                width: 300,
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: 20, bottom: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage("assets/images/programacao.jpg"),
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
              Container(
                width: 300,
                margin: EdgeInsets.only(top: 20, bottom: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage("assets/images/powerbi.png"),
                        fit: BoxFit.cover),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black87,
                          blurRadius: 15,
                          offset: Offset(10, 10))
                    ]),
              ),
              Container(
                width: 300,
                margin: EdgeInsets.only(top: 20, bottom: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage("assets/images/gambit.jpg"),
                        fit: BoxFit.cover),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black87,
                          blurRadius: 15,
                          offset: Offset(10, 10))
                    ]),
              ),
              Container(
                width: 300,
                margin: EdgeInsets.only(top: 20, bottom: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage("assets/images/sql.jpg"),
                        fit: BoxFit.cover),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black87,
                          blurRadius: 15,
                          offset: Offset(10, 10))
                    ]),
              ),
            ],
            options: CarouselOptions(autoPlay: true),
          )
        ],
      ),
    );
  }

  Widget getPopularCourseUI() {
    var size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
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
              ElevatedButton(
                child: Text(
                  'Veja mais',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  moveToSeeAll();
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.height - 500,
          child: PopularCourseScreen(
              // callback: () {
              //   moveToInfoScreen();
              // },
              ),
        )
      ],
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
