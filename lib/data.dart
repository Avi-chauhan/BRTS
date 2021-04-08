import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

import 'initial screen/login.dart';

class Data {
  static var name, email, passwd, cpasswd, comment, id;
  static var gender = 'Male', phone, age;

  //Members of task:

  static void showToast(var msg1) {
    Fluttertoast.showToast(
      msg: msg1,
      // backgroundColor: HexColor("#2f1970"),
      backgroundColor: Colors.white,
      textColor: Colors.black,
    );
  }

  static void showToast1(var msg1) {
    Fluttertoast.showToast(
      msg: msg1,
      // backgroundColor: HexColor("#2f1970"),
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  static Widget start = Login();
  static String getUid() => FirebaseAuth.instance.currentUser.uid;
  static Future<String> futureGetUid() {
    return Future.value(FirebaseAuth.instance.currentUser.uid);
  }

  static Widget loadingDialog() {
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.yellow[800],
        ),
      ),
    );
  }

  static Future getUS() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(Data.getUid())
        .get();
  }

  static Future<String> getEmail(a) async {
    return await a.data()['email'];
  }

  static String getName(a) {
    return a.data()['name'];
  }

  static String getPhone(a) {
    return a.data()['phone'];
  }

  static String getAge(a) {
    return a.data()['Age'];
  }

  static String getGender(a) {
    return a.data()['Gender'];
  }
}
