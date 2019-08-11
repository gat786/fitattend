import 'package:flutter/material.dart';

import 'package:fitattend/utils/navbar.dart';
import 'package:fitattend/utils/database_helper.dart';

class ViewFees extends StatefulWidget {
  @override
  _ViewFeesState createState() => _ViewFeesState();
}

class _ViewFeesState extends State<ViewFees> {

  _ViewFeesState(){
    _getFees();
  }

  var listFeesItem = List<Widget>();

  _getFees()async{
    var helper = DatabaseHelper();
    var results = await helper.getFeesRecieved();
    print("making list");
    for(var item in results){
      var date = DateTime.parse(item["timestamp"]);
      var _listItem = _listFees(item["name"],item["amount"],"${date.day}.${date.month}.${date.year}");
      listFeesItem.add(_listItem);
    }
    this.setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(86, 83, 83, 1)),
          child: Column(
            children: <Widget>[
              Navbar("View Fees Paid", true),
              Expanded(
                  child: Container(
                    child: ListView(
                      children: <Widget>[

                      ] + listFeesItem,
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      );
    }

  _listFees(name,amount,date){
    return InkWell(
      onTap: (){

      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white.withOpacity(0.1)
            )
          )
          ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 16.0,top: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(name,
                style: TextStyle(color: Colors.white,
                  fontSize: 24.0
                ),
              ),

              Column(
                children: <Widget>[

                  Text("Rs $amount",
                    style: TextStyle(color: Colors.white,
                        fontSize: 16.0
                    ),
                  ),

                  Text(date,
                    style: TextStyle(color: Colors.white,
                        fontSize: 16.0
                    )
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
