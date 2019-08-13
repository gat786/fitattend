import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

import 'package:fitattend/utils/navbar.dart';
import 'package:fitattend/utils/database_helper.dart';
import 'package:fitattend/utils/textbox.dart';
import 'package:fitattend/utils/suggestion_field.dart';

class AddFees extends StatefulWidget {
  @override
  _AddFeesState createState() => _AddFeesState();
}

class _AddFeesState extends State<AddFees> {
  var dropdownValue;

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
                                  var helper = new DatabaseHelper();
                                  helper.addFees(fees);
                                  _showSuccessDialog();
                                  this.setState((){

                                  });
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

  _clearAllFields(){
    _suggestController.text = "";
    _ammountController.text = "";
    dropdownValue = "1";
    var now = DateTime.now();
    day = now.day;
    month = now.month;
    year = now.year;
  }

  _showSuccessDialog(){
    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("Fees was successfully added to database"),
        actions: <Widget>[
          FlatButton(onPressed: ()
            {
              Navigator.pop(context);
              _clearAllFields();
            },
            child: Text("Okay")
          ),
          FlatButton(onPressed: (){
            
          },
            child: Text("Share"),
          )
        ],
      );
    });
  }

  _builtNoMonthsSelector(){
    var list = List<Map<String,String>>();
    for(int i = 1; i <= 12; i++){
      var item = {
        "display": "$i",
        "value": "$i",
      };
      list.add(item);
    }

    Widget dropdown = Theme(
      data: ThemeData.dark(),
      child: Column(
        children: <Widget>[

          Container(
            width: 200,
            child: DropDownFormField(
              titleText: "Number of Months",
              hintText: "Please select one",
              dataSource: list,
              textField: 'display',
              valueField: 'value',
              value:dropdownValue,
              onChanged: (val){
                setState(() {
                  dropdownValue = val;
                });
              },
              onSaved: (val){
                setState(() {
                  dropdownValue = val;
                });
              },
              errorText: "Cannot be Empty",
              validator: (value){
                return (value == null || value == "")?"Cannot be empty":null;
              }
            ),
          ),
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
