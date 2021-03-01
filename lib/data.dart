import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

class Data {
  static var name = 'student', email = 'ajraval102@gmail.com', passwd, cpasswd

      //Members of task:
      ;

  static void showToast(var msg1) {
    Fluttertoast.showToast(
      msg: msg1,
      // backgroundColor: HexColor("#2f1970"),
      backgroundColor: Colors.black26,
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
          backgroundColor: Colors.amber,
        ),
      ),
    );
  }
}
