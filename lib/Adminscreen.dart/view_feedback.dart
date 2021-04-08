import 'package:brts/data.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class view_feedback extends StatefulWidget {
  @override
  _view_feedbackState createState() => _view_feedbackState();
}

class _view_feedbackState extends State<view_feedback> {
  List feedback_list = [];
  List user_phone = [];
  CollectionReference feedback =
      FirebaseFirestore.instance.collection('feedback');
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
          body: FutureBuilder(
              future: feedback.doc().all,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic> data = snapshot.data.data();
                  feedback_list.add(data['comment']);
                  user_phone.add(data['phone']);
                  print("data added");
                  if (feedback_list.length > 0) {
                    print("...........$feedback_list");

                    return ListView(
                      children: [
                        for (int i = 0; i < feedback_list.length; ++i)
                          feedback_card(feedback_list[i], user_phone[i]),
                      ],
                    );
                  }
                }
                return Center(
                  child: Container(
                    child: Text("No feedbacks..."),
                  ),
                );
              })),
    );
  }

  Future<void> fetchData() async {
    await FirebaseFirestore.instance.collection('feedback').get().then(
          (QuerySnapshot querySnapshot) => {
            querySnapshot.docs.forEach((doc) async {
              try {
                var a = await FirebaseFirestore.instance
                    .collection('users')
                    .doc(doc['user_id'])
                    .get();
                feedback_list.add(doc['comment']);
                user_phone.add(a.data()['email']);

                // print();
              } catch (Exception) {
                print("error while fetching..");
              }
            }),
          },
        );
    return Future.value(10);
  }

  Widget feedback_card(feed, phone) {
    // print("hi............");
    return Card(
      elevation: 7,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      borderOnForeground: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: ListTile(
          title: Text(
            feed,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          subtitle: Text(
            phone,
            maxLines: 1,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}
