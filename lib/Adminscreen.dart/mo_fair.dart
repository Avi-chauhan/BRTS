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
  int fair;
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
          title: new Text("View Feedback"),
          backgroundColor: Colors.yellow[800],
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 3 / 8 - 20,
              ),
              FutureBuilder(
                  future: fetchData(),
                  builder: (context, snapshot) {
                    try {
                      if (snapshot.hasData) {
                        return Text(
                          "fair = " + fair.toString(),
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
                        return AlertDialog(
                          title: Text(
                            "modify fare\nCurrent Fare = " + fair.toString(),
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 19.0),
                          ),
                          content: Column(
                            children: [
                              TextField(
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                onChanged: (value) {
                                  // fair = int.parse(_con.text);
                                  setState(() {
                                    fair = value as int;
                                    temp = value;
                                  });
                                },
                                enableInteractiveSelection: false,
                                controller: _con,
                                decoration:
                                    InputDecoration(hintText: "New Fare"),
                              ),
                              RaisedButton(
                                  child: Text("confirm"),
                                  color: Colors.redAccent,
                                  textColor: Colors.white,
                                  onPressed: () async {
                                    print("faire odddd : " + fair.toString());
                                    await FirebaseFirestore.instance
                                        .collection('fare')
                                        .doc('fare')
                                        .set({'fare': fair});
                                    Data.showToast("fare has been changed");
                                    Navigator.popAndPushNamed(
                                        context, '/mo_fair');
                                  })
                            ],
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
    );
  }

  bool datafetched = false;
  Future<void> fetchData() async {
    if (datafetched) return Future.value(true);
    fair = 0;
    // await FirebaseFirestore.instance.collection('fair').get().then(
    //       (QuerySnapshot querySnapshot) => {
    //         querySnapshot.docs.forEach((doc) async {
    //           try {
    //             fair = doc['fair'];
    //           } catch (Exception) {
    //             print("error while fetching..");
    //           }
    //         }),
    //       },
    //     );
    var a = await FirebaseFirestore.instance
        .collection("fare")
        .doc("fare")
        .get()
        .then((value) => {fair = int.parse(value.get('fare'))});

    setState(() {
      datafetched = true;
    });
    return Future.value(10);
  }
}
