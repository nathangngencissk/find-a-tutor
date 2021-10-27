import 'package:find_a_tutor/src/models/popularCourse.dart';
import 'package:find_a_tutor/src/ui/views/home/components/popularCourseListView.dart';
import 'package:find_a_tutor/src/ui/views/home/myHomePage_bloc.dart';
import 'package:find_a_tutor/src/utils/imageFromS3.dart';
import 'package:flutter/material.dart';
import 'package:find_a_tutor/src/models/tabiconData.dart';

class ColumnBuilder extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection;
  final int itemCount;

  const ColumnBuilder({
    Key key,
    @required this.itemBuilder,
    @required this.itemCount,
    this.mainAxisAlignment: MainAxisAlignment.start,
    this.mainAxisSize: MainAxisSize.max,
    this.crossAxisAlignment: CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection: VerticalDirection.down,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: new List.generate(
          this.itemCount, (index) => this.itemBuilder(context, index)).toList(),
    );
  }
}

class PopularCourseScreen extends StatefulWidget {
  @override
  _PopularCourseScreenState createState() => _PopularCourseScreenState();
}

class _PopularCourseScreenState extends State<PopularCourseScreen>
    with TickerProviderStateMixin {
  MyHomePageBloc homepagebloc = MyHomePageBloc();
  List<PopularCourse> popularCourseList = PopularCourse.popularCourseList;
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
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return Container(
            child: FutureBuilder<List>(
                future: homepagebloc.getPopularCourse(),
                builder: (BuildContext c, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasData) {
                    return ColumnBuilder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        animationController.forward();
                        return PopularCourseView(
                          callback: () {},
                          popularCourseData: snapshot.data[index],
                          imageFromS3: new ImageFromS3(),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Houve um erro ao listar as espécies');
                  } else {
                    return Center(
                        child: SizedBox(
                            width: 100,
                            height: 100,
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.blue),
                                strokeWidth: 5.0)));
                  }
                }));
      },
    );
  }
}
