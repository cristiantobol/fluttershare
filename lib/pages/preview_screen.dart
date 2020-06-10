import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttershare/widgets/header.dart';
import 'package:line_icons/line_icons.dart';
import 'package:path/path.dart';

class PreviewScreen extends StatefulWidget {
  final String imgPath;

  PreviewScreen({this.imgPath});

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: header(context, titleText: ""),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Image.file(File(widget.imgPath),fit: BoxFit.cover,),
//              child: Image.asset(
//                'assets/images/selfie.jpg',
//                fit: BoxFit.cover,
//              ),
            ),
            Row(
                //alignment: Alignment.bottomCenter,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Colors.white.withOpacity(0.5),
                    child: Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(LineIcons.share_alt, color: Colors.grey,),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent, // makes highlight invisible too
                          visualDensity: VisualDensity.compact,
                          onPressed: () {
                            getBytesFromFile().then((bytes) {
                              Share.file('Share via', basename(widget.imgPath),
                                  bytes.buffer.asUint8List(), 'image/path');
                            });
                          },
                        ),
                        Text("Post", style: TextStyle(
                            fontFamily: "Ubuntu",
                            fontWeight: FontWeight.w300
                        ),),
                      ]
                    ),
                  ),
                  Container(
                    color: Colors.white.withOpacity(0.5),
                    child: Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(LineIcons.times_circle, color: Colors.grey,),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent, // makes highlight invisible too
                            visualDensity: VisualDensity.compact,
                            onPressed: () => Navigator.of(context).pop(null),
                          ),
                          Text("Cancel", style: TextStyle(
                            fontFamily: "Ubuntu",
                            fontWeight: FontWeight.w300
                          ),),
                        ]
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }

  Future<ByteData> getBytesFromFile() async {
    Uint8List bytes = File(widget.imgPath).readAsBytesSync();
    return ByteData.view(bytes.buffer);
  }
}
