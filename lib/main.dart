import 'package:brts/Adminscreen.dart/Adminhome.dart';
import 'package:brts/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data.dart';
import 'initial screen/login.dart';
import 'initial screen/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  try {
    Data.getUid();
    if (FirebaseAuth.instance.currentUser.emailVerified == false) {
      Data.showToast('Please Verify your E-Mail Address');
      Data.start = Login();
    } else {
      var a = await FirebaseFirestore.instance
          .collection("users")
          .doc(Data.getUid())
          .get();
      var b;
      b = a.data()['name'];
      if (b != 'Admin')
        Data.start = Home();
      else
        Data.start = Admin();
    }
  } catch (e) {
    Data.start = Login();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BRTS ONLINE',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/', //this is an starting point of our application
      routes: routes, //all routes are stored in file 'Data.dart'
    );
  }
}
