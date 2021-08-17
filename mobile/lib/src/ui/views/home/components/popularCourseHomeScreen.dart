import 'dart:ui';
import 'package:find_a_tutor/src/models/popularCourse.dart';
import 'package:find_a_tutor/src/ui/theme/courses_app_theme.dart';
import 'package:find_a_tutor/src/ui/theme/theme.dart';
import 'package:find_a_tutor/src/ui/views/home/components/popularCourseListView.dart';
import 'package:flutter/material.dart';
import 'package:find_a_tutor/src/models/tabicon_data.dart';

class PopularCourseScreen extends StatefulWidget {
  @override
  _PopularCourseScreenState createState() => _PopularCourseScreenState();
}

class _PopularCourseScreenState extends State<PopularCourseScreen>
    with TickerProviderStateMixin {
  List<PopularCourse> popularCourseList = PopularCourse.popularCourseList;
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
                          color:
                              CoursesAppTheme.buildLightTheme().backgroundColor,
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

// class PopularCourseView extends StatelessWidget {
//   const PopularCourseView(
//       {Key key,
//       this.animationController,
//       this.animation,
//       this.popularCourse,
//       this.callback})
//       : super(key: key);

//   final VoidCallback callback;
//   final PopularCourse popularCourse;
//   final AnimationController animationController;
//   final Animation<dynamic> animation;

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: animationController,
//       builder: (BuildContext context, Widget child) {
//         return FadeTransition(
//           opacity: animation,
//           child: Transform(
//             transform: Matrix4.translationValues(
//                 0.0, 50 * (1.0 - animation.value), 0.0),
//             child: InkWell(
//               splashColor: Colors.transparent,
//               onTap: () {
//                 callback();
//               },
//               child: SizedBox(
//                 height: 280,
//                 child: Stack(
//                   alignment: AlignmentDirectional.bottomCenter,
//                   children: <Widget>[
//                     // Container(
//                     //   child: Column(
//                     //     children: <Widget>[
//                     //       Expanded(
//                     //         child: Container(
//                     //           decoration: BoxDecoration(
//                     //             color: HexColor('#F8FAFB'),
//                     //             borderRadius: const BorderRadius.all(
//                     //                 Radius.circular(16.0)),
//                     //           ),
//                     //           child: Column(
//                     //             children: <Widget>[
//                     //               Expanded(
//                     //                 child: Container(
//                     //                   child: Column(
//                     //                     children: <Widget>[
//                     //                       Padding(
//                     //                         padding: const EdgeInsets.only(
//                     //                             top: 16, left: 16, right: 16),
//                     //                         child: Text(
//                     //                           category.title,
//                     //                           textAlign: TextAlign.left,
//                     //                           style: TextStyle(
//                     //                             fontWeight: FontWeight.w600,
//                     //                             fontSize: 28,
//                     //                             letterSpacing: 0.27,
//                     //                             color: AppTheme.darkerText,
//                     //                           ),
//                     //                         ),
//                     //                       ),
//                     //                     ],
//                     //                   ),
//                     //                 ),
//                     //               ),
//                     //               const SizedBox(
//                     //                 width: 48,
//                     //               ),
//                     //             ],
//                     //           ),
//                     //         ),
//                     //       ),
//                     //       const SizedBox(
//                     //         height: 48,
//                     //       ),
//                     //     ],
//                     //   ),
//                     // ),
//                     // Container(
//                     //   width: 400,
//                     //   child: Padding(
//                     //     padding: const EdgeInsets.only(top: 20, bottom: 30),
//                     //     child: Container(
//                     //       decoration: BoxDecoration(
//                     //         borderRadius:
//                     //             const BorderRadius.all(Radius.circular(20)),
//                     //         boxShadow: <BoxShadow>[
//                     //           BoxShadow(
//                     //               color: AppTheme.grey.withOpacity(0.5),
//                     //               offset: const Offset(2, 2),
//                     //               blurRadius: 20),
//                     //         ],
//                     //       ),
//                     //       child: ClipRRect(
//                     //         borderRadius:
//                     //             const BorderRadius.all(Radius.circular(20.0)),
//                     //         child: AspectRatio(
//                     //           aspectRatio: 1.5,
//                     //           child: Image.asset(category.imagePath),
//                     //         ),
//                     //       ),
//                     //     ),
//                     //   ),
//                     // ),

//                     // Padding(
//                     //   padding: const EdgeInsets.only(
//                     //       top: 5, left: 8, right: 8, bottom: 5),
//                     //   child: Column(
//                     //     children: <Widget>[
//                     //       Expanded(
//                     //         child: NestedScrollView(
//                     //           controller: _scrollController,
//                     //           headerSliverBuilder: (BuildContext context,
//                     //               bool innerBoxIsScrolled) {
//                     //             return <Widget>[
//                     //               SliverList(
//                     //                 delegate: SliverChildBuilderDelegate(
//                     //                     (BuildContext context, int index) {},
//                     //                     childCount: 1),
//                     //               ),
//                     //             ];
//                     //           },
//                     //           body: Container(
//                     //             child: ListView.builder(
//                     //               itemCount: popularCourseList.length,
//                     //               padding: const EdgeInsets.only(top: 8),
//                     //               scrollDirection: Axis.vertical,
//                     //               itemBuilder:
//                     //                   (BuildContext context, int index) {
//                     //                 final int count = popularCourseList.length > 10
//                     //                     ? 10
//                     //                     : popularCourseList.length;
//                     //                 final Animation<double> animation =
//                     //                     Tween<double>(begin: 0.0, end: 1.0)
//                     //                         .animate(CurvedAnimation(
//                     //                             parent: animationController,
//                     //                             curve: Interval(
//                     //                                 (1 / count) * index, 1.0,
//                     //                                 curve:
//                     //                                     Curves.fastOutSlowIn)));
//                     //                 animationController.forward();
//                     //                 return PopularCourseView(
//                     //                   callback: () {},
//                     //                   popularCourse: popularCourseList[index],
//                     //                   animation: animation,
//                     //                   animationController: animationController,
//                     //                 );
//                     //               },
//                     //             ),
//                     //           ),
//                     //         ),
//                     //       ),

//                     //       // Padding(
//                     //       //   padding: const EdgeInsets.only(
//                     //       //       top: 8, left: 16, right: 16, bottom: 8),
//                     //       //   child: Row(
//                     //       //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     //       //     crossAxisAlignment: CrossAxisAlignment.center,
//                     //       //     children: <Widget>[
//                     //       //       Text(
//                     //       //         '${category.lessonCount} avaliações',
//                     //       //         textAlign: TextAlign.left,
//                     //       //         style: TextStyle(
//                     //       //           fontWeight: FontWeight.w400,
//                     //       //           fontSize: 28,
//                     //       //           letterSpacing: 0.27,
//                     //       //           color: Colors.grey[600],
//                     //       //         ),
//                     //       //       ),
//                     //       //       Container(
//                     //       //         child: Row(
//                     //       //           children: <Widget>[
//                     //       //             Text(
//                     //       //               '${category.rating}',
//                     //       //               textAlign: TextAlign.left,
//                     //       //               style: TextStyle(
//                     //       //                 fontWeight: FontWeight.w300,
//                     //       //                 fontSize: 18,
//                     //       //                 letterSpacing: 0.27,
//                     //       //                 color: AppTheme.grey,
//                     //       //               ),
//                     //       //             ),
//                     //       //             Icon(
//                     //       //               Icons.star,
//                     //       //               color: AppTheme.nearlyBlue,
//                     //       //               size: 20,
//                     //       //             ),
//                     //       //           ],
//                     //       //         ),
//                     //       //       )
//                     //       //     ],
//                     //       //   ),
//                     //       // ),
//                     //     ],
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
}
