import 'package:find_a_tutor/src/models/myClassModel.dart';
import 'package:find_a_tutor/src/ui/theme/courses_app_theme.dart';
import 'package:find_a_tutor/src/ui/views/detailClass/detailClass.dart';
import 'package:flutter/material.dart';

class MyClassView extends StatefulWidget {
  final VoidCallback callback;
  final MyClassModel myClassData;
  final AnimationController animationController;
  final Animation<dynamic> animation;
  const MyClassView(
      {Key key,
      this.myClassData,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  @override
  _MyClassViewState createState() => _MyClassViewState();
}

class _MyClassViewState extends State<MyClassView> {
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
                              child: Image.asset(
                                widget.myClassData.imagePath,
                                fit: BoxFit.cover,
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
                                              widget.myClassData.titleTxt,
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
                                                Text(
                                                  widget.myClassData.subTxt,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey
                                                          .withOpacity(0.8)),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    'Tecnologia',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey[800],
                                                    ),
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
                                                    'Teste de descrição\ndescriçao do curso\ndescrição.',
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
                                  Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 16, top: 8),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              height: 2,
                                            ),
                                            Text(
                                              'Em andamento',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 22,
                                              ),
                                            ),
                                            Container(
                                              height: 2,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                FlatButton(
                                                    color: Colors.white,
                                                    child: Text(
                                                      'Ver turma',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 20,
                                                        letterSpacing: 0.0,
                                                        color: Colors.lightBlue,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      moveToWatchClass();
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

  void moveToWatchClass() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => DetailClass(),
      ),
    );
  }
}
