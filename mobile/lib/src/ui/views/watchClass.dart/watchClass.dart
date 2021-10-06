import 'package:find_a_tutor/src/ui/theme/theme.dart';
import 'package:find_a_tutor/src/ui/views/watchClass.dart/chewie_list_item.dart';
import 'package:find_a_tutor/src/ui/views/watchClass.dart/watchClassBloc.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyWatchClass extends StatefulWidget {
  final int id;

  const MyWatchClass({Key key, this.id}) : super(key: key);

  @override
  _MyWatchClassState createState() => _MyWatchClassState(this.id);
}

class _MyWatchClassState extends State<MyWatchClass> {
  int id;
  WatchClassBloc watchClassBloc = WatchClassBloc();

  _MyWatchClassState(this.id);

  List data = [
    {
      'title': 'Aula 01 - Introdução a Redes',
      'desc': 'Você entenderá quais os conceitos de redes e de onde surgiu.\n',
    },
    {
      'title': 'Aula 02 - Instalando o ambiente',
      'desc': 'Você irá aprender como instalar as ferramentas necessárias.\n',
    },
    {
      'title': 'Aula 03 - Primeiros passos ',
      'desc': 'Aprenda os primeiros passos na carreira de Redes.\n'
    },
    {
      'title': 'Aula 04 - Boas práticas',
      'desc':
          'Você aprenderá a desenvolver e modificar layouts da melhor maneira possível.\n',
    }
  ];

  int selectedData;

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
        body: FutureBuilder<List>(
          future: watchClassBloc.getWatchClass(this.id),
          builder: (BuildContext c, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                    child: ChewieListItem(
                      videoPlayerController: VideoPlayerController.network(
                        "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4",
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
                                  body: ListTile(
                                    title: Text(e['description']),
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
                                  margin: EdgeInsets.only(
                                      left: 5, top: 20, bottom: 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        "Início: 2021-01-01",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Término: 2021-05-12",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Segunda-feira",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Horário: 14:00",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                  margin: EdgeInsets.only(
                                      left: 5, top: 20, bottom: 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        "Início: 2021-11-21",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Término: 2021-12-22",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Terça-feira",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Horário: 19:00",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                  margin: EdgeInsets.only(
                                      left: 5, top: 20, bottom: 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        "Início: 2021-07-21",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Término: 2021-10-25",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Sexta-feira",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Horário: 18:00",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                  margin: EdgeInsets.only(
                                      left: 5, top: 20, bottom: 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        "Início: 2021-07-01",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Término: 2021-10-08",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Segunda-feira",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Horário: 13:00",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
              );
            } else if (snapshot.hasError) {
              return Text('Não há check-in de turmas realizadas ainda!');
            } else {
              return LinearProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
