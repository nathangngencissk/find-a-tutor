import 'package:find_a_tutor/src/services/cart.dart';
import 'package:find_a_tutor/src/ui/theme/courses_app_theme.dart';
import 'package:find_a_tutor/src/ui/theme/theme.dart';
import 'package:find_a_tutor/src/ui/views/course_info/courseInfoPage.dart';
import 'package:find_a_tutor/src/ui/views/home/myHomePage_bloc.dart';
import 'package:find_a_tutor/src/ui/views/watchClass/watchClass.dart';
import 'package:find_a_tutor/src/utils/imageFromS3.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class CoursesHomeScreen extends StatefulWidget {
  @override
  _CoursesHomeScreenState createState() => _CoursesHomeScreenState();
}

class _CoursesHomeScreenState extends State<CoursesHomeScreen> {
  MyHomePageBloc myHomePageBloc = MyHomePageBloc();
  ImageFromS3 imageFromS3 = ImageFromS3();
  List popularCourses = [];

  Future<List> getAllPopularCourses() async {
    popularCourses = await myHomePageBloc.getPopularCourse();
    for (var course in popularCourses) {
      course['picture'] =
          await imageFromS3.getDownloadUrlReturn(course['image']);
    }
    return popularCourses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getSearchBarUI(),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getAllPopularCourses(),
        builder: (BuildContext context, AsyncSnapshot popularCourses) {
          if (popularCourses.hasData) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  children: popularCourses.data.map<GestureDetector>((e) {
                    return GestureDetector(
                      onTap: () {
                        final userCourses =
                            Provider.of<CartService>(context, listen: false)
                                .userCourses;
                        if (userCourses.contains(e['id'])) {
                          Navigator.push<dynamic>(
                            context,
                            MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) =>
                                  MyWatchClass(id: e['id']),
                            ),
                          );
                        } else {
                          Navigator.push<dynamic>(
                            context,
                            MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) =>
                                  CourseInfoScreen(id: e['id']),
                            ),
                          );
                        }
                      },
                      child: new Container(
                        margin: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              offset: const Offset(4, 4),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0)),
                          child: Stack(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  AspectRatio(
                                    aspectRatio: 2,
                                    child: Image.network(e['picture'],
                                        fit: BoxFit.cover),
                                  ),
                                  Container(
                                    color: CoursesAppTheme.buildLightTheme()
                                        .backgroundColor,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16, top: 8, bottom: 8),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    e['name'],
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 22,
                                                    ),
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Text(
                                                          e['category_name'],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .grey[500]),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4),
                                                    child: Row(
                                                      children: <Widget>[
                                                        SmoothStarRating(
                                                          allowHalfRating: true,
                                                          starCount: 5,
                                                          rating:
                                                              e['avg_rating'],
                                                          size: 20,
                                                          color:
                                                              Colors.lightBlue,
                                                          borderColor:
                                                              Colors.lightBlue,
                                                        ),
                                                        Text(
                                                          ' ${e["reviews"]} Reviews',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.8)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16, top: 8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                double.parse(
                                                        e['price'].toString())
                                                    .toStringAsFixed(2),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 22,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          } else {
            return new Container();
          }
        },
      ),
    );
  }

  Widget getSearchBarUI() {
    return Container(
      padding: const EdgeInsets.only(right: 10),
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
                        // moveToSeeAll();
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
}
