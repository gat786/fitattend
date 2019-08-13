import 'package:flutter/material.dart';

import 'package:fitattend/utils/navbar.dart';
import 'package:fitattend/utils/database_helper.dart';
import 'package:fitattend/utils/suggestion_field.dart';

class AddAttendance extends StatefulWidget {
  @override
  _AddAttendanceState createState() => _AddAttendanceState();
}

class _AddAttendanceState extends State<AddAttendance> {


  var day = DateTime.now().day;
  var month = DateTime.now().month;
  var year = DateTime.now().year;
  var valueToStore = DateTime.now().toString();
  var selectedDate;

  var selectedStudent = Student();
  var students = List<Student>();
  var _suggestController = TextEditingController();

  var _defaultDropdownValue;

  static var _formkey = GlobalKey<FormState>();

  var dropdownValue = "SelectSomething";
  @override
  Widget build(BuildContext context) {

    var selectedDate = "$day/$month/$year";

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(86, 83, 83, 1)),
        child: Column(
          children: <Widget>[
            Navbar("Add Attendance", true),
            Expanded(
                child: Container(
              child: ListView(
                children: <Widget>[
                  Form(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0,right: 16.0),
                      child: Column(
                        children: <Widget>[
                          AutoCompleteFieldStudent(_suggestController, (Student student){
                            selectedStudent = student;
                          }),

                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Column(
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
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0,top: 8.0,right: 16.0),
                                child: Text(
                                  "Select Time Slot",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              Theme(
                                data: ThemeData.dark(),
                                child: Container(
                                  width: 200,
                                  child: DropdownButtonFormField<String>(
                                    items: [
                                      DropdownMenuItem<String>(
                                        child: Text("Select a timing"),
                                        value: "SelectSomething",
                                      ),
                                      DropdownMenuItem<String>(
                                        child: Text("6 - 7 morning"),
                                        value: "6 - 7 morning",
                                      ),
                                      DropdownMenuItem<String>(
                                        child: Text("7 - 8 morning"),
                                        value: "7 - 8 morning",
                                      ),
                                      DropdownMenuItem<String>(
                                        child: Text("5 - 6 evening"),
                                        value: "5 - 6 evening",
                                      ),
                                      DropdownMenuItem<String>(
                                        child: Text("6 - 7 evening"),
                                        value: "6 - 7 evening",
                                      )
                                    ],
                                    value: dropdownValue,
                                    onChanged: (val){
                                      setState(() {
                                        dropdownValue = val;
                                      });
                                    },
                                    validator: (val) => (val==dropdownValue)?"Please Choose something":null,

                                  ),
                                ),
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: OutlineButton(
                                onPressed: (){
                                  var form = _formkey.currentState;
                                  if(form.validate()) {
                                    var attendanceInstance = Attendance(
                                        studentId: selectedStudent.id,
                                        date: valueToStore,
                                        timing: _defaultDropdownValue
                                    );
                                    var helper = DatabaseHelper();
                                    helper.addAttendance(attendanceInstance);
                                  }
                                },
                                borderSide: BorderSide(color: Colors.white),
                                child: Text("Add",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    key: _formkey,
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
      valueToStore = picked.toString();
      setState(() {});
    }
  }
}
