import 'dart:async';

import 'package:brts/initial%20screen/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:brts/data.dart';
import 'package:brts/initial%20screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:marquee/marquee.dart';
import 'package:brts/drawerscreen/contactus.dart';
import 'package:brts/drawerscreen/mytransaction.dart';
import 'package:brts/drawerscreen/mytrips.dart';

class feedback extends StatefulWidget {
  @override
  _feedbackState createState() => _feedbackState();
}

class _feedbackState extends State<feedback> {
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
        body: feedbackScreen(),
      ),
    );
  }
}

class feedbackScreen extends StatefulWidget {
  @override
  _feedbackScreenState createState() => _feedbackScreenState();
}

class _feedbackScreenState extends State<feedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  int _state = 0;
  CollectionReference _auth = FirebaseFirestore.instance.collection('feedback');

  @override
  Widget build(BuildContext context) {
    Future<int> sendFeedbackData() async {
      UserCredential userCredential;
      try {
        userCredential = await FirebaseFirestore.instance
            .collection('feedback')
            .add({
          'comment': Data.comment,
          'phone': Data.phone,
          'user_id': Data.getUid()
        }).then((value) async {
          Data.showToast('Thanks for your valueable feedback');
        });
        _state = 1;
        print(Data.phone);
      } catch (e) {
        Data.showToast("Error : ${e.toString()}");
      }
    }

    Firebase.initializeApp();
    return Scaffold(
      backgroundColor: Colors.yellow[800],
      body: Center(
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 6,
                  onChanged: (value) => Data.comment = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "fill the details first";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Feedback",
                    labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white, width: 2), //starting
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white, width: 2), //onwriting
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(Icons.feedback, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                MaterialButton(
                  child: setUpButtonChild(),
                  color: Colors.redAccent,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _state = 0;
                      setState(() {
                        if (_state == 0) {
                          animateButton();
                        }
                      });
                      sendFeedbackData();
                    }
                  },
                )
              ],
            )),
      ),
    );
  }

  void animateButton() {
    setState(() {
      _state = 1;
    });

    Timer(Duration(milliseconds: 2000), () {
      setState(() {
        _state = 2;
      });
    });
  }

  Widget setUpButtonChild() {
    if (_state != 1) {
      return new Text(
        "REGISTER",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    }
  }
}
