import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:esys_flutter_share/esys_flutter_share.dart';

class GenerateReceipt extends StatefulWidget {

  String studentName;
  String amount;
  String date;
  String periodInMonths;

  GenerateReceipt({@required this.studentName,@required this.amount,@required this.date,@required this.periodInMonths});

  @override
  _GenerateReceiptState createState() => _GenerateReceiptState();
}

class _GenerateReceiptState extends State<GenerateReceipt> {
  static var globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Container(
          color: Colors.grey,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                    "Share",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.0
                  ),
                ),
              ),

              RepaintBoundary(
                key: globalKey,
                child: Card(
                  child: Container(
                    height: 300,
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text("Dear ${widget.studentName},",
                            style: TextStyle(
                              fontSize: 20.0
                            ),
                          ),
                          Text("We have recieved an amount of Rs. ${widget.amount} from you on Dt. ${widget.date} for a period of ${widget.periodInMonths} months.",
                              style: TextStyle(
                              fontSize: 20.0
                          ),
                          ),
                          Text("Thank you,",
                            style: TextStyle(
                                fontSize: 20.0
                            )
                          ),

                          Text("Manan Narkar",
                              style: TextStyle(
                                  fontSize: 20.0
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(icon: Icon(Icons.share,
                  color: Colors.white,
                  size: 50,
                ), onPressed: ()async {
                  var bytes = await _capturePng();
                  await Share.file("Fees Details", "GaneshFees082019", bytes, "image/png");
                }),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

  Future<Uint8List> _capturePng() async {
    RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    return pngBytes;
  }
}
