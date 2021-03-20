import 'dart:async';
import 'dart:io';

import 'package:brts/data.dart';
import 'package:brts/initial%20screen/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:path/path.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

List<String> emp_list = [];

class _RegisterState extends State<Register> {
  bool ans;
  int _state = 0;
  bool __passwordVisible1 = false;
  bool __passwordVisible2 = false;
  dynamic groupValue, value = '';

  @override
  void initState() {
    super.initState();
    groupValue = 0;
    value = '';
    __passwordVisible1 = false;
    __passwordVisible2 = false;
    ans = true;
  }

  // File _image;
  CollectionReference _auth = FirebaseFirestore.instance.collection('users');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future<int> RegisterAndSendEmailVerification() async {
      UserCredential userCredential;

      try {
        //var tmp = null;
        // Data.showToast(tmp);
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: Data.email, password: Data.passwd)
            .then(
          (value) async {
            userCredential = value;
            await _auth.doc(value.user.uid).set({
              'name': Data.name,
              'Age': Data.age,
              'Gender': Data.gender,
              'phone': Data.phone,
              'email': Data.email,
              'id': value.user.uid.toString(),
            }).then(
              (val) async {
                //print("<<<<<<<  UPLOAD user data >>>>>>   completed");
                Data.showToast('Registration is Successful...');
                FirebaseAuth.instance.currentUser.sendEmailVerification();
                Data.showToast(
                    'E-Mail Verification Code is Sent to Your E-mail Address');

                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Login()),
                    (route) => false);
              },
            );
          },
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Data.showToast('The password provided is too weak.');
          _state = 0;
        } else if (e.code == 'email-already-in-use') {
          Data.showToast('The account already exists for that email.');
          FirebaseAuth.instance.signOut();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (BuildContext context) => Login()),
              (route) => false);
        } else {
          Data.showToast(e.message);
          //print("Inside else");
        }
      } catch (e) {
        Data.showToast("Error : ${e.toString()}");
      }

      return 1;
    }

    Firebase.initializeApp();
    return Scaffold(
      backgroundColor: Colors.yellow[800],
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              // reverse: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Text(
                    'Register To Ride!',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // SizedBox(height: 15),
                  TextFormField(
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return 'Please fill this field';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => Data.name = value,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white, width: 2), //starting
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white, width: 2), //onwriting
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(Icons.person, color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  TextFormField(
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return 'Please fill this field';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => Data.age = value,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white, width: 2), //starting
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white, width: 2), //onwriting
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(Icons.calendar_today_rounded,
                          color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      child: Text(
                        'Gender',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),

                      border: Border.all(
                          style: BorderStyle.solid,
                          color: Colors.white,
                          width: 2),
                      // color: Colors.amber,
                    ),
                    child: Row(
                      children: [
                        Radio(
                          value: 0,
                          activeColor: Colors.white,
                          groupValue: groupValue,
                          onChanged: (arg) {
                            setState(() {
                              groupValue = arg;
                              value = "Male";
                              ans = true;
                              Data.gender = value;
                            });
                          },
                        ),
                        Text(
                          'Male',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Radio(
                          value: 1,
                          activeColor: Colors.white,
                          groupValue: groupValue,
                          onChanged: (arg) {
                            setState(() {
                              groupValue = arg;
                              value = "Female";
                              ans = false;
                              Data.gender = value;
                              //print("sant....${Data.role}");
                              // Data.role = arg;
                            });
                          },
                          // //print('<<<<<<>>>>>>>$value');
                        ),
                        Text(
                          'Female',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return 'Please fill this field';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => Data.phone = value,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white, width: 2), //starting
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white, width: 2), //onwriting
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(Icons.call, color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),

                  SizedBox(height: 15),
                  TextFormField(
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return 'Please fill this field';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => Data.email = value,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white, width: 2), //starting
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white, width: 2), //onwriting
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(Icons.email, color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(height: 15),

                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,

                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return 'Please fill this field.';
                      } else if (value.length < 6) {
                        return 'Password should be at least of 6 characters';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    // onFieldSubmitted: (value) =>
                    //     FocusScope.of(context).nextFocus(),
                    obscureText: !__passwordVisible1,
                    onChanged: (value) => Data.passwd = value,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          __passwordVisible1
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            __passwordVisible1 = !__passwordVisible1;
                          });
                        },
                      ),

                      labelText: 'Password',
                      // hoverColor: Colors.white,
                      // fillColor: Colors.white,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,

                      labelStyle: TextStyle(color: Colors.white, fontSize: 16),

                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white, width: 2), //starting
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white, width: 2), //onwriting
                        borderRadius: BorderRadius.circular(12),
                      ),

                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return 'Please fill this field';
                      } else if (value != Data.passwd) {
                        return 'Password mismatch';
                      }

                      return null;
                    },
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    autovalidateMode: AutovalidateMode.onUserInteraction,

                    textInputAction: TextInputAction.done,
                    obscureText: !__passwordVisible2,
                    onChanged: (value) => Data.cpasswd = value,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          __passwordVisible2
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            __passwordVisible2 = !__passwordVisible2;
                          });
                        },
                      ),

                      labelText: 'Confirm Password',
                      // hoverColor: Colors.white,
                      // fillColor: Colors.white,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white, width: 2), //starting
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white, width: 2), //onwriting
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(Icons.vpn_key, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 35),
                  SizedBox(
                    height: 38,
                    width: double.infinity,
                    child: new MaterialButton(
                      child: setUpButtonChild(),
                      color: Colors.redAccent,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          if (Data.passwd == Data.cpasswd) {
                            //print(
                            // '<<<<<<<<PSM>>>>>>>>Register Button Clicked !!!');
                            _state = 0;
                            setState(() {
                              if (_state == 0) {
                                animateButton();
                              }
                            });
                            RegisterAndSendEmailVerification();
                          } else {
                            Data.showToast(
                                "Password do not match with confirm Pasword!");
                          }
                        } else {
                          Data.showToast('Please fill all fields');
                        }
                      },
                      textColor: Colors.white,
                      elevation: 6,
                      splashColor: Colors.orange,
                      //minWidth: double.infinity,
                      height: 68.0,
                      // color: Data.primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },

                    child: Text(
                      'Have an Account? Sign In Here',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                          // color: Data.primaryColor),
                          ),
                    ),
                    // ],
                  ),
                ],
              ),
            ),
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
