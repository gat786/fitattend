import 'package:flutter/material.dart';

import 'package:fitattend/utils/navbar.dart';

class ViewStudents extends StatefulWidget {
  @override
  _ViewStudentsState createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<ViewStudents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(86, 83, 83, 1)),
        child: Column(
          children: <Widget>[
            Navbar("View Students", true),
            Expanded(
                child: Container(
              child: ListView(
                children: <Widget>[
                  _studentCard(studentName: "Lincoln Burrows")
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget _studentCard({studentName}) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, left: 16.0),
      child: Container(
        height: 100.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            color: Color.fromRGBO(112, 112, 112, 1)),
        child: Center(
          child: Text(
            studentName,
            style: TextStyle(color: Colors.white, fontSize: 24.0),
          ),
        ),
      ),
    );
  }
}
