import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

import 'package:fitattend/utils/navbar.dart';
import 'package:fitattend/utils/database_helper.dart';
import 'package:fitattend/utils/suggestion_field.dart';

class ViewAttendance extends StatefulWidget {
  @override
  _ViewAttendanceState createState() => _ViewAttendanceState();
}

class _ViewAttendanceState extends State<ViewAttendance> {
  TextEditingController _controller = TextEditingController();
  Student _selectedStudent;
  var attendance;
  bool isAttendanceLoaded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(86, 83, 83, 1)),
        child: Column(
          children: <Widget>[
            Navbar("View Attendance", true),
            Expanded(
              child: (isAttendanceLoaded)?Container(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          AutoCompleteFieldStudent(_controller, (Student student){
                            _selectedStudent = student;
                          }),

                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: OutlineButton(
                              onPressed: ()async {
                                attendance = await DatabaseHelper().getAttendance(_selectedStudent.id);
                                print(attendance);
                                setState(() {
                                  isAttendanceLoaded = false;
                                });
                              },
                              borderSide: BorderSide(color: Colors.white),
                              child: Text("View",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
              : Container(
                child: CalendarCarousel(
                  weekdayTextStyle: TextStyle(
                    color: Colors.white
                  ),
                  daysTextStyle: TextStyle(
                    color: Colors.white
                  ),
                  weekendTextStyle: TextStyle(
                    color: Colors.yellow
                  ),
                )
              )
            )
          ],
        ),
      ),
    );
  }
}
