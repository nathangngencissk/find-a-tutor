import 'dart:ui';
import 'package:find_a_tutor/src/ui/theme/courses_app_theme.dart';
import 'package:find_a_tutor/src/models/more_courses.dart';
import 'package:find_a_tutor/src/ui/theme/theme.dart';
import 'package:find_a_tutor/src/ui/views/course_info/courseInfoPage.dart';
import 'package:find_a_tutor/src/ui/views/searchResults/searchResultsBloc.dart';
import 'package:find_a_tutor/src/utils/imageFromS3.dart';
import 'package:flutter/material.dart';
import 'package:find_a_tutor/src/ui/views/seeall_courses/courseListView.dart';
import 'package:find_a_tutor/src/models/tabiconData.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SearchResultsPage extends StatefulWidget {
  final String searchKeyword;

  const SearchResultsPage({Key key, this.searchKeyword}) : super(key: key);

  @override
  _SearchResultsPageState createState() =>
      _SearchResultsPageState(this.searchKeyword);
}

class _SearchResultsPageState extends State<SearchResultsPage>
    with TickerProviderStateMixin {
  String searchKeyword;
  _SearchResultsPageState(this.searchKeyword);
  List<CategoriesCourses> categorieList = CategoriesCourses.categorieList;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  AnimationController animationController;
  final ScrollController _scrollController = ScrollController();
  List<Widget> searchResults;
  List searchResultsData;
  SearchResultsBloc searchResultsBloc = SearchResultsBloc();
  final _searchController = TextEditingController();

  Widget tabBody = Container(
    color: CoursesAppTheme.background,
  );

  Future<Widget> getSearchResultsWidgets() async {
    searchResults = [];

    final ImageFromS3 imageFromS3carousel = ImageFromS3();
    searchResultsData =
        await searchResultsBloc.getSearchResults(this.searchKeyword);

    for (var element in searchResultsData) {
      searchResults.add(
        new GestureDetector(
          onTap: () {
            Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) =>
                    CourseInfoScreen(id: element['id']),
              ),
            );
          },
          child: new Container(
            height: 320,
            width: 450,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) =>
                          CourseInfoScreen(id: element['id']),
                    ),
                  );
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
                                future: imageFromS3carousel
                                    .getDownloadUrl(element['image']),
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
                                              element['name'],
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
                                                    element['category_name'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Colors.grey[500]),
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
                                                    rating:
                                                        element['avg_rating'],
                                                    size: 20,
                                                    color: Colors.lightBlue,
                                                    borderColor:
                                                        Colors.lightBlue,
                                                  ),
                                                  Text(
                                                    ' ${element["reviews"]} Reviews',
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
                                    padding: const EdgeInsets.only(
                                        right: 16, top: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          double.parse(
                                                  element['price'].toString())
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
        ),
      );
    }
    return ListView.builder(
      itemCount: searchResults.length,
      padding: const EdgeInsets.only(top: 8),
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        final int count = searchResults.length > 10 ? 10 : searchResults.length;
        final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0)
            .animate(CurvedAnimation(
                parent: animationController,
                curve: Interval((1 / count) * index, 1.0,
                    curve: Curves.fastOutSlowIn)));
        animationController.forward();
        return searchResults[index];
      },
    );
  }

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
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText2,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Theme(
            data: CoursesAppTheme.buildLightTheme(),
            child: Container(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Resultado da pesquisa',
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
                  backgroundColor: Colors.white,
                ),
                body: Stack(
                  children: <Widget>[
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Column(
                        children: <Widget>[
                          getSearchBarUI(),
                          Expanded(
                            child: NestedScrollView(
                              controller: _scrollController,
                              headerSliverBuilder: (BuildContext context,
                                  bool innerBoxIsScrolled) {
                                return <Widget>[
                                  SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {},
                                        childCount: 1),
                                  ),
                                ];
                              },
                              body: Container(
                                color: CoursesAppTheme.buildLightTheme()
                                    .backgroundColor,
                                child: FutureBuilder<Widget>(
                                  future: getSearchResultsWidgets(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot courses) {
                                    if (courses.hasData) {
                                      return courses.data;
                                    } else {
                                      return new Container();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Widget getSearchBarUI() {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 30, right: 25, top: 15),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 2, right: 10),
              width: 5,
              height: 50,
              decoration: BoxDecoration(
                color: HexColor('#f2f1f0'),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(13.0),
                  bottomLeft: Radius.circular(13.0),
                  topLeft: Radius.circular(13.0),
                  topRight: Radius.circular(13.0),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 16, right: 10),
                      child: TextFormField(
                        controller: _searchController,
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppTheme.nearlyBlue,
                        ),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Procurar por curso',
                          border: InputBorder.none,
                          helperStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: HexColor('#B9BABC'),
                          ),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            letterSpacing: 0.2,
                            color: HexColor('#B9BABC'),
                          ),
                        ),
                        onEditingComplete: () {},
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: IconButton(
                      onPressed: () {
                        final searchKeyword = _searchController.text.trim();
                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                SearchResultsPage(searchKeyword: searchKeyword),
                          ),
                        );
                      },
                      icon: Icon(Icons.search),
                      color: HexColor('#B9BABC'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: CoursesAppTheme.buildLightTheme().backgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color: CoursesAppTheme.buildLightTheme().backgroundColor,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '15 Cursos encontrados',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: CoursesAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
