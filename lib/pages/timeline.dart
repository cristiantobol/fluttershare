import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/header.dart';
import 'package:fluttershare/widgets/progress.dart';

final CollectionReference usersRef = Firestore.instance.collection('users');

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  void initState() {
    super.initState();
  }

  createUser() async {
    await usersRef
        .document("dsadasdasdasda")
        .setData({"username": "Jeff", "isAdmin": false, "postsCount": 0});
  }

  updateUser() async {
     final DocumentSnapshot doc = await usersRef
      .document("HUUO7tbhBsTNBC9e6XWG").get();

     if (doc.exists) {
       doc.reference.updateData({"username": "Jeff", "isAdmin": false, "postsCount": 0});
     }
  }

  deleteUSer() async {
    final DocumentSnapshot doc = await usersRef
        .document("HUUO7tbhBsTNBC9e6XWG").get();

    if (doc.exists) {
      doc.reference.delete();
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: StreamBuilder<QuerySnapshot>(
          stream: usersRef.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return circularProgress();
            }

            final List<Text> children = snapshot.data.documents
                .map((doc) => Text(doc['username']))
                .toList();

            return Container(
              child: ListView(
                children: children,
              ),
            );
          }),
    );
  }
}
