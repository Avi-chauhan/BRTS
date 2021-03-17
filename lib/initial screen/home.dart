import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:marquee/marquee.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Surat Sitilink"),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Text('menu'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('My Trips'),
                onTap: () => {},
              ),
              ListTile(
                title: Text('Notifications'),
                onTap: () => {},
              ),
              ListTile(
                title: Text('Feedback'),
                onTap: () => {},
              ),
              ListTile(
                title: Text('Contact Us'),
                onTap: () => {},
              ),
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
    return DateFormat('MM/dd/yyyy\nhh:mm:ss').format(dateTime);
  }

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          new Container(
            height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.width,
            child: Stack(alignment: Alignment.center, children: [
              Image.asset(
                'images/cloud.jpg',
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
                height: 200,
              ),
              Marquee(
                text: "Welcome to Sitilink",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                blankSpace: 20.0,
                velocity: 100.0,
                pauseAfterRound: Duration(seconds: 1),
                startPadding: 10.0,
                accelerationDuration: Duration(seconds: 1),
                accelerationCurve: Curves.linear,
                decelerationDuration: Duration(milliseconds: 500),
                decelerationCurve: Curves.easeOut,
              ),
              Row(children: [
                SizedBox(
                  width: 125,
                ),
                Icon(
                  Icons.access_time_outlined,
                  size: 24.0,
                ),
                Text(
                  _timeString,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
            ]),
          ),
          Container(
            height: 500,
            child: GridView.count(
              crossAxisCount: 2,
              scrollDirection: Axis.vertical,
              children: [
                new Container(
                  height: 200,
                  child: new Card(
                    elevation: 10.0,
                    child: Text("Trip Planner"),
                  ),
                ),
                new Container(
                  height: 200,
                  child: new Card(
                    elevation: 10.0,
                    child: Text("Trip Planner"),
                  ),
                ),
                new Container(
                  height: 200,
                  child: new Card(
                    elevation: 10.0,
                    child: Text("Trip Planner"),
                  ),
                ),
                new Container(
                  height: 200,
                  child: new Card(
                    elevation: 10.0,
                    child: Text("Trip Planner"),
                  ),
                ),
                new Container(
                  height: 200,
                  child: new Card(
                    elevation: 10.0,
                    child: Text("Trip Planner"),
                  ),
                ),
                new Container(
                  height: 200,
                  child: new Card(
                    elevation: 10.0,
                    child: Text("Trip Planner"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
