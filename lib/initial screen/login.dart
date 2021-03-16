import 'dart:async';

import 'package:brts/initial%20screen/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../data.dart';
import 'forget_pasword.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email, passwd;
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool __passwordVisible = false;
  int _state = 0;

  @override
  void initState() {
    super.initState();
    clear = true;
    __passwordVisible = false;
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  DateTime current;

  Future<bool> popped() {
    DateTime now = DateTime.now();
    if (current == null || now.difference(current) > Duration(seconds: 2)) {
      current = now;
      Data.showToast('Press back again to exit!');
      return Future.value(false);
    } else {
      Fluttertoast.cancel();
      return Future.value(true);
    }
  }

  bool click = false;
  Future<bool> getFutureWidget() {
    try {
      Data.getUid();
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  bool clear;
  Future<bool> validateAndException() async {
    setState(() {
      tmp = false;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: passwd)
          .then((value) async {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(Data.getUid())
            .get();
        Map<String, dynamic> data = snapshot.data();
        if (!auth.currentUser.emailVerified) {
          _state = 0;

          auth.currentUser.sendEmailVerification();

          Data.showToast(
              'Please Verify your E-Mail Address,we send new verification link to Your E-mail');
          FirebaseAuth.instance.signOut();
        } else {
          if (data['verified']) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/dashboard', (route) => false);
          } else {
            FirebaseAuth.instance.signOut();
            _state = 0;
            Data.showToast('User not verified by Admin');
          }
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _state = 0;
        Data.showToast('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        _state = 0;
        Data.showToast('Wrong password provided for that user.');
      } else {
        _state = 0;
        Data.showToast(e.message);
      }
    }
    setState(() {
      tmp = true;
    });

    return Future<bool>.value(true);
  }

  String documentId;
  var tmp = false;
  @override
  Widget build(BuildContext context) {
    bool connected;
    return WillPopScope(
      onWillPop: () => popped(),
      child: Scaffold(
        backgroundColor: Colors.yellow[800],
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 100),
          // reverse: true,
          child: FutureBuilder(
              future: getFutureWidget(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          // color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        padding: EdgeInsets.all(18.0),

                        // color: Colors.orange[200],
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(height: 90),
                            Text(
                              'Online BRTS',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 26,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Sign In',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 26,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              autofocus: false,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value.isNotEmpty) {
                                  return null;
                                }
                                return 'Please fill this field.';
                              },
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2), //starting
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 2), //onwriting
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 20, 0, 8),
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: 16),
                                prefixIcon: Icon(
                                  Icons.email_sharp,
                                  color: Colors.white,
                                ),
                                labelText: 'E-Mail',
                              ),
                              onChanged: (val) {
                                email = val;
                              },
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),

                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value.isNotEmpty) {
                                  return null;
                                }

                                return 'Please fill this field.';
                              },
                              // focusNode: FocusNode(canRequestFocus: true),
                              obscureText: !__passwordVisible,
                              onChanged: (val) => passwd = val,
                              decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.vpn_key, color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2), //starting
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 2), //onwriting
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 20, 0, 8),
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: 16),
                                fillColor: Colors.white,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    __passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      __passwordVisible = !__passwordVisible;
                                    });
                                  },
                                ),
                                labelText: 'Password',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                                height: 38,
                                width: double.infinity,
                                child: new MaterialButton(
                                    child: setUpButtonChild(),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        _state = 0;
                                        setState(() {
                                          if (_state == 0) {
                                            animateButton();
                                          }
                                        });
                                        validateAndException();
                                      }
                                    },
                                    textColor: Colors.white,
                                    elevation: 6,
                                    splashColor: Colors.orange,
                                    //minWidth: double.infinity,
                                    height: 68.0,
                                    color: Colors.redAccent)),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgetPassword()));
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                  // valueColor: Colors.amber,
                                );
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Register(),
                                    ));
                              },
                              child: Text(
                                'New User? Register Here',
                                style: TextStyle(
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return Data.loadingDialog();
              }
              // },
              ),
        ),
      ),
    );
  }

  void animateButton() {
    setState(() {
      _state = 1;
    });

    Timer(Duration(minutes: 20), () {
      setState(() {
        _state = 2;
      });
    });
  }

  Widget setUpButtonChild() {
    if (_state != 1) {
      return new Text(
        "Sign In ",
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
