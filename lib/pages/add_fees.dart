import 'package:flutter/material.dart';

import 'package:fitattend/utils/navbar.dart';
import 'package:fitattend/utils/database_helper.dart';
import 'package:fitattend/utils/textbox.dart';
import 'package:fitattend/utils/suggestion_field.dart';

class AddFees extends StatefulWidget {
  @override
  _AddFeesState createState() => _AddFeesState();
}

class _AddFeesState extends State<AddFees> {
  var dropdownValue = "No of months";

  var day = DateTime.now().day;
  var month = DateTime.now().month;
  var year = DateTime.now().year;
  var selectedDate;

  var selectedStudent = Student();
  var students = List<Student>();
  var _suggestController = TextEditingController();
  var _ammountController = TextEditingController();

  static var _formkey = GlobalKey<FormState>();
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
                   Form(
                     key: _formkey,
                     child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Padding(
                            padding: const EdgeInsets.only(left: 16.0,right: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[


                                AutoCompleteFieldStudent(_suggestController,(Student student){
                                  selectedStudent = student;
                                })

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

                          Center(
                            child: _builtNoMonthsSelector(),
                          ),


                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: OutlineButton(onPressed: () {
                                var form = _formkey.currentState;
                                if (form.validate()) {
                                  var fees = Fees(
                                      studentId: selectedStudent.id,
                                      amount: _ammountController.text,
                                      forMonths: dropdownValue,
                                      timestamp: DateTime.now().toString()
                                  );

                                  print(selectedStudent);
                                  var helper = new DatabaseHelper();
                                  helper.addFees(fees);
                                }
                              },
                                child: Text("Add",
                                  style: TextStyle(
                                    color:Colors.white
                                  ),
                                ),
                                borderSide: BorderSide(
                                  color:Colors.white
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                   ),

                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  _builtNoMonthsSelector(){
    List<DropdownMenuItem<String>> list = List<DropdownMenuItem<String>>();
    list.add(DropdownMenuItem(child: Text("No of months"),value: dropdownValue,));
    for(int i = 1; i <= 12; i++){
      var item = DropdownMenuItem<String>(
        child: Text("$i"),
        value: "$i",
      );
      list.add(item);
    }

    Widget dropdown = Theme(
      data: ThemeData.dark(),
      child: Column(
        children: <Widget>[
          Text("Select Number of months",
            style: TextStyle(
              color: Colors.white
            ),
          ),

          Container(
            width: 200,
            child: DropdownButtonFormField<String>(
              items: list,
              value: dropdownValue,
              onChanged: (val){
                setState(() {
                  dropdownValue = val;
                });
              },
              validator: (val) => (val==dropdownValue)?"Please Choose something":null,

            ),
          ),

//          DropdownButton<String>(
//            value: dropdownValue,
//            iconEnabledColor: Colors.white,
//              onChanged: (newValue) {
//                setState(() {
//                  dropdownValue = newValue;
//                });
//              },
//              items: list,
//            hint: Text("Number of months"),
//          ),
        ],
      )
    );
    return dropdown;
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
