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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:marquee/marquee.dart';
import 'package:brts/drawerscreen/feedback.dart';
import 'package:brts/drawerscreen/mytransaction.dart';
import 'package:brts/drawerscreen/mytrips.dart';

class contactus extends StatefulWidget {
  @override
  _contactusState createState() => _contactusState();
}

class _contactusState extends State<contactus> {
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
        body: ContactusScreen(),
      ),
    );
  }
}

class ContactusScreen extends StatelessWidget {
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: Column(
        children: [
          Center(
              child: Text(
            "Welcome to BRTS",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )),
          SizedBox(
            height: 15,
          ),
          Text(
            "AJR private solutions limited",
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 18,
              fontFamily: 'RobotoMono',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "we are the leading company for providing the solutions of the realistc life problem, we are mainly foucsing the how to prevent the spreading of the covid-19 and how to make india self reliable to the globally on the software solution.",
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 15),
          ),
          Text("For any queries please write on "),
          SizedBox(
            height: 1,
          ),
          SizedBox(height: 15),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.email),
            Text("ajrprivatesolution@gmail.com")
          ]),
          SizedBox(height: 15),
          Text("Thank you"),
          SizedBox(height: 15),
          Text("follow us on"),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  child: Icon(FontAwesomeIcons.instagram),
                  onTap: () {
                    launchURL("https://www.instagram.com/jaymangukiya0001/");
                  }),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                  child: Icon(FontAwesomeIcons.facebook),
                  onTap: () {
                    launchURL("https://www.twitter.com/jaymangukiya0001/");
                  }),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                  child: Icon(FontAwesomeIcons.twitter),
                  onTap: () {
                    launchURL("https://www.facebook.com/jaymangukiya0001/");
                  }),
            ],
          ),
          SizedBox(height: 15),
          Text("Copyrights 2020 @AJR Private soltuin limited"),
        ],
      ),
    );
  }
}
