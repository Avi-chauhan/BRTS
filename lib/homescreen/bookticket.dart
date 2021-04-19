import 'dart:async';

import 'package:brts/initial%20screen/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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

import 'package:marquee/marquee.dart';

class bookticket extends StatefulWidget {
  @override
  _bookticketState createState() => _bookticketState();
}

class _bookticketState extends State<bookticket> {
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
        body: bookticketScreen(),
      ),
    );
  }
}

class bookticketScreen extends StatefulWidget {
  @override
  _bookticketScreenState createState() => _bookticketScreenState();
}

class _bookticketScreenState extends State<bookticketScreen>
    with TickerProviderStateMixin {
  // String to;
  // String from;
  TextEditingController _searchController1 = TextEditingController();
  TextEditingController _searchController2 = TextEditingController();

  bool fetchOnlyOnce = false;
  List<String> from = []; // all users
  Map fromMap = {};
  List<String> to = []; // all users
  Map toMap = {};
  Icon search_icon1 = Icon(Icons.search);
  Icon search_icon2 = Icon(Icons.search);
  Widget cusSearchBar1 = Text('Origin');
  Widget cusSearchBar2 = Text('Destination');
  List fromSearchResult = [];
  List toSearchResult = [];

  void initState() {
    fetchOnlyOnce = false;
    _searchController1.addListener(_onSearchChanged1);
    _searchController2.addListener(_onSearchChanged2);
    // _searchController1.text = '';
    // _searchController2.text = '';
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  _onSearchChanged1() {
    searchResultsList1();
  }

  _onSearchChanged2() {
    searchResultsList2();
  }

  searchResultsList1() {
    List showResults = []; //tmpResult
    print(
        'SEARCH-------------------------------------------------${_searchController1.text}');

    // what ever we will want to show in tab is in the show Result

    if (_searchController1.text.trim() != '') {
      String tmpSearch = _searchController1.text.toLowerCase().trim();

      from.forEach((element) {
        if (element.toString().toLowerCase().contains(tmpSearch)) {
          showResults.add(element.toString());
        }
      });
    } else
      showResults = from;

    // print('TESTING--------------------------------------------$showResults');
    setState(() {
      fromSearchResult = from;
      // print('IMPORTANT------------------------$showResults');
    });
  }

  searchResultsList2() {
    List showResults = []; //tmpResult
    print(
        'SEARCH-------------------------------------------------${_searchController2.text}');

    // what ever we will want to show in tab is in the show Result

    if (_searchController2.text.trim() != '') {
      String tmpSearch = _searchController2.text.toLowerCase().trim();

      to.forEach((element) {
        if (element.toString().toLowerCase().contains(tmpSearch)) {
          showResults.add(element.toString());
        }
      });
    } else
      showResults = to;

    // print('TESTING--------------------------------------------$showResults');
    setState(() {
      toSearchResult = showResults;
      // print('IMPORTANT------------------------$showResults');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              "Book a Ticket to ride",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          SizedBox(
            width: 280,
            child: TextFormField(
              cursorColor: Colors.black,
              controller: _searchController1,
              autofocus: true,
              textInputAction: TextInputAction.go,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: "From",
                suffixIcon: Icon(Icons.search),
              ),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
          ),
          SizedBox(height: 25),
          SizedBox(
            width: 280,
            child: TextFormField(
              cursorColor: Colors.black,
              controller: _searchController2,
              autofocus: true,
              textInputAction: TextInputAction.go,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "To",
                  suffixIcon: Icon(Icons.search)),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
          ),
          SizedBox(height: 25),
          RaisedButton(
            onPressed: () => {},
            color: Colors.redAccent,
            textColor: Colors.white,
            child: Text("Find Bus"),
          )
        ],
      ),
    );
  }
}
