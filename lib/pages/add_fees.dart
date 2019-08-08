import 'package:flutter/material.dart';

import 'package:fitattend/utils/navbar.dart';

class AddFees extends StatefulWidget {
  @override
  _AddFeesState createState() => _AddFeesState();
}

class _AddFeesState extends State<AddFees> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(86, 83, 83, 1)),
        child: Column(
          children: <Widget>[
            Navbar("Add Fees", true),
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
