import 'package:brts/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class mo_station extends StatefulWidget {
  @override
  _mo_stationState createState() => _mo_stationState();
}

class _mo_stationState extends State<mo_station> {
  List station_list = [];
  String title;
  TextEditingController control1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modify Stations"),
        backgroundColor: Colors.yellow[800],
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          try {
            if (snapshot.hasData) {
              if (station_list.length > 0) {
                print("...........$station_list");
                return ListView(
                  children: [
                    for (int i = 0; i < station_list.length; ++i)
                      feedback_card(station_list[i]),
                  ],
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Data.loadingDialog();
            } else
              return Center(
                child: Container(
                  child: Text("No Stations..."),
                ),
              );
          } catch (e) {
            Text("hi exception....");
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
                    title: Text('New Station !'),
                    content: TextField(
                      onChanged: (value) {
                        setState(() {
                          title = value;
                        });
                      },
                      controller: control1,
                      decoration: InputDecoration(hintText: "name"),
                    ),
                    actions: [
                      RaisedButton(
                          child: Text('Add Station'),
                          color: Colors.yellow[800],
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('station')
                                .doc(title)
                                .set({
                              'name': title,
                            });
                            Data.showToast("Station Added Successfully..");
                            Navigator.popAndPushNamed(context, '/mo_station');
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
    station_list.clear();

    await FirebaseFirestore.instance.collection('station').get().then(
          (QuerySnapshot querySnapshot) => {
            querySnapshot.docs.forEach((doc) async {
              try {
                station_list.add(doc['name']);
              } catch (Exception) {
                print("error while fetching..");
              }
            }),
          },
        );
    setState(() {
      datafetched = true;
    });
    return Future.value(10);
  }

  Widget feedback_card(feed) {
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
                              await FirebaseFirestore.instance
                                  .collection('station')
                                  .doc(feed)
                                  .delete();
                              Data.showToast('Deleted Successfully');
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => mo_station()),
                              );
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
          title: Text(
            feed,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}
