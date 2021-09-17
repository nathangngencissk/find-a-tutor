import 'package:find_a_tutor/src/models/andamentCourse.dart';
import 'package:find_a_tutor/src/ui/theme/theme.dart';
import 'package:find_a_tutor/src/ui/views/myCourses/myCourseView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:find_a_tutor/src/models/tabiconData.dart';
import 'package:find_a_tutor/src/ui/theme/courses_app_theme.dart';

class MyCourses extends StatefulWidget {
  @override
  _MyCoursesState createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> with TickerProviderStateMixin {
  List<AndamentCourse> myCourseList = AndamentCourse.myCourseList;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  AnimationController animationController;
  final ScrollController _scrollController = ScrollController();

  Widget tabBody = Container(
    color: CoursesAppTheme.background,
  );
  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: CoursesAppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text('Meus Cursos',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  letterSpacing: 0.27,
                  color: AppTheme.darkerText,
                )),
          ),
          body: Stack(
            children: <Widget>[
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      color: CoursesAppTheme.buildLightTheme().backgroundColor,
                      height: 25,
                    ),
                    Container(
                      padding:
                          new EdgeInsets.only(top: 9.0, right: 120, left: 2),
                      height: 35,
                      width: 400,
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: Text(
                        ' Cursos em andamento',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          letterSpacing: 0.27,
                          color: AppTheme.darkerText,
                        ),
                      ),
                    ),
                    Container(
                      height: 15,
                      color: CoursesAppTheme.buildLightTheme().backgroundColor,
                    ),
                    Expanded(
                      child: NestedScrollView(
                        controller: _scrollController,
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return Column(
                                  children: <Widget>[],
                                );
                              }, childCount: 1),
                            ),
                          ];
                        },
                        body: Container(
                          color:
                              CoursesAppTheme.buildLightTheme().backgroundColor,
                          child: ListView.builder(
                            itemCount: myCourseList.length,
                            padding: const EdgeInsets.only(top: 8),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              final int count = myCourseList.length > 10
                                  ? 10
                                  : myCourseList.length;
                              final Animation<double> animation =
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
                                      CurvedAnimation(
                                          parent: animationController,
                                          curve: Interval(
                                              (1 / count) * index, 1.0,
                                              curve: Curves.fastOutSlowIn)));
                              animationController.forward();
                              return MyCourseView(
                                callback: () {},
                                myCourseData: myCourseList[index],
                                animation: animation,
                                animationController: animationController,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
