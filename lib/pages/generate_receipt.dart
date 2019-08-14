import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:fitattend/utils/database_helper.dart';

class GenerateReceipt extends StatefulWidget {

  @override
  _GenerateReceiptState createState() => _GenerateReceiptState();
}

class _GenerateReceiptState extends State<GenerateReceipt> {
  var ifloadingfile = false;
  static var globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final FeesReceiptBuildingInformation info = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Material(
        child: Stack(
          children: <Widget>[

            Container(
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
                              Text("Dear ${info.name},",
                                style: TextStyle(
                                  fontSize: 20.0
                                ),
                              ),
                              Text("We have recieved an amount of Rs. ${info.amount} from you on Dt. ${info.date} for a period of ${info.periodInMonths} months.",
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
                      setState(() {
                        ifloadingfile = true;
                      });
                      var bytes = await _capturePng();
                      await Share.file("Fees Details", "GaneshFees082019", bytes, "image/png").then((val){
                        setState(() {
                          ifloadingfile = false;
                        });
                      });
                    }),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),

          (ifloadingfile)?Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black54,
              child: Center(
                child: Container(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(

                  ),
                ),
              ),
            ):Container(),
          ],
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
