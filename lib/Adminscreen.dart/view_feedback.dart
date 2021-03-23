// import 'dart:html';

// import 'package:firebase/firestore.dart';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class view_feedback extends StatefulWidget {
  @override
  _view_feedbackState createState() => _view_feedbackState();
}

class _view_feedbackState extends State<view_feedback> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: new AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: new Text("Surat BRTS"),
          backgroundColor: Colors.yellow[800],
        ),
        body: view_feedbackScreen(),
      ),
    );
  }
}

class view_feedbackScreen extends StatelessWidget {
  // final String documentId;

  // const view_feedbackScreen({Key key, this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference feedback =
        FirebaseFirestore.instance.collection('feedback');

    return FutureBuilder<DocumentSnapshot>(
      future: feedback.doc.get().then((QuerySnapshot qs) => {
            qs.docs.forEach((element) {
              print(element['comment']);
            })
          }),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Text("Full Name: ${data['comment']} ${data['user_id']}");
        }

        return Text("loading");
      },
    );
  }
}
