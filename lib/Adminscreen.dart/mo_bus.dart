import 'package:brts/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class mo_bus extends StatefulWidget {
  @override
  _mo_busState createState() => _mo_busState();
}

class _mo_busState extends State<mo_bus> {
  List bus_no = [];
  List left_side = [];
  List time = [];
  Timestamp t;
  int direction;
  String title;
  TextEditingController control1;
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
                      feedback_card(bus_no[i].toString(), time[i].toString(),
                          left_side[i])
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
                  return AlertDialog(
                    title: Text('New Bus !'),
                    content: Column(
                      children: [
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              title = value;
                            });
                          },
                          controller: control1,
                          decoration: InputDecoration(hintText: "bus No"),
                        ),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              direction = value as int;
                            });
                          },
                          controller: control1,
                          decoration: InputDecoration(
                              hintText: "1 for left side/0 for right side"),
                        ),
                        TextField(
                          controller: control1,
                          decoration: InputDecoration(hintText: "time"),
                          onChanged: (value) {
                            setState(() {
                              t = value as Timestamp;
                            });
                          },
                        ),
                      ],
                    ),
                    actions: [
                      RaisedButton(
                          child: Text('Add bus'),
                          color: Colors.yellow[800],
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('station')
                                .doc(title)
                                .set({
                              'name': title,
                            });
                            Data.showToast("bus Added Successfully..");
                            Navigator.popAndPushNamed(context, '/mo_bus');
                          })
                    ],
                  );
                });
          }),
    );
  }

  bool datafetched = false;
  Future<void> getData() async {
    if (datafetched) return Future.value(true);
    {
      bus_no.clear();
      time.clear();
      left_side.clear();
    }
    await FirebaseFirestore.instance.collection('left_side').get().then(
          (QuerySnapshot querySnapshot) => {
            querySnapshot.docs.forEach((doc) async {
              try {
                bus_no.add(doc['bus_no']);
                time.add(doc['start_time']);
                left_side.add(doc['left_side']);
              } catch (Exception) {
                print("error while fetching..");
              }
            }),
          },
        );

    await FirebaseFirestore.instance.collection('right_side').get().then(
          (QuerySnapshot querySnapshot) => {
            querySnapshot.docs.forEach((doc) async {
              try {
                bus_no.add(doc['bus_no']);
                time.add(doc['start_time']);
                left_side.add(doc['left_side']);
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
              onPressed: () {
                showDialog(
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
                              if (dir == 1) {
                                await FirebaseFirestore.instance
                                    .collection('left_side')
                                    .doc(feed)
                                    .delete();
                                Data.showToast('Deleted Successfully');
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => mo_bus()),
                                );
                              } else {
                                await FirebaseFirestore.instance
                                    .collection('right_side')
                                    .doc(feed)
                                    .delete();
                                Data.showToast('Deleted Successfully');
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => mo_bus()),
                                );
                              }
                            },
                            child: Text('Confirm'),
                          )
                        ],
                      );
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
              if (dir == 1)
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
                time,
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
