import 'package:brts/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

import 'package:flutter/services.dart';

class mo_bus extends StatefulWidget {
  @override
  _mo_busState createState() => _mo_busState();
}

class _mo_busState extends State<mo_bus> {
  List bus_no = [];
  List side = [];
  List time = [];
  Timestamp t;
  int direction;
  int status = 0;
  String title;
  DateTime date = DateTime.now();
  var _formKey = GlobalKey<FormState>();
  TimeOfDay time1 = new TimeOfDay.now();
  TextEditingController control1;

  Future _selecttime(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: new DateTime(2021),
      lastDate: new DateTime(2300),
    );
    final TimeOfDay pickedtime = await showTimePicker(
      context: context,
      initialTime: time1,
    );
    // if (picked != null && picked != date) {
    setState(() {
      date = picked;
    });
    // }
    // if (pickedtime != null && pickedtime != time) {
    setState(() {
      time1 = pickedtime;
      date = new DateTime(
          picked.year, picked.month, picked.day, time1.hour, time1.minute);
      print("finalized date : $date");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modify bus"),
        backgroundColor: Colors.yellow[800],
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          try {
            if (snapshot.hasData) {
              if (bus_no.length > 0) {
                print("...........$bus_no");
                return ListView(
                  children: [
                    for (int i = 0; i < bus_no.length; ++i)
                      feedback_card(bus_no[i].toString(), time[i], side[i])
                  ],
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Data.loadingDialog();
            } else
              return Center(
                child: Container(
                  child: Text("No buses..."),
                ),
              );
          } catch (e) {
            print(e.toString());
            return Text("hi exception....");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          splashColor: Colors.redAccent,
          backgroundColor: Colors.yellow[800],
          elevation: 20,
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                    child: AlertDialog(
                      title: Text('New Bus !'),
                      content: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please fill this field';
                                }

                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  title = value;
                                });
                              },
                              controller: control1,
                              decoration: InputDecoration(hintText: "bus No"),
                            ),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please fill this field';
                                }

                                return null;
                              },
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  direction = value as int;
                                });
                              },
                              controller: control1,
                              decoration: InputDecoration(
                                  hintText: "1 for left side/0 for right side"),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            RaisedButton(
                              color: Colors.redAccent,
                              onPressed: (() {
                                setState(() {
                                  _selecttime(context);
                                });
                              }),
                              child: Text(
                                'Select time of starting',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        RaisedButton(
                            child: Text('Add bus'),
                            color: Colors.yellow[800],
                            onPressed: () async {
                              print("kkk..$direction");
                              if (_formKey.currentState.validate()) {
                                try {
                                  direction == 0
                                      ? await FirebaseFirestore.instance
                                          .collection('right_side')
                                          .doc(title)
                                          .set({
                                          'bus_no': title,
                                          'side': "right",
                                          'start_time': date,
                                        })
                                      : await FirebaseFirestore.instance
                                          .collection('left_side')
                                          .doc(title)
                                          .set({
                                          'bus_no': title,
                                          'side': "left",
                                          'start_time': date,
                                        });
                                  Data.showToast("  Bus Added Successfully..");
                                  Navigator.of(context).pop();
                                } catch (e) {
                                  Data.showToast("Can't add Bus $e ");
                                  print(e);
                                }
                              }
                            })
                      ],
                    ),
                  );
                });
          }),
    );
  }

  bool datafetched = false;
  Future<void> getData() async {
    if (datafetched) return Future.value(true);

    bus_no.clear();
    time.clear();
    side.clear();

    await FirebaseFirestore.instance.collection('left_side').get().then(
          (QuerySnapshot querySnapshot) => {
            querySnapshot.docs.forEach((doc) async {
              try {
                bus_no.add(doc['bus_no']);
                time.add(doc['start_time']);
                side.add(doc['side']);
                print(doc['start_time']);
              } catch (Exception) {
                print("error while fetching..");
              }
            }),
          },
        );

    await FirebaseFirestore.instance.collection('right_side').get().then(
          (QuerySnapshot querySnapshot) => {
            querySnapshot.docs.forEach((doc) async {
              // DateTime d1;
              try {
                bus_no.add(doc['bus_no']);
                time.add(doc['start_time']);
                side.add(doc['side']);
                print(doc['start_time'].toDate().toString());
                // print(left_side[0].runtimeType);
                // print(time[0].runtimeType);
              } catch (Exception) {
                print("error while fetching..");
              }
            }),
          },
        );
    // print(bus_no);
    setState(() {
      datafetched = true;
    });
    return Future.value(10);
  }

  Widget feedback_card(feed, time, dir) {
    print("hi............");
    return Card(
      elevation: 7,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      borderOnForeground: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: ListTile(
          trailing: IconButton(
              onPressed: () async {
                var s = await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Confirm Your Delete'),
                        actions: [
                          RaisedButton(
                            color: Colors.redAccent,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                          ),
                          RaisedButton(
                            color: Colors.greenAccent,
                            onPressed: () async {
                              if (dir == "left") {
                                await FirebaseFirestore.instance
                                    .collection('left_side')
                                    .doc(feed)
                                    .delete();
                              } else if (dir == "right") {
                                await FirebaseFirestore.instance
                                    .collection('right_side')
                                    .doc(feed)
                                    .delete();
                              }
                              Data.showToast('Deleted Successfully');
                              Navigator.of(context).pop();
                            },
                            child: Text('Confirm'),
                          )
                        ],
                      );
                    });

                if (s == "reload")
                  setState(() {
                    datafetched = false;
                  });
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              )),
          title: Row(children: [
            Text(
              "Bus no:",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              feed,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ]),
          subtitle: Column(
            children: [
              if (dir == "left")
                Text(
                  "left Sided",
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18.0),
                )
              else
                Text(
                  "right sided",
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              Text(
                time.toDate().toString(),
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
