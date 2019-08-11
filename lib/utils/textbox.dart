import 'package:flutter/material.dart';

class TextBoxCustom extends StatefulWidget {
  String labelString;
  String hintText;
  TextEditingController controller;
  TextInputType textInputType;

  TextBoxCustom({this.labelString, this.hintText, this.controller,this.textInputType});

  @override
  _TextBoxCustomState createState() => _TextBoxCustomState();
}

class _TextBoxCustomState extends State<TextBoxCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                widget.labelString,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                hintText: widget.hintText,
                hintStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
              controller: widget.controller,
              keyboardType: (widget.textInputType!=null)?widget.textInputType:TextInputType.text,
            ),
          ],
        ),
      ),
    );
  }
}
