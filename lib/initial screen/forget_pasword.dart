import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data.dart';
// import 'package:pms_apc/ScreenSplashes/Data.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String email;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[800],
        title: Text('Reset Password'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return 'Please fill this field';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'E-Mail',
                      labelStyle:
                          TextStyle(color: Colors.yellow[800], fontSize: 16),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      prefixIcon: Icon(
                        Icons.email_sharp,
                        color: Colors.yellow[800],
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.yellow[800], width: 2), //starting
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.yellow[800], width: 2), //onwriting
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (val) {
                      email = val;
                    },
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    height: 38,
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            Data.showToast(
                                'Link for Password Reset is SENT to $email');
                            Navigator.pop(context);
                            // FirebaseAuth.instance
                            //     .sendPasswordResetEmail(email: email);
                          });
                        }
                      },
                      color: Colors.redAccent,
                      textColor: Colors.white,
                      elevation: 6,
                      child: Text(
                        'Send Link to Email',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  // Button Pressed......................................................................
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
