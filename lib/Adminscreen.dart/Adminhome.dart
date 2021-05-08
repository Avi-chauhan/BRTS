import 'package:brts/Adminscreen.dart/mo_station.dart';
import 'package:brts/data.dart';
import 'package:brts/initial%20screen/login.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:marquee/marquee.dart';
import 'package:brts/Adminscreen.dart/map.dart';
import 'package:brts/Adminscreen.dart/view_feedback.dart';
import 'package:brts/AdminScreen.dart/mo_bus.dart';
import 'package:brts/Adminscreen.dart/mo_fair.dart';

class Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Welcome Admin !"),
          backgroundColor: Colors.yellow[800],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Text(
                  'Profile',
                  style: TextStyle(fontSize: 30),
                ),
                decoration: BoxDecoration(
                  color: Colors.yellow[800],
                ),
              ),
              ListTile(
                title: Text('View Feedback'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => view_feedback()));
                },
              ),
              ListTile(
                  title: Text('Logout'),
                  onTap: () => {
                        showDialog(
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Confirm Logout ?'),
                              actions: [
                                RaisedButton(
                                  color: Colors.yellow[800],
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                RaisedButton(
                                  color: Colors.redAccent,
                                  child: Text('Confirm'),
                                  onPressed: () {
                                    FirebaseAuth.instance.signOut();
                                    Data.showToast('Logout...');
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()),
                                        (route) => false);
                                  },
                                ),
                              ],
                            );
                          },
                          context: context,
                        ),
                      }),
            ],
          ),
        ),
        body: AdminPageScreen(),
      ),
    );
  }
}

class AdminPageScreen extends StatefulWidget {
  @override
  _AdminPageScreenState createState() => _AdminPageScreenState();
}

class _AdminPageScreenState extends State<AdminPageScreen> {
  String _timeString;
  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy\nhh:mm:ss').format(dateTime);
  }

  DateTime current;
  Future<bool> popped() {
    DateTime now = DateTime.now();
    if (current == null || now.difference(current) > Duration(seconds: 2)) {
      current = now;
      Data.showToast1('Press back again to exit!');
      return Future.value(false);
    } else {
      Fluttertoast.cancel();
      return Future.value(true);
    }
  }

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => popped(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                SingleChildScrollView(
                  child: SafeArea(
                    child: Container(
                      height: 800,
                      child: GridView.count(
                        crossAxisCount: 2,
                        scrollDirection: Axis.vertical,
                        children: [
                          new Container(
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: new Card(
                                color: Colors.yellow[800],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(17),
                                ),
                                elevation: 8.0,
                                child: SafeArea(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      mo_station()));
                                        },
                                        child: Container(
                                            height: 140,
                                            child: Icon(
                                              Icons.add_road,
                                              color: Colors.red,
                                              size: 70,
                                            )),
                                      ),
                                      Text(
                                        "Modify stations",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          new Container(
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: new Card(
                                color: Colors.yellow[800],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(17),
                                ),
                                elevation: 8.0,
                                child: SafeArea(
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 140,
                                          child: Icon(
                                            Icons.date_range,
                                            color: Colors.red,
                                            size: 70,
                                          )),
                                      Text(
                                        "Modify Schedule",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          new Container(
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: new Card(
                                color: Colors.yellow[800],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(17),
                                ),
                                elevation: 8.0,
                                child: SafeArea(
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 140,
                                          child: Icon(
                                            Icons.edit_location,
                                            color: Colors.red,
                                            size: 70,
                                          )),
                                      Text(
                                        "Modify Routes",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          new Container(
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: new Card(
                                color: Colors.yellow[800],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(17),
                                ),
                                elevation: 8.0,
                                child: SafeArea(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          mo_bus()));
                                        },
                                        child: Container(
                                            height: 140,
                                            child: Icon(
                                              Icons.directions_bus,
                                              color: Colors.red,
                                              size: 70,
                                            )),
                                      ),
                                      Text(
                                        "Modify Bus",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          new Container(
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: new Card(
                                color: Colors.yellow[800],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(17),
                                ),
                                elevation: 8.0,
                                child: SafeArea(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      mo_fair()));
                                        },
                                        child: Container(
                                            height: 140,
                                            child: Icon(
                                              Icons.attach_money,
                                              color: Colors.red,
                                              size: 70,
                                            )),
                                      ),
                                      Text(
                                        "Modify Fair",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => map()));
                            },
                            child: new Container(
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: new Card(
                                  color: Colors.yellow[800],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17),
                                  ),
                                  elevation: 8.0,
                                  child: SafeArea(
                                    child: Column(
                                      children: [
                                        Container(
                                            height: 140,
                                            child: Icon(
                                              Icons.map,
                                              color: Colors.red,
                                              size: 70,
                                            )),
                                        Text(
                                          "Surat Map",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
