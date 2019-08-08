import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  String title;
  bool isBackAllowed;

  Navbar(this.title, this.isBackAllowed);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
            border: BorderDirectional(
                bottom: BorderSide(color: Colors.white.withOpacity(0.4)))),
        child: Padding(
          padding: const EdgeInsets.only(top: 54.0, left: 16.0, bottom: 24.0),
          child: Row(
            children: <Widget>[
              (this.isBackAllowed)
                  ? Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
                  : Container(),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 32.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
