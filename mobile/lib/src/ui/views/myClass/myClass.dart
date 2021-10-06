import 'package:find_a_tutor/src/models/myClassModel.dart';
import 'package:find_a_tutor/src/models/tabiconData.dart';
import 'package:find_a_tutor/src/ui/theme/theme.dart';
import 'package:find_a_tutor/src/ui/views/myClass/myClassBloc.dart';
import 'package:find_a_tutor/src/ui/views/myClass/myClassView.dart';
import 'package:find_a_tutor/src/utils/imageFromS3.dart';
import 'package:flutter/material.dart';

class MyClass extends StatefulWidget {
  @override
  _MyClassState createState() => _MyClassState();
}

class _MyClassState extends State<MyClass> with TickerProviderStateMixin {
  MyClassPageBloc homepagebloc = MyClassPageBloc();
  ImageFromS3 imageFromS3 = ImageFromS3();

  List<MyClassModel> myClassList = MyClassModel.myClassList;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  AnimationController animationController;

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          "Minhas turmas",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            letterSpacing: 0.27,
            color: AppTheme.darkerText,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                  height: 500,
                  width: 500,
                  color: Colors.grey.shade100,
                  child: FutureBuilder<List>(
                    future: homepagebloc.getMyClass(),
                    builder: (BuildContext c, AsyncSnapshot<List> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          padding: const EdgeInsets.only(top: 8),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            final int count = snapshot.data.length > 10
                                ? 10
                                : snapshot.data.length;
                            final Animation<double> animation =
                                Tween<double>(begin: 0.0, end: 1.0).animate(
                                    CurvedAnimation(
                                        parent: animationController,
                                        curve: Interval(
                                            (1 / count) * index, 1.0,
                                            curve: Curves.fastOutSlowIn)));
                            animationController.forward();
                            return MyClassView(
                              callback: () {},
                              myClassDataBloc: snapshot.data[index],
                              imageFromS3: new ImageFromS3(),
                              animation: animation,
                              animationController: animationController,
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                            'Não há check-in de turmas realizadas ainda!');
                      } else {
                        return LinearProgressIndicator();
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
