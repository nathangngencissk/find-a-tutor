import 'package:find_a_tutor/src/ui/theme/theme.dart';
import 'package:find_a_tutor/src/ui/views/watchClass.dart/chewie_list_item.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyWatchClass extends StatefulWidget {
  @override
  _MyWatchClassState createState() => _MyWatchClassState();
}

class _MyWatchClassState extends State<MyWatchClass> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Assistir Aulas',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: AppTheme.darkerText,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[350].withOpacity(0.4),
          elevation: 0,
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
              child: ChewieListItem(
                videoPlayerController: VideoPlayerController.network(
                  "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4",
                ),
                looping: true,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 0, right: 222),
              child: Text(
                'Web Design: Aula 1',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  letterSpacing: 0.27,
                  color: AppTheme.darkerText,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: AppBar(
                backgroundColor: Colors.grey[200],
                shadowColor: Colors.black,
                bottom: TabBar(
                  tabs: [
                    Tab(
                      child: Text(
                        'Aulas',
                        style: TextStyle(
                          color: AppTheme.darkerText,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Turmas',
                        style: TextStyle(
                          color: AppTheme.darkerText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 120),
                        child: Text(
                          'Aula 1: Texto de exemplo ',
                          style: TextStyle(color: Colors.black, fontSize: 23),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 120),
                        child: Text(
                          'Aula 2: Texto de exemplo ',
                          style: TextStyle(color: Colors.black, fontSize: 23),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 120),
                        child: Text(
                          'Aula 3: Texto de exemplo ',
                          style: TextStyle(color: Colors.black, fontSize: 23),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 120),
                        child: Text(
                          'Aula 4: Texto de exemplo ',
                          style: TextStyle(color: Colors.black, fontSize: 23),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 120),
                        child: Text(
                          'Aula 5: Texto de exemplo ',
                          style: TextStyle(color: Colors.black, fontSize: 23),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(30),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: <Widget>[
                      Container(
                        height: 150,
                        width: 190,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: const Offset(0, 3),
                              spreadRadius: 5,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Container(
                            margin:
                                EdgeInsets.only(left: 5, top: 20, bottom: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Início: 2021-11-21",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Término: 2021-12-22",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Dia: Segunda-feira",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Horário: 14:00",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                      ),
                      Container(
                        height: 150,
                        width: 190,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: const Offset(0, 3),
                              spreadRadius: 5,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Container(
                            margin:
                                EdgeInsets.only(left: 5, top: 20, bottom: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Início: 2021-11-21",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Término: 2021-12-22",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Dia: Segunda-feira",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Horário: 14:00",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                      ),
                      Container(
                        height: 150,
                        width: 190,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: const Offset(0, 3),
                              spreadRadius: 5,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Container(
                            margin:
                                EdgeInsets.only(left: 5, top: 20, bottom: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Início: 2021-07-21",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Término: 2021-10-25",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Dia: Segunda-feira",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Horário: 14:00",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                      ),
                      Container(
                        height: 150,
                        width: 190,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: const Offset(0, 3),
                              spreadRadius: 5,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Container(
                            margin:
                                EdgeInsets.only(left: 5, top: 20, bottom: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Início: 2021-07-21",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Término: 2021-10-25",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Dia: Segunda-feira",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Horário: 14:00",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
