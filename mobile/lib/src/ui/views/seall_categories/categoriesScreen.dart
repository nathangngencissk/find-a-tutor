import 'package:find_a_tutor/src/ui/shared/hex_color.dart';
import 'package:find_a_tutor/src/ui/theme/theme.dart';
import 'package:find_a_tutor/src/ui/views/seall_categories/categoriesBloc.dart';
import 'package:find_a_tutor/src/ui/views/searchResults/searchResultsPage.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  CategoriesBloc categoriesBloc = CategoriesBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getSearchBarUI(),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: categoriesBloc.getMainCategories(),
        builder: (BuildContext context, AsyncSnapshot categories) {
          if (categories.hasData) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  children: categories.data.map<GestureDetector>((e) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                SearchResultsPage(categoryId: e['name']),
                          ),
                        );
                      },
                      child: new GFCard(
                        boxFit: BoxFit.cover,
                        titlePosition: GFPosition.start,
                        showOverlayImage: true,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.9), BlendMode.dstATop),
                        imageOverlay: NetworkImage(
                          e['image'],
                        ),
                        content: Text(e['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: AppTheme.nearlyWhite)),
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          } else {
            return new Container();
          }
        },
      ),
    );
  }

  Widget getSearchBarUI() {
    return Container(
      padding: const EdgeInsets.only(right: 10),
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
                        // moveToSeeAll();
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
}
