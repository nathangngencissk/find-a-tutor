import 'package:find_a_tutor/src/ui/theme/theme.dart';
import 'package:find_a_tutor/src/ui/views/detailClass/detailClassBloc.dart';
import 'package:find_a_tutor/src/utils/imageFromS3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:find_a_tutor/src/models/checkbox_state.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class DetailClass extends StatefulWidget {
  final int id;

  const DetailClass({Key key, this.id}) : super(key: key);

  @override
  _DetailClassState createState() => _DetailClassState(this.id);
}

DateTime selectedDay = DateTime.now();
DateTime focusedDay = DateTime.now();

class _DetailClassState extends State<DetailClass> {
  int id;
  DetailClassBloc detailClassBloc = DetailClassBloc();
  ImageFromS3 imageFromS3 = ImageFromS3();
  List<CheckBoxState> postCheckBoxStates = [];

  _DetailClassState(this.id);

  Future<List> getClassInfo() async {
    List classInfo = await detailClassBloc.getDetailClass(id);
    classInfo[1]['picture'] =
        await imageFromS3.getDownloadUrlReturn(classInfo[1]['image']);
    List<Widget> classPosts = [];
    classInfo[0].asMap().forEach((index, post) => {
          postCheckBoxStates.add(CheckBoxState(title: post['title'])),
          classPosts.add(CheckboxListTile(
            title: Text(postCheckBoxStates[index].title),
            subtitle: Text(post['body']),
            controlAffinity: ListTileControlAffinity.leading,
            value: postCheckBoxStates[index].value,
            onChanged: (value) {
              setState(
                () {
                  postCheckBoxStates[index].value = true;
                  createAlertDialog(postCheckBoxStates[index], post);
                },
              );
            },
            activeColor: Colors.blue,
            checkColor: Colors.white,
          ))
        });
    classInfo.add(classPosts);
    return classInfo;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Detalhes da turma",
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
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder<List>(
          future: getClassInfo(),
          builder: (BuildContext context, AsyncSnapshot<List> cl) {
            if (cl.hasData) {
              return Column(
                children: <Widget>[
                  Container(
                    height: 200,
                    width: 500,
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: NetworkImage(cl.data[1]['picture']),
                          fit: BoxFit.fitWidth),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 75,
                          child: AppBar(
                            backgroundColor: Colors.grey[200],
                            shadowColor: Colors.black,
                            bottom: TabBar(
                              labelColor: Colors.black,
                              tabs: <Widget>[
                                Tab(
                                  text: 'Aula',
                                  icon: Icon(Icons.live_tv),
                                  iconMargin: const EdgeInsets.only(bottom: 10),
                                ),
                                Tab(
                                  text: 'Postagens',
                                  iconMargin:
                                      const EdgeInsets.only(top: 5, bottom: 6),
                                  icon: Icon(Icons.computer_rounded),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 60, left: 0, right: 0),
                                child: Markdown(
                                  data: cl.data[1]['how_to_access'],
                                ),
                              ),
                              Column(
                                children: cl.data[2],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return new Stack();
            }
          },
        ),
      ),
    );
  }

  createAlertDialog(CheckBoxState checkbox, Map post) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(checkbox.title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(post['body']),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
