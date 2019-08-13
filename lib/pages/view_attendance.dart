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
  var _eventList = EventList<Map>();
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
                                var db = DatabaseHelper();
                                var results = await db.getAttendanceDetailed();
                                generateEventsMap(results);
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
                  markedDatesMap: _eventList,
                  markedDateIconBuilder: (event){
                    return Container(
                      height: 40.0,
                      width: 40.0,
                      color: Colors.green,
                      child: Center(child: Text(
                          event["date"].toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                    );
                  },
                  todayButtonColor: Colors.white.withAlpha(50),
                )
              )
            )
          ],
        ),
      ),
    );
  }


  void generateEventsMap(results) {
    print(results);
    for(var record in results){
        var date = DateTime.parse(record["date"]);
        var timing = record["timing"];

        var reqDate = DateTime(date.year,date.month,date.day);
        var items = {
          "date":date.day,
          "timing":timing
        };

        _eventList.add(reqDate, items);
    }
  }
}

