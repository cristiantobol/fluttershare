import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttershare/widgets/header.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String username;
  String firstName;
  String lastName;

  submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      SnackBar snackbar = SnackBar(
        content: Text("Welcome $username!"),
      );
      _scaffoldKey.currentState.showSnackBar(snackbar);
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context, username);
      });
    }
  }

  @override
  Widget build(BuildContext parentContext) {
    final firstNameField = Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        child: Form(
          child: TextFormField(
            onSaved: (val) => firstName = val,
            decoration: InputDecoration(
              hintText: "First Name",
            ),
          ),
        ),
      ),
    );
    final lastNameField = Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        child: Form(
          child: TextFormField(
            onSaved: (val) => lastName = val,
            decoration: InputDecoration(
              hintText: "Last Name",
            ),
          ),
        ),
      ),
    );
    final usernameField = Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        child: Form(
          key: _formKey,
          child: TextFormField(
            validator: (val) {
              if (val.trim().length < 3 || val.isEmpty) {
                return 'Username is too short';
              } else if (val.trim().length > 12) {
                return 'Username too long';
              } else {
                return null;
              }
            },
            onSaved: (val) => username = val,
            decoration: InputDecoration(
              hintText: "Username",
            ),
          ),
        ),
      ),
    );
    final submitButton = GestureDetector(
      onTap: submit,
      child: Container(
        margin: const EdgeInsets.only(top: 20.0),
        height: 40.0,
        width: 250.0,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(50.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 17,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            "Submit",
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontFamily: "Ubuntu",
                fontWeight: FontWeight.w300),
          ),
        ),
      ),
    );
    final body = Container(
      child: ListView(
        shrinkWrap: true,
        padding: new EdgeInsets.all(55.0),
        children: <Widget>[

          SvgPicture.asset('assets/images/create_account.svg', height: 150.0,),
          firstNameField,
          lastNameField,
          usernameField,
          submitButton
        ],
      ),
    );
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(context, titleText: "Create new account"),
      body: body,
    );
  }
}
