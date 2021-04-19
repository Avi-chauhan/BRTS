import 'dart:async';

// import 'package:brts/initial%20screen/register.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:connectivity/connectivity.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_offline/flutter_offline.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:brts/data.dart';
// import 'package:brts/initial%20screen/login.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/intl.dart';

// import 'package:marquee/marquee.dart';

// class bookticket extends StatefulWidget {
//   @override
//   _bookticketState createState() => _bookticketState();
// }

// class _bookticketState extends State<bookticket> with TickerProviderStateMixin {
//   @override
//   TextEditingController _searchController = TextEditingController();
//   bool fetchOnlyOnce = false;
//   List<String> from = []; // all users
//   Map fromMap = {};
//   List<String> to = []; // all users
//   Map toMap = {};
//   Icon search_icon = Icon(Icons.search);
//   Widget cusSearchBar1 = Text('Origin');
//   Widget cusSearchBar2 = Text('Destination');
//   List fromSearchResult = [];
//   List toSearchResult = [];

//   void initState() {
//     // fetchOnlyOnce = false;
//     _searchController.addListener(_onSearchChanged);
//     super.initState();
//   }

//   void dispose() {
//     super.dispose();
//   }

//   _onSearchChanged() {
//     searchResultsList1();
//     searchResultsList2();
//   }

//   searchResultsList() {
//     List showResults = []; //tmpResult
//     print(
//         'SEARCH-------------------------------------------------${_searchController.text}');

//     // what ever we will want to show in tab is in the show Result

//     if (_searchController.text.trim() != '') {
//       String tmpSearch = _searchController.text.toLowerCase().trim();

//       allUserNames.forEach((element) {
//         if (element.toString().toLowerCase().contains(tmpSearch)) {
//           showResults.add(element.toString());
//         }
//       });
//     } else
//       showResults = allUserNames;

//     // print('TESTING--------------------------------------------$showResults');
//     setState(() {
//       mapSearchResult = showResults;
//       // print('IMPORTANT------------------------$showResults');
//     });
//   }

//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: new AppBar(
//           leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back,
//               color: Colors.black,
//             ),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           title: new Text("Surat BRTS"),
//           backgroundColor: Colors.yellow[800],
//         ),
//         body: bookticketScreen(),
//       ),
//     );
//   }
// }

// class bookticketScreen extends StatefulWidget {
//   @override
//   _bookticketScreenState createState() => _bookticketScreenState();
// }

// class _bookticketScreenState extends State<bookticketScreen> {
//   String to;
//   String from;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // color: Colors.white,
//       child: Column(
//         children: [
//           SizedBox(
//             height: 15,
//           ),
//           Text(
//             "Book a Ticket to ride",
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 20,
//             ),
//           ),
//           SizedBox(
//             height: 25,
//           ),
//           new TextFormField(
//             keyboardType: TextInputType.text,
//             textInputAction: TextInputAction.next,
//             onChanged: (value) => from = value,
//             decoration: InputDecoration(
//               labelText: 'From',
//               labelStyle: TextStyle(color: Colors.black, fontSize: 22),
//               floatingLabelBehavior: FloatingLabelBehavior.auto,
//               enabledBorder: OutlineInputBorder(
//                 borderSide:
//                     BorderSide(color: Colors.black, width: 2), //starting
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               border: OutlineInputBorder(
//                 borderSide:
//                     BorderSide(color: Colors.black, width: 2), //onwriting
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               prefixIcon: Icon(Icons.location_city, color: Colors.black),
//             ),
//           ),
//           SizedBox(
//             height: 25,
//           ),
//           new TextFormField(
//             keyboardType: TextInputType.text,
//             textInputAction: TextInputAction.next,
//             onChanged: (value) => to = value,
//             decoration: InputDecoration(
//               labelText: 'To',
//               labelStyle: TextStyle(color: Colors.black, fontSize: 22),
//               floatingLabelBehavior: FloatingLabelBehavior.auto,
//               enabledBorder: OutlineInputBorder(
//                 borderSide:
//                     BorderSide(color: Colors.black, width: 2), //starting
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               border: OutlineInputBorder(
//                 borderSide:
//                     BorderSide(color: Colors.black, width: 2), //onwriting
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               prefixIcon: Icon(Icons.location_city, color: Colors.black),
//             ),
//           ),
//           SizedBox(height: 25),
//           RaisedButton(
//             onPressed: () => {},
//             color: Colors.redAccent,
//             textColor: Colors.white,
//             child: Text("Find Bus"),
//           )
//         ],
//       ),
//     );
//   }
// }
