import 'package:flutter/material.dart';

buildIconButton({IconData icon, Function actionFunction}) {
  return Icon(
    icon,
    size: 20.0,
  );
}

buildTextButton({String actionButtonText = "", Function actionFunction}) {
  return Text(actionButtonText,
      style: TextStyle(
          fontFamily: "Ubuntu",
          fontWeight: FontWeight.w600,
          color: Colors.black));
}

AppBar header(
  context, {
  bool isAppTitle = false,
  String titleText,
  bool isIconButton = false,
  bool hasActionButton = false,
}) {
  return AppBar(
    automaticallyImplyLeading: true,
    iconTheme: IconThemeData(
      color: Colors.black, //change your color here
    ),
    bottom: PreferredSize(
        child: Container(
          color: Colors.black,
          height: 0.3,
        ),
        preferredSize: Size.fromHeight(1.0)),
    elevation: 0.0,
    brightness: Brightness.light,
    backgroundColor: Colors.transparent,
    title: Text(
      isAppTitle ? "FlutterShare" : titleText,
      style: TextStyle(
          color: Colors.black,
          fontFamily: "Ubuntu",
          fontWeight: FontWeight.w700,
          fontSize: 22.0),
    ),
    actions: <Widget>[
      hasActionButton
          ? FlatButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: isIconButton ? buildIconButton() : buildTextButton(),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            )
          : FlatButton(
              onPressed: () => print("pressed"),
              child: null,
            ),
    ],
    //leading: new Container(),
    centerTitle: false,
  );
}
