import 'package:flutter/material.dart';

import "package:fitattend/pages/view_students.dart";
import 'package:fitattend/pages/add_students.dart';
import 'package:fitattend/pages/add_attendance.dart';
import 'package:fitattend/pages/view_attendance.dart';
import 'package:fitattend/pages/add_fees.dart';
import 'package:fitattend/pages/view_fees.dart';

import 'package:fitattend/utils/navbar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        textTheme: TextTheme(
          subhead: TextStyle(
            color: Colors.white
          )
        )
      ),
      home: MyHomePage(),
      routes: {
        'viewstudents': (context) => ViewStudents(),
        'addstudents': (context) => AddStudents(),
        'addattendance': (context) => AddAttendance(),
        'viewattendance': (context) => ViewAttendance(),
        'viewfees': (context) => ViewFees(),
        'addfees': (context) => AddFees()
      },
    );
  }
}

enum Pages {
  viewStudents,
  addStudents,
  addAttendance,
  viewAttendance,
  addFees,
  viewFees
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(86, 83, 83, 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Navbar("Hey There,", false),
            Expanded(
              child: Container(
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        OptionsCard(Pages.addStudents),
                        OptionsCard(Pages.viewStudents)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        OptionsCard(Pages.addAttendance),
                        OptionsCard(Pages.viewAttendance)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        OptionsCard(Pages.addFees),
                        OptionsCard(Pages.viewFees)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget OptionsCard(cardType) {
    String cardTitle = "";
    String routeName = "";

    switch (cardType) {
      case Pages.viewStudents:
        cardTitle = "View Students";
        routeName = "viewstudents";
        break;
      case Pages.addStudents:
        cardTitle = "Add Students";
        routeName = "addstudents";
        break;
      case Pages.viewAttendance:
        cardTitle = "View Attendance";
        routeName = "viewattendance";
        break;
      case Pages.addAttendance:
        cardTitle = "Add Attendance";
        routeName = "addattendance";
        break;
      case Pages.viewFees:
        cardTitle = "View Fees Paid";
        routeName = "viewfees";
        break;
      case Pages.addFees:
        cardTitle = "Add Fees Payment";
        routeName = "addfees";
        break;
      default:
        cardTitle = "Default Title";
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        elevation: 4.0,
        color: Color.fromRGBO(112, 112, 112, 1),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, routeName);
          },
          child: Container(
              height: (MediaQuery.of(context).size.width / 2) - 40,
              width: (MediaQuery.of(context).size.width / 2) - 40,
              child: Center(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  cardTitle,
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ))),
        ),
      ),
    );
  }
}
