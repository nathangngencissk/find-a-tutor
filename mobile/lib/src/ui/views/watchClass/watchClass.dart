import 'package:find_a_tutor/src/ui/theme/theme.dart';
import 'package:find_a_tutor/src/ui/views/myClass/myClass.dart';
import 'package:find_a_tutor/src/ui/views/watchClass/chewie_list_item.dart';
import 'package:find_a_tutor/src/ui/views/watchClass/watchClassBloc.dart';
import 'package:find_a_tutor/src/utils/imageFromS3.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:getwidget/getwidget.dart';

class MyWatchClass extends StatefulWidget {
  final int id;

  const MyWatchClass({Key key, this.id}) : super(key: key);

  @override
  _MyWatchClassState createState() => _MyWatchClassState(this.id);
}

class _MyWatchClassState extends State<MyWatchClass> {
  int id;
  WatchClassBloc watchClassBloc = WatchClassBloc();
  ImageFromS3 imageFromS3 = ImageFromS3();
  String videoUrl = '';
  List turmas = [];

  _MyWatchClassState(this.id);

  int selectedData;

  Future<List> getCourseData() async {
    List courseData = await watchClassBloc.getWatchClass(id);
    for (var aula in courseData[0]) {
      aula['videoUrl'] = await imageFromS3.getDownloadUrlReturn(aula['video']);
    }
    videoUrl = courseData[0][0]['videoUrl'];
    for (var turma in courseData[1]) {
      if (!turma['enrolled']) {
        turmas.add(turma);
      }
    }
    return courseData;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
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
        body: FutureBuilder<List>(
          future: getCourseData(),
          builder: (BuildContext c, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                    child: ChewieListItem(
                      videoPlayerController: VideoPlayerController.network(
                        videoUrl,
                      ),
                      looping: true,
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
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: ExpansionPanelList(
                              children:
                                  snapshot.data[0].map<ExpansionPanel>((e) {
                                return ExpansionPanel(
                                  headerBuilder:
                                      (BuildContext context, bool isExpanded) {
                                    return ListTile(
                                      title: Text(
                                        e['name'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          letterSpacing: 0.27,
                                          color: AppTheme.darkerText,
                                        ),
                                      ),
                                    );
                                  },
                                  body: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        ListTile(
                                          title: Text(e['description']),
                                        ),
                                        SizedBox(height: 30),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              videoUrl = e['videoUrl'];
                                              selectedData = null;
                                            });
                                          },
                                          child: const Text('Assistir Aula'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  isExpanded:
                                      selectedData == e['id'] ? true : false,
                                );
                              }).toList(),
                              expansionCallback: (int index, bool isExpanded) {
                                if (isExpanded == false) {
                                  setState(() {
                                    selectedData =
                                        snapshot.data[0][index]['id'];
                                  });
                                } else {
                                  setState(() {
                                    selectedData = null;
                                  });
                                }
                              },
                              animationDuration: Duration(milliseconds: 300),
                              expandedHeaderPadding: EdgeInsets.all(2),
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Column(
                              children: turmas.map<GFCard>((e) {
                                return GFCard(
                                  title: GFListTile(
                                    title: Text(e['name'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        )),
                                    subTitle: Text(e['description']),
                                  ),
                                  content: Text(
                                      "De ${e['start_date']} a ${e['end_date']}"),
                                  buttonBar: GFButtonBar(
                                    children: <Widget>[
                                      GFButton(
                                        onPressed: () async {
                                          await watchClassBloc
                                              .enrollCourseClass(e['id']);
                                          setState(() {
                                            turmas.removeWhere((item) =>
                                                item['id'] == e['id']);
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        text: 'Matricular',
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Não há check-in de turmas realizadas ainda!');
            } else {
              return Center(
                  child: SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.blue),
                          strokeWidth: 5.0)));
            }
          },
        ),
      ),
    );
  }
}
