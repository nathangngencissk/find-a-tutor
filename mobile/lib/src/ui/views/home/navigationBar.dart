import 'package:find_a_tutor/src/ui/views/myClass/myClass.dart';
import 'package:find_a_tutor/src/ui/views/myCourses/myCourses.dart';
import 'package:find_a_tutor/src/ui/views/home/myHomePage.dart';
import 'package:find_a_tutor/src/ui/views/shop_cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:find_a_tutor/src/models/tabiconData.dart';
import 'package:find_a_tutor/src/ui/theme/courses_app_theme.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  AnimationController animationController;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: CoursesAppTheme.background,
  );

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
    return new MaterialApp(
      home: MyBottomNavigationBar(),
    );
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    MyHomePage(),
    MyCourses(),
    MyClass(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: _children[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey[500],
        showUnselectedLabels: true,
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: new Icon(Icons.school),
              label: 'Meus Cursos',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: new Icon(Icons.people),
              label: 'Turmas',
              backgroundColor: Colors.white),
        ],
      ),
    );
  }
}
