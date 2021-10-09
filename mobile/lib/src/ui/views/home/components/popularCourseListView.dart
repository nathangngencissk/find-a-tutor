import 'package:find_a_tutor/src/ui/theme/courses_app_theme.dart';
import 'package:find_a_tutor/src/ui/views/course_info/courseInfoPage.dart';
import 'package:find_a_tutor/src/utils/imageFromS3.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class PopularCourseView extends StatelessWidget {
  const PopularCourseView(
      {Key key, this.popularCourseData, this.imageFromS3, this.callback})
      : super(key: key);

  final VoidCallback callback;
  final Map popularCourseData;
  final ImageFromS3 imageFromS3;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      width: 450,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            callback();
          },
          child: new GestureDetector(
            onTap: () {
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) =>
                      CourseInfoScreen(id: popularCourseData['id']),
                ),
              );
            },
            child: new Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    offset: const Offset(4, 4),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 2,
                          child: FutureBuilder(
                            future: this
                                .imageFromS3
                                .getDownloadUrl(popularCourseData['image']),
                            builder:
                                (BuildContext context, AsyncSnapshot image) {
                              if (image.hasData) {
                                return Image.network(image.data,
                                    fit: BoxFit.cover);
                              } else {
                                return new Container();
                              }
                            },
                          ),
                        ),
                        Container(
                          color:
                              CoursesAppTheme.buildLightTheme().backgroundColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                          popularCourseData['name'],
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22,
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                popularCourseData[
                                                    'category_name'],
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[500]),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          child: Row(
                                            children: <Widget>[
                                              SmoothStarRating(
                                                allowHalfRating: true,
                                                starCount: 5,
                                                rating: popularCourseData[
                                                    'avg_rating'],
                                                size: 20,
                                                color: Colors.lightBlue,
                                                borderColor: Colors.lightBlue,
                                              ),
                                              Text(
                                                ' ${popularCourseData["reviews"]} Reviews',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey
                                                        .withOpacity(0.8)),
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
                                padding:
                                    const EdgeInsets.only(right: 16, top: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      double.parse(popularCourseData['price']
                                              .toString())
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
          ),
        ),
      ),
    );
  }
}
