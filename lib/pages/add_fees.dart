import 'package:flutter/material.dart';

import 'package:fitattend/utils/navbar.dart';
import 'package:fitattend/utils/textbox.dart';

class AddFees extends StatefulWidget {
  @override
  _AddFeesState createState() => _AddFeesState();
}

class _AddFeesState extends State<AddFees> {

  var day = DateTime.now().day;
  var month = DateTime.now().month;
  var year = DateTime.now().year;
  var selectedDate;

  @override
  Widget build(BuildContext context) {
    var selectedDate = "$day/$month/$year";
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(86, 83, 83, 1)),
        child: Column(
          children: <Widget>[
            Navbar("Add Fees", true),
            Expanded(
                child: Container(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Select Date",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                selectedDate,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32.0),
                              ),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _showDatePicker();
                                })
                          ],
                        ),

                        TextBoxCustom("Student Name",
                          "Enter Student Name",
                        )
                      ],
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  _showDatePicker() async {
    DateTime picked = await showDatePicker(
        context: context,
        firstDate: DateTime(2018),
        initialDate: DateTime(year, month, day),
        lastDate: DateTime(2030),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark(),
            child: child,
          );
        });
    if (picked != null) {
      day = picked.day;
      month = picked.month;
      year = picked.year;
      setState(() {});
    }
  }


}
