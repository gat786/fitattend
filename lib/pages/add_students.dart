import 'package:flutter/material.dart';

import 'package:fitattend/utils/navbar.dart';
import 'package:fitattend/utils/textbox.dart';
import 'package:fitattend/utils/database_helper.dart';

class AddStudents extends StatefulWidget {
  @override
  _AddStudentsState createState() => _AddStudentsState();
}

class _AddStudentsState extends State<AddStudents> {
  var day = DateTime.now().day;
  var month = DateTime.now().month;
  var year = DateTime.now().year;
  var selectedDate;

  var _nameController = new TextEditingController();
  var _cnameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var selectedDate = "$day/$month/$year";
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(86, 83, 83, 1)),
        child: Column(
          children: <Widget>[
            Navbar("Add Students", true),
            Expanded(
              child: Container(
                child: ListView(
                  children: <Widget>[
                    Form(
                      child: Column(
                        children: <Widget>[
                          TextBoxCustom(
                            labelString: "Student Name",
                            hintText: "Enter Student Name",
                            controller: _nameController
                          ),
                          TextBoxCustom(
                            labelString: "Course Name",
                            hintText: "Enter Course Name",
                            controller: _cnameController
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      "Start Date",
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          "Note if you don't select any date it automatically sets todays date",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: OutlineButton(
                                        onPressed: () {
                                          DatabaseHelper helper = DatabaseHelper();
                                          helper.addStudent(Student(
                                            name: _nameController.text,
                                            courseName: _cnameController.text,
                                            startDate: selectedDate
                                          ));
                                          print("added value");
                                        },
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        child: Text(
                                          "Add",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  ],
                ),
              ),
            )
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
