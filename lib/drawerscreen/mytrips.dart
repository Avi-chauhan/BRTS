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

import 'package:brts/drawerscreen/contactus.dart';
import 'package:brts/drawerscreen/feedback.dart';
import 'package:brts/drawerscreen/mytransaction.dart';

import 'package:marquee/marquee.dart';

class mytrips extends StatefulWidget {
  @override
  _mytripsState createState() => _mytripsState();
}

class _mytripsState extends State<mytrips> {
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
        body: mytripsScreen(),
      ),
    );
  }
}

class mytripsScreen extends StatefulWidget {
  @override
  _mytripsScreenState createState() => _mytripsScreenState();
}

class _mytripsScreenState extends State<mytripsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("my trips"),
    );
  }
}
