import 'package:find_a_tutor/src/ui/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:find_a_tutor/src/models/checkbox_state.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:table_calendar/table_calendar.dart';

class DetailClass extends StatefulWidget {
  @override
  _DetailClassState createState() => _DetailClassState();
}

final notifications = [
  CheckBoxState(title: 'Título 1'),
  CheckBoxState(title: 'Título 2'),
  CheckBoxState(title: 'Título 3'),
  CheckBoxState(title: 'Título 4'),
];
DateTime selectedDay = DateTime.now();
DateTime focusedDay = DateTime.now();

class _DetailClassState extends State<DetailClass> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Detalhes das turmas",
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
        body: Column(
          children: <Widget>[
            Container(
              height: 200,
              width: 500,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 15, left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: AssetImage("assets/images/redes.jpg"),
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
            Container(
              padding: EdgeInsets.only(top: 25, left: 20, right: 222),
              child: Text(
                'Redes de computadores',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  letterSpacing: 0.27,
                  color: AppTheme.darkerText,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: tabButton(),
            )
          ],
        ),
      ),
    );
  }

  Widget tabButton() {
    return Column(
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
                  text: 'Calendário',
                  icon: Icon(Icons.calendar_today),
                  iconMargin: const EdgeInsets.only(top: 3, bottom: 8),
                ),
                Tab(
                  text: 'Postagens',
                  iconMargin: const EdgeInsets.only(top: 5, bottom: 6),
                  icon: Icon(Icons.computer_rounded),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            children: [
              classTab(),
              calendarTab(),
              postTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget classTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 60, left: 0, right: 0),
          child: Text(
            'Link para a aula ',
            style: TextStyle(color: Colors.black, fontSize: 23),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20, left: 0, right: 0),
          child: GestureDetector(
              child: Text(
                'Clique aqui',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                    fontSize: 23),
                textAlign: TextAlign.left,
              ),
              onTap: () {}),
        ),
      ],
    );
  }

  Widget calendarTab() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: TableCalendar(
        rowHeight: 40,
        focusedDay: selectedDay,
        firstDay: DateTime(1990),
        lastDay: DateTime(2050),
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(color: Colors.white),
        ),
        onDaySelected: (DateTime selectDay, DateTime focusDay) {
          setState(() {
            selectedDay = selectDay;
            focusedDay = focusDay;
          });
        },
        selectedDayPredicate: (DateTime date) {
          return isSameDay(selectedDay, date);
        },
      ),
    );
  }

  Widget postTab() => Column(
        children: [
          ...notifications.map(buildSingleCheckBox).toList(),
        ],
      );

  Widget buildSingleCheckBox(CheckBoxState checkbox) => CheckboxListTile(
        title: Text(checkbox.title),
        subtitle: Text("Subtítulo, descrição da postagem realizada!"),
        controlAffinity: ListTileControlAffinity.leading,
        value: checkbox.value,
        onChanged: (value) {
          setState(
            () {
              checkbox.value = value;
              createAlertDialog(checkbox);
            },
          );
        },
        activeColor: Colors.blue,
        checkColor: Colors.white,
      );

  createAlertDialog(CheckBoxState checkbox) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(checkbox.title),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Descrição da postagem realizada pelo tutor'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
