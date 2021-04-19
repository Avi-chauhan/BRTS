import 'package:brts/data.dart';
import 'package:brts/drawerscreen/mytrips.dart';
import 'package:brts/homescreen/bookticket.dart';
import 'package:brts/homescreen/myroutes.dart';
import 'package:brts/homescreen/mytickets.dart';
import 'package:brts/homescreen/schedule.dart';
import 'package:brts/homescreen/stops.dart';
import 'package:brts/homescreen/suratmap.dart';
import 'package:brts/drawerscreen/contactus.dart';
import 'package:brts/drawerscreen/feedback.dart';
import 'package:brts/drawerscreen/mytransaction.dart';
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

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: new AppBar(
          title: new Text("Surat BRTS"),
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
                title: Text('My Trips'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => mytrips()));
                },
              ),
              ListTile(
                title: Text('My Transactions'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => mytransaction()));
                },
              ),
              ListTile(
                title: Text('Feedback'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => feedback()));
                },
              ),
              ListTile(
                title: Text('Contact Us'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => contactus()));
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
        body: HomePageScreen(),
      ),
    );
  }
}

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
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
                new Container(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width,
                  child: SafeArea(
                    child: Stack(alignment: Alignment.center, children: [
                      Image.asset(
                        'images/cloud.jpg',
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                      ),
                      Marquee(
                        text: "Welcome To BRTS",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        scrollAxis: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        blankSpace: 10.0,
                        velocity: 100.0,
                        pauseAfterRound: Duration(seconds: 0),
                        startPadding: 10.0,
                        accelerationDuration: Duration(seconds: 1),
                        accelerationCurve: Curves.bounceOut,
                        decelerationDuration: Duration(milliseconds: 500),
                        decelerationCurve: Curves.easeOut,
                      ),
                      SafeArea(
                        child: Row(children: [
                          SizedBox(
                            width: 200,
                          ),
                          Icon(
                            Icons.access_time_outlined,
                            size: 34.0,
                            color: Colors.black,
                          ),
                          Text(
                            _timeString,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ]),
                      ),
                    ]),
                  ),
                ),
                SingleChildScrollView(
                  child: SafeArea(
                    child: Container(
                      height: 420,
                      child: GridView.count(
                        crossAxisCount: 2,
                        scrollDirection: Axis.vertical,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => bookticket()));
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
                                              Icons.book_online,
                                              color: Colors.red,
                                              size: 70,
                                            )),
                                        Text(
                                          "Book Ticket",
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
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => schedule()));
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
                                              Icons.calendar_today,
                                              color: Colors.red,
                                              size: 70,
                                            )),
                                        Text(
                                          "Schedule",
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
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => stops()));
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
                                              Icons.room,
                                              color: Colors.red,
                                              size: 70,
                                            )),
                                        Text(
                                          "Stops",
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
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => mytickets()));
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
                                              Icons.confirmation_number,
                                              color: Colors.red,
                                              size: 70,
                                            )),
                                        Text(
                                          "My Tickets",
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
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => myroutes()));
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
                                              Icons.star,
                                              color: Colors.red,
                                              size: 70,
                                            )),
                                        Text(
                                          "My Routes",
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
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => suratmap()));
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
