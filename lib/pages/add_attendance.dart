import 'package:flutter/material.dart';

import 'package:fitattend/utils/navbar.dart';

class AddAttendance extends StatefulWidget {
  @override
  _AddAttendanceState createState() => _AddAttendanceState();
}

class _AddAttendanceState extends State<AddAttendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(86, 83, 83, 1)),
        child: Column(
          children: <Widget>[
            Navbar("Add Attendance", true),
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
