import 'package:brts/data.dart';
// import 'package:cloud_firestore_web/cloud_firestore_web.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class mo_fair extends StatefulWidget {
  @override
  _mo_fairState createState() => _mo_fairState();
}

class _mo_fairState extends State<mo_fair> {
  String fair;
  String temp;
  TextEditingController _con;
  // // @override
  // @override
  // void initState() {
  //   super.initState();
  //   _con = new TextEditingController(text: "Current Fair = " + fair.toString());
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: new AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: new Text("Modify Fair"),
          backgroundColor: Colors.yellow[800],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                    future: fetchData(),
                    builder: (context, snapshot) {
                      try {
                        if (snapshot.hasData) {
                          return Text(
                            "Current Fair = " + fair,
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Data.loadingDialog();
                        } else
                          return Center(
                            child: Container(
                              child: Text("No fair..."),
                            ),
                          );
                      } catch (e) {
                        return Container(child: Text("hi exception...."));
                      }
                    }),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SingleChildScrollView(
                            child: AlertDialog(
                              title: Text(
                                "Modify fare\nCurrent Fare = " + fair,
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19.0),
                              ),
                              content: Column(
                                children: [
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      setState(() {
                                        fair = value;
                                      });
                                    },
                                    // enableInteractiveSelection: false,
                                    // controller: _con,
                                    decoration:
                                        InputDecoration(hintText: "New Fare"),
                                  ),
                                  RaisedButton(
                                      child: Text("confirm"),
                                      color: Colors.redAccent,
                                      textColor: Colors.white,
                                      onPressed: () async {
                                        print("Fair added : " + fair);
                                        await FirebaseFirestore.instance
                                            .collection('fair')
                                            .doc('fair')
                                            .set({'fair': fair});
                                        Data.showToast(
                                            "Fair has been changed Successfully...");
                                        Navigator.of(context).pop();
                                      })
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Text("modify fair"),
                  color: Colors.redAccent,
                  textColor: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool datafetched = false;
  Future<void> fetchData() async {
    if (datafetched) return Future.value(true);
    var a =
        await FirebaseFirestore.instance.collection("fair").doc("fair").get();
    fair = await a.data()['fair'];

    setState(() {
      datafetched = true;
    });
    return Future.value(10);
  }
}
