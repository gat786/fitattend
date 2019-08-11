import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';

import 'package:fitattend/utils/database_helper.dart';

class AutoCompleteFieldStudent extends StatefulWidget {
  TextEditingController _controller;
  void Function(Student) callback;

  AutoCompleteFieldStudent(this._controller,this.callback);

  @override
  _AutoCompleteFieldStudentState createState() => _AutoCompleteFieldStudentState();
}

class _AutoCompleteFieldStudentState extends State<AutoCompleteFieldStudent> {

  _AutoCompleteFieldStudentState(){
    _loadStudents();
  }

  var students = List<Student>();

  _loadStudents() async {
    students = await DatabaseHelper().getStudentsStructured();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  hintText: "Enter Name to Search",
                  hintStyle: TextStyle(
                      color: Colors.white
                  )
              ),
              controller: widget._controller
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
            widget._controller.text = suggestionText;
            for(var item in students){
              if(suggestionText == item.name){
                widget.callback(item);
              }
            }
          },

        ),
      ],
    );
  }
}
