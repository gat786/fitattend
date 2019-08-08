import 'package:flutter/material.dart';

import 'package:fitattend/utils/navbar.dart';

class ViewAttendance extends StatefulWidget {
  @override
  _ViewAttendanceState createState() => _ViewAttendanceState();
}

class _ViewAttendanceState extends State<ViewAttendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(86, 83, 83, 1)),
        child: Column(
          children: <Widget>[
            Navbar("View Attendance", true),
            Expanded(
                child: Container(
              child: ListView(
                children: <Widget>[],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
