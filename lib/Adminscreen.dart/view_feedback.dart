// import 'dart:html';

// import 'package:firebase/firestore.dart';
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

class view_feedbackScreen extends StatefulWidget {
  @override
  _view_feedbackScreenState createState() => _view_feedbackScreenState();
}

class _view_feedbackScreenState extends State<view_feedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        // <2> Pass `Future<QuerySnapshot>` to future
        future: FirebaseFirestore.instance.collection('feedback').get(),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // <3> Retrieve `List<DocumentSnapshot>` from snapshot
            final List<DocumentSnapshot> documents = snapshot.data.docs;
            return ListView(
                children: documents
                    .map((doc) => Card(
                          child: ListTile(
                            title: Text(doc['user_id']),
                            subtitle: Text(doc['comment']),
                          ),
                        ))
                    .toList());
          } else if (snapshot.hasError) {
            return Text('Its Error!');
          }
        });
  }
}
