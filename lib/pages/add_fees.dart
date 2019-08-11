import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:fitattend/utils/navbar.dart';
import 'package:fitattend/utils/database_helper.dart';
import 'package:fitattend/utils/textbox.dart';

class AddFees extends StatefulWidget {
  @override
  _AddFeesState createState() => _AddFeesState();
}

class _AddFeesState extends State<AddFees> {
  var dropdownValue = "One";


  _AddFeesState(){
    _loadStudents();
  }

  var day = DateTime.now().day;
  var month = DateTime.now().month;
  var year = DateTime.now().year;
  var selectedDate;

  var selectedStudent = Student();
  var students = List<Student>();
  var _suggestController = TextEditingController();
  var _ammountController = TextEditingController();

  _loadStudents() async {
    students = await DatabaseHelper().getStudentsStructured();
  }

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
                   Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.only(left: 16.0,right: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text("Student Name",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),

                              TypeAheadField(
                                textFieldConfiguration: TextFieldConfiguration(
                                    decoration: InputDecoration(
                                        suffixIcon: Icon(Icons.search,
                                          color: Colors.white,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white
                                          ),
                                        ),
                                        enabledBorder:OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white
                                          ),
                                        ),
                                        hintText: "Enter Name",
                                        hintStyle: TextStyle(
                                            color: Colors.white
                                        )
                                    ),
                                  controller: _suggestController
                                ),

                                suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Colors.grey
                                ),

                                suggestionsCallback: (pattern) async {
                                  List<String> suggestions = List<String>();
                                  for(var item in students){
                                    if(item.name.toLowerCase().contains(pattern.toLowerCase())){
                                      suggestions.add(item.name);
                                    }
                                  }
                                  return suggestions;
                                },

                                itemBuilder: (context,suggestion){
                                  return ListTile(
                                    title: Text(suggestion),
                                  );
                                },

                                onSuggestionSelected: (suggestionText){
                                  _suggestController.text = suggestionText;
                                  for(var item in students){
                                    if(suggestionText == item.name){
                                      selectedStudent = item;
                                    }
                                  }
                                  print(selectedStudent);
                                },

                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(16.0),
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

                        TextBoxCustom(
                          labelString: "Amount",
                          hintText: "Enter Amount Recieved",
                          controller: _ammountController,
                          textInputType: TextInputType.numberWithOptions(),
                        ),

                        Theme(
                            data: ThemeData(
                              canvasColor: Colors.grey,
                              textTheme: TextTheme(
                                button: TextStyle(
                                  color:Colors.blue
                                )
                              )
                            ),
                            child: DropdownButton<String>(
                                value: dropdownValue,
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                  });
                                },
                                items: <String>['One', 'Two', 'Free', 'Four']
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,
                                    ),
                                  );
                                }).toList()),
                        ),
                      ],
                    ),

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
