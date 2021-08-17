import 'package:find_a_tutor/src/ui/shared/hex_color.dart';
import 'package:find_a_tutor/src/ui/theme/theme.dart';
import 'package:find_a_tutor/src/ui/views/seeall_courses/coursesHomeScreen.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  CategoryType categoryType = CategoryType.ui;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: LayoutBuilder(
                    builder: (_, constraints) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight - 49,
                            child: getCategoryUI(),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCategoryUI() {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 1,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: <Widget>[
              getButtonUI(CategoryType.ui, categoryType == CategoryType.ui),
              const SizedBox(
                width: 17,
              ),
              getButtonUI(
                  CategoryType.coding, categoryType == CategoryType.coding),
              const SizedBox(
                width: 17,
              ),
              getButtonUI(
                  CategoryType.basic, categoryType == CategoryType.basic),
              const SizedBox(
                width: 10,
              ),
              getButtonUI(
                  CategoryType.csharp, categoryType == CategoryType.csharp),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: <Widget>[
              getButtonUI(
                  CategoryType.redes, categoryType == CategoryType.redes),
              const SizedBox(
                width: 17,
              ),
              getButtonUI(CategoryType.py, categoryType == CategoryType.py),
              const SizedBox(
                width: 17,
              ),
              getButtonUI(
                  CategoryType.webdev, categoryType == CategoryType.webdev),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: <Widget>[
              getButtonUI(CategoryType.java, categoryType == CategoryType.java),
              const SizedBox(
                width: 17,
              ),
              getButtonUI(
                  CategoryType.vuejs, categoryType == CategoryType.vuejs),
              const SizedBox(
                width: 17,
              ),
              getButtonUI(
                  CategoryType.pentaho, categoryType == CategoryType.pentaho),
              const SizedBox(
                width: 17,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void moveToSeeAll() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => CoursesHomeScreen(),
      ),
    );
  }

  Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
    String txt = '';
    if (CategoryType.ui == categoryTypeData) {
      txt = 'Ui/Ux';
    } else if (CategoryType.coding == categoryTypeData) {
      txt = 'Codar';
    } else if (CategoryType.basic == categoryTypeData) {
      txt = '  Web Design';
    } else if (CategoryType.csharp == categoryTypeData) {
      txt = 'Csharp';
    } else if (CategoryType.webdev == categoryTypeData) {
      txt = 'Web';
    } else if (CategoryType.py == categoryTypeData) {
      txt = 'Python';
    } else if (CategoryType.redes == categoryTypeData) {
      txt = 'Redes';
    } else if (CategoryType.java == categoryTypeData) {
      txt = 'Java';
    } else if (CategoryType.vuejs == categoryTypeData) {
      txt = 'VueJs';
    } else if (CategoryType.pentaho == categoryTypeData) {
      txt = 'Pentaho';
    }

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? AppTheme.nearlyBlue : AppTheme.nearlyWhite,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: AppTheme.nearlyBlue)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {
              setState(() {
                categoryType = categoryTypeData;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 18, right: 18),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.25,
                    color:
                        isSelected ? AppTheme.nearlyWhite : AppTheme.nearlyBlue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
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

enum CategoryType {
  ui,
  coding,
  basic,
  webdev,
  webdesign,
  py,
  csharp,
  redes,
  java,
  vuejs,
  pentaho
}
