import 'package:find_a_tutor/src/models/myClassModel.dart';
import 'package:find_a_tutor/src/ui/theme/courses_app_theme.dart';
import 'package:find_a_tutor/src/ui/views/detailClass/detailClass.dart';
import 'package:flutter/material.dart';
import 'package:find_a_tutor/src/utils/imageFromS3.dart';

class MyClassView extends StatefulWidget {
  final VoidCallback callback;
  final MyClassModel myClassData;
  final AnimationController animationController;
  final Animation<dynamic> animation;
  final ImageFromS3 imageFromS3;
  final Map myClassDataBloc;

  const MyClassView(
      {Key key,
      this.myClassData,
      this.animationController,
      this.animation,
      this.imageFromS3,
      this.myClassDataBloc,
      this.callback})
      : super(key: key);

  @override
  _MyClassViewState createState() =>
      _MyClassViewState(this.imageFromS3, this.myClassDataBloc);
}

class _MyClassViewState extends State<MyClassView> {
  final ImageFromS3 imageFromS3;
  final Map myClassDataBloc;

  _MyClassViewState(this.imageFromS3, this.myClassDataBloc);

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
                child: GestureDetector(
                    child: Container(
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
                                  child: FutureBuilder(
                                    future: this.imageFromS3.getDownloadUrl(
                                        this.myClassDataBloc['image']),
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
                                                  myClassDataBloc['name'],
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 22,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 4),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        myClassDataBloc[
                                                            'description'],
                                                        style: TextStyle(
                                                            fontSize: 18,
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      moveToWatchClass();
                    }),
              ),
            ),
          ),
        );
      },
    );
  }

  void moveToWatchClass() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) =>
            DetailClass(id: myClassDataBloc['id']),
      ),
    );
  }
}
