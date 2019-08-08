import 'package:flutter/material.dart';

import 'package:fitattend/utils/navbar.dart';

class ViewFees extends StatefulWidget {
  @override
  _ViewFeesState createState() => _ViewFeesState();
}

class _ViewFeesState extends State<ViewFees> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(86, 83, 83, 1)),
        child: Column(
          children: <Widget>[
            Navbar("View Fees Paid", true),
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
