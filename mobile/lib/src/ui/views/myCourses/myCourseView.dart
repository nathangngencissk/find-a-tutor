import 'package:find_a_tutor/src/models/andamentCourse.dart';
import 'package:find_a_tutor/src/ui/theme/courses_app_theme.dart';
import 'package:find_a_tutor/src/ui/theme/theme.dart';
import 'package:find_a_tutor/src/ui/views/watchClass.dart/watchClass.dart';
import 'package:find_a_tutor/src/utils/imageFromS3.dart';
import 'package:flutter/material.dart';

class MyCourseView extends StatefulWidget {
  final VoidCallback callback;
  final AndamentCourse myCourseData;
  final AnimationController animationController;
  final Animation<dynamic> animation;
  final ImageFromS3 imageFromS3;
  final Map myCourseDataBloc;

  const MyCourseView(
      {Key key,
      this.myCourseData,
      this.animationController,
      this.animation,
      this.imageFromS3,
      this.myCourseDataBloc,
      this.callback})
      : super(key: key);

  @override
  _MyCourseViewState createState() =>
      _MyCourseViewState(this.imageFromS3, this.myCourseDataBloc);
}

class _MyCourseViewState extends State<MyCourseView> {
  final ImageFromS3 imageFromS3;
  final Map myCourseDataBloc;

  _MyCourseViewState(this.imageFromS3, this.myCourseDataBloc);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - widget.animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  widget.callback();
                },
                child: Container(
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
                                    .getDownloadUrl(myCourseDataBloc['image']),
                                builder: (BuildContext context,
                                    AsyncSnapshot image) {
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
                              color: CoursesAppTheme.buildLightTheme()
                                  .backgroundColor,
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
                                              myCourseDataBloc['name'],
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
                                                    'Julia Rodrigues',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey
                                                            .withOpacity(0.8)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    myCourseDataBloc['name'],
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey
                                                          .withOpacity(0.8),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 16, top: 8),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              'Em andamento',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 22,
                                              ),
                                            ),
                                            Container(
                                              height: 4,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                FlatButton(
                                                    color: Colors.lightBlue,
                                                    child: Text(
                                                      'Assistir aula ...',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                        letterSpacing: 0.0,
                                                        color: AppTheme
                                                            .nearlyWhite,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      moveToWatchClass(
                                                          myCourseDataBloc[
                                                              'id']);
                                                    }),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
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
      },
    );
  }

  void moveToWatchClass(int id) {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => MyWatchClass(id: id),
      ),
    );
  }
}
