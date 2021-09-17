import 'dart:ui';
import 'package:find_a_tutor/src/models/popularCourse.dart';
import 'package:find_a_tutor/src/ui/views/home/components/popularCourseListView.dart';
import 'package:find_a_tutor/src/ui/views/home/myHomePage_bloc.dart';
import 'package:flutter/material.dart';
import 'package:find_a_tutor/src/models/tabiconData.dart';

class PopularCourseScreen extends StatefulWidget {
  @override
  _PopularCourseScreenState createState() => _PopularCourseScreenState();
}

class _PopularCourseScreenState extends State<PopularCourseScreen>
    with TickerProviderStateMixin {
  MyHomePageBloc bloc = MyHomePageBloc();
  List<PopularCourse> popularCourseList = PopularCourse.popularCourseList;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  AnimationController animationController;
  final ScrollController _scrollController = ScrollController();

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
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return Container(
          child: Scaffold(
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
                      Expanded(
                        child: NestedScrollView(
                          controller: _scrollController,
                          headerSliverBuilder:
                              (BuildContext context, bool innerBoxIsScrolled) {
                            return <Widget>[
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {},
                                    childCount: 1),
                              ),
                            ];
                          },
                          body: Container(
                            child: ListView.builder(
                              itemCount: popularCourseList.length,
                              padding: const EdgeInsets.only(top: 8),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                final int count = popularCourseList.length > 10
                                    ? 10
                                    : popularCourseList.length;
                                final Animation<double> animation =
                                    Tween<double>(begin: 0.0, end: 1.0).animate(
                                        CurvedAnimation(
                                            parent: animationController,
                                            curve: Interval(
                                                (1 / count) * index, 1.0,
                                                curve: Curves.fastOutSlowIn)));
                                animationController.forward();
                                return PopularCourseView(
                                  callback: () {},
                                  popularCourseData: popularCourseList[index],
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
        );
      },
    );
  }
}
